Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263854AbVBEJrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263854AbVBEJrE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 04:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263026AbVBEJrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 04:47:04 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:8935 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S264354AbVBEJqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 04:46:53 -0500
Subject: Re: [RFC] Reliable video POSTing on resume
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Jon Smirl <jonsmirl@gmail.com>,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Garrett <mjg59@srcf.ucam.org>
In-Reply-To: <20050205093740.GD1158@elf.ucw.cz>
References: <e796392205020221387d4d8562@mail.gmail.com>
	 <420217DB.709@gmx.net> <4202A972.1070003@gmx.net>
	 <20050203225410.GB1110@elf.ucw.cz>
	 <1107474198.5727.9.camel@desktop.cunninghams> <4202DF7B.2000506@gmx.net>
	 <9e47339105020321031ccaabb@mail.gmail.com> <420367CF.7060206@gmx.net>
	 <20050204163019.GC1290@elf.ucw.cz>
	 <9e4733910502040931955f5a6@mail.gmail.com>
	 <20050205093740.GD1158@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1107596950.6348.9.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sat, 05 Feb 2005 20:49:10 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Sat, 2005-02-05 at 20:37, Pavel Machek wrote:
> Hi!
> 
> > > I do not understand how initramfs fits into picture... Plus lot of
> > > people (me :-) do not use initramfs...
> > 
> > The final fix for this will include the video reset app on initramfs.
> > I already have code in the kernel for telling the primary video card
> > from secondary ones. When the kernel is initially booting and finds
> 
> Is initramfs preserved when system is running? I was under impression
> that it is freed when we mount real / fs.

I think the assumption is that it's never unmounted.

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com

Ph: +61 (2) 6292 8028      Mob: +61 (417) 100 574

