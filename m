Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318758AbSHWLDT>; Fri, 23 Aug 2002 07:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318761AbSHWLDT>; Fri, 23 Aug 2002 07:03:19 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:19985 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318758AbSHWLDS>; Fri, 23 Aug 2002 07:03:18 -0400
Date: Fri, 23 Aug 2002 12:07:27 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Andre Hedrick <andre@linux-ide.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Jeff Garzik <jgarzik@mandrakesoft.com>,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: IDE-flash device and hard disk on same controller
Message-ID: <20020823120727.B20963@flint.arm.linux.org.uk>
References: <m1ofbupfe1.fsf@frodo.biederman.org> <Pine.LNX.4.10.10208222016350.13077-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.10.10208222016350.13077-100000@master.linux-ide.org>; from andre@linux-ide.org on Thu, Aug 22, 2002 at 08:19:18PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2002 at 08:19:18PM -0700, Andre Hedrick wrote:
> Oh and it is only useful for borken things like LINBIOS and other
> braindead systems like ARM that violate the 31 second rule of POST.

Umm, there are no such ARM based Linux devices that violate this.
Certainly none using boot loaders I've written.

> RMK, don't take it personally, but ARM is a headache of the nth degree.
> You and I know it, otherwise I would not have a raw TTL IDE PCI card to
> mimic your arch.

You're talking crap here.

That machine doesn't get anywhere near Linux until the drives are fully
up and running.  This is more or less guaranteed since the kernel comes
off its one and only hard drive.  Therefore, by definition the drive
must have completed its diagnostics before Linux boots.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

