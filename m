Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293232AbSBWWdo>; Sat, 23 Feb 2002 17:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293234AbSBWWdd>; Sat, 23 Feb 2002 17:33:33 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9732 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293232AbSBWWdR>;
	Sat, 23 Feb 2002 17:33:17 -0500
Message-ID: <3C7818A8.9815565F@mandrakesoft.com>
Date: Sat, 23 Feb 2002 17:33:12 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-rc4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bongani Hlope <bonganilinux@mweb.co.za>
CC: linux-kernel@vger.kernel.org, fero@drama.obuda.kando.hu,
        kraxel@goldbach.in-berlin.de
Subject: Re: [PATCH] kdev_t compilation fixes (Framebuffer)
In-Reply-To: <1014501626.4293.25.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bongani Hlope wrote:
> --- linux-2.5/drivers/video/riva/fbdev.c        Thu Nov 15 00:52:20 2001
> +++ linux-2.5-dev/drivers/video/riva/fbdev.c    Sat Feb 23 23:35:08 2002
> @@ -1811,7 +1811,7 @@
>         info = &rinfo->info;
> 
>         strcpy(info->modename, rinfo->drvr_name);
> -       info->node = -1;
> +       info->node = NODEV;

This one's already been merged...

-- 
Jeff Garzik      | "UNIX enhancements aren't."
Building 1024    |           -- says /usr/games/fortune
MandrakeSoft     |
