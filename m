Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274872AbRJNIb7>; Sun, 14 Oct 2001 04:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274813AbRJNIbu>; Sun, 14 Oct 2001 04:31:50 -0400
Received: from smtp.mailbox.co.uk ([195.82.125.32]:30607 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S274842AbRJNIbr>; Sun, 14 Oct 2001 04:31:47 -0400
Date: Sun, 14 Oct 2001 09:32:16 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Frank Davis <fdavis@si.rr.com>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] 2.4.12-ac1: more MODULE_LICENSE tags, mostly sound
Message-ID: <20011014093216.A30590@flint.arm.linux.org.uk>
In-Reply-To: <3BC90A96.2060509@si.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BC90A96.2060509@si.rr.com>; from fdavis@si.rr.com on Sat, Oct 13, 2001 at 11:46:30PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2001 at 11:46:30PM -0400, Frank Davis wrote:
> --- drivers/sound/waveartist.c.old	Fri Apr 13 23:26:07 2001
> +++ drivers/sound/waveartist.c	Sat Oct 13 23:06:45 2001
> @@ -1812,6 +1812,7 @@
>  
>  module_init(init_waveartist);
>  module_exit(cleanup_waveartist);
> +MODULE_LICENSE("GPL");
>  
>  #ifndef MODULE
>  static int __init setup_waveartist(char *str)

Please don't apply this one - I've got an update pending for the Waveartist
driver which adds this.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

