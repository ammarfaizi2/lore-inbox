Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318709AbSIHP34>; Sun, 8 Sep 2002 11:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318720AbSIHP34>; Sun, 8 Sep 2002 11:29:56 -0400
Received: from 217-13-24-22.dd.nextgentel.com ([217.13.24.22]:58055 "EHLO
	mail.ihatent.com") by vger.kernel.org with ESMTP id <S318709AbSIHP3z>;
	Sun, 8 Sep 2002 11:29:55 -0400
To: Alan Cox <alan@redhat.com>
Cc: bunk@fs.tum.de (Adrian Bunk), hpj@urpla.net (Hans-Peter Jansen),
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre5-ac4
References: <200209081255.g88CtHJ31280@devserv.devel.redhat.com>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 08 Sep 2002 17:23:01 +0200
In-Reply-To: <200209081255.g88CtHJ31280@devserv.devel.redhat.com>
Message-ID: <m3bs78a4kq.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@redhat.com> writes:

> > Which non-free modues (NVidia?) were loaded on your computer? Is the
> > problem reproducible without any non-free module loaded _ever_ since the
> > last reboot?
> 
> I've seen this trace without nvidia etc loaded too. Right now the problem
> I have is that I can't duplicate it. If my box would jut blow up the same
> way all would be well 8)
> 
> What compilers are being used by the folks who see the problem ?

Bog standard (sic) rawhide, so here we go (still havent rebooted to
the untainted kernel yet):

Linux lapper 2.4.20-pre5-ac4-preempt #1 lør sep 7 22:39:23 CEST 2002 i686 i686 i386 GNU/Linux
 
Gnu C                  3.2
Gnu make               3.79.1
util-linux             2.11r
mount                  2.11r
modutils               2.4.18
e2fsprogs              1.27
jfsutils               1.0.17
reiserfsprogs          3.6.2
pcmcia-cs              3.1.31
PPP                    2.4.1
isdn4k-utils           3.1pre4
Linux C Library        2.2.90
Dynamic linker (ldd)   2.2.90
Procps                 2.0.7
Net-tools              1.60
Kbd                    67:
Sh-utils               2.0.12
Modules Loaded         sg autofs4 vmnet parport_pc parport vmmon nsc-ircc irda ipchains ide-scsi scsi_mod hci_usb bluez bluetooth nls_iso8859-1 ntfs i810_audio soundcore ac97_codec mousedev keybdev hid input ehci-hcd usb-ohci usbcore unix

ttfn,
A
-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
