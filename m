Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbWEWVLo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbWEWVLo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 17:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbWEWVLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 17:11:43 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:6051 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932265AbWEWVLn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 17:11:43 -0400
Date: Tue, 23 May 2006 23:11:00 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [-mm] klibc breaks my initscripts
Message-ID: <20060523211100.GA2788@elf.ucw.cz>
References: <20060523083754.GA1586@elf.ucw.cz> <4473482A.3050407@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4473482A.3050407@zytor.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Út 23-05-06 10:36:42, H. Peter Anvin wrote:
> Pavel Machek wrote:
> >Hi!
> >
> >To reproduce: boot with init=/bin/bash
> >
> >attempt to
> >
> >mount / -oremount,rw
> >
> >I have this as my command line:
> >
> >root=/dev/hda4 resume=/dev/hda1 psmouse.psmouse_proto=imps
> >psmouse_proto=imps psmouse.proto=imps vga=1 pci=assign-busses
> >rootfstype=ext2
> >
> >Kernel
> >
> >VERSION = 2
> >PATCHLEVEL = 6
> >SUBLEVEL = 17
> >EXTRAVERSION =-rc4-mm3
> >
> 
> Will look into immediately.
> 
> - a. What distro?

Hacked debian.

> - b. What's the error?

Something about root not being mounted so it can't be remounted.

> - c. Are you using an initrd/initramfs as well?

No.

(Good news is that swsusp seems to work, at least for me.
							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
