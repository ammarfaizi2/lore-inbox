Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315748AbSEWBki>; Wed, 22 May 2002 21:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315797AbSEWBkh>; Wed, 22 May 2002 21:40:37 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:2315 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315748AbSEWBkg>; Wed, 22 May 2002 21:40:36 -0400
Subject: Re: Quota patches
To: nathans@sgi.com (Nathan Scott)
Date: Thu, 23 May 2002 02:56:43 +0100 (BST)
Cc: jack@suse.cz.com (Jan Kara), hirofumi@mail.parknet.co.jp (OGAWA Hirofumi),
        torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <20020523105947.A186660@wobbly.melbourne.sgi.com> from "Nathan Scott" at May 23, 2002 10:59:47 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17AhqN-0003Kj-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, May 23, 2002 at 09:30:10AM +1000, Nathan Scott wrote:
> > ... but that should just about do the trick I think.
> 
> How does the patch below look Jan?

Doesn't let me select both ?

> +if [ "$CONFIG_QUOTA" = "y" ]; then
> +   define_bool CONFIG_QUOTACTL y
> +   if [ "$CONFIG_QIFACE_COMPAT" = "y" ]; then
> +       choice '    Compatible quota interfaces' \
> +		"Original	CONFIG_QIFACE_V1 \
> +		 VFSv0		CONFIG_QIFACE_V2" Original
> +   fi
>  fi

