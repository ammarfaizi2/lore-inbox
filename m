Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262102AbVCRXxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262102AbVCRXxl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 18:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262118AbVCRXxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 18:53:41 -0500
Received: from fire.osdl.org ([65.172.181.4]:45699 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262102AbVCRXxe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 18:53:34 -0500
Date: Fri, 18 Mar 2005 15:53:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@suse.cz>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org
Subject: Re: fix-u32-vs-pm_message_t-in-usb
Message-Id: <20050318155313.60a4670f.akpm@osdl.org>
In-Reply-To: <20050318234440.GF24449@elf.ucw.cz>
References: <20050310223353.47601d54.akpm@osdl.org>
	<20050311130831.GC1379@elf.ucw.cz>
	<20050318214335.GA17813@kroah.com>
	<20050318234440.GF24449@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> wrote:
>
> > Care to just rediff off of 2.6.12-rc1?  Then we can hopefully get these
>  > changes in :)
> 
>  I can do the rediff tommorow. I just hope there are not some other
>  changis waiting in -mm to spoil this ;-).

I have a boatload of these darn pm_message_t patches floating about.  I
don't know if they depend on Greg's stuff or not.

Should I just hose them at him?

fix-pm_message_t-in-generic-code.patch
fix-u32-vs-pm_message_t-in-usb.patch
fix-u32-vs-pm_message_t-in-usb-fix.patch
more-pm_message_t-fixes.patch
fix-u32-vs-pm_message_t-confusion-in-oss.patch
fix-u32-vs-pm_message_t-confusion-in-pcmcia.patch
fix-u32-vs-pm_message_t-confusion-in-framebuffers.patch
fix-u32-vs-pm_message_t-confusion-in-mmc.patch
fix-u32-vs-pm_message_t-confusion-in-serials.patch
fix-u32-vs-pm_message_t-in-macintosh.patch
fix-u32-vs-pm_message_t-confusion-in-agp.patch

