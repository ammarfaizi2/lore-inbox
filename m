Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266120AbTBPKIi>; Sun, 16 Feb 2003 05:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266175AbTBPKIi>; Sun, 16 Feb 2003 05:08:38 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:36228 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S266120AbTBPKIh>; Sun, 16 Feb 2003 05:08:37 -0500
From: David Woodhouse <dwmw2@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <E18k81g-0007KU-00@the-village.bc.nu>
References: <E18k81g-0007KU-00@the-village.bc.nu>
Organization: 
Message-Id: <1045390711.2068.44.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 16 Feb 2003 10:18:31 +0000
Subject: Re: PATCH: header update for arcnet updates (again to match 2.4)
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-02-15 at 19:31, Alan Cox wrote:
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/include/linux/com20020.h linux-2.5.61-ac1/include/linux/com20020.h
> --- linux-2.5.61/include/linux/com20020.h	2003-02-10 18:37:58.000000000 +0000
> +++ linux-2.5.61-ac1/include/linux/com20020.h	2003-02-14 23:32:27.000000000 +0000
> @@ -32,7 +32,7 @@
>  void com20020_remove(struct net_device *dev);
>  
>  /* The number of low I/O ports used by the card. */
> -#define ARCNET_TOTAL_SIZE 9
> +#define ARCNET_TOTAL_SIZE 8

Er, is this definitely right?

Don't we often have the hardware address in a set of DIP switches at
ioaddr+8?

-- 
dwmw2

