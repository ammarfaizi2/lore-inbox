Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292465AbSBPGCO>; Sat, 16 Feb 2002 01:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292453AbSBPGCD>; Sat, 16 Feb 2002 01:02:03 -0500
Received: from 75-223.davnet.com.hk ([202.69.75.223]:55706 "EHLO
	nicksbox.tyict.vtc.edu.hk") by vger.kernel.org with ESMTP
	id <S292437AbSBPGB6>; Sat, 16 Feb 2002 01:01:58 -0500
Message-ID: <3C6DF5D2.30C8D682@vtc.edu.hk>
Date: Sat, 16 Feb 2002 14:01:54 +0800
From: Nick Urbanik <nicku@vtc.edu.hk>
Organization: Institute of Vocational Education (Tsing Yi)
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.18-pre7-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: cmd649 not working with 2 CPU box; what IDE card should I use?
In-Reply-To: <Pine.LNX.4.10.10202151709100.10501-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:

> On Fri, 15 Feb 2002, Nick Urbanik wrote:
>
> > Dear folks,
> >
> > I have tried cmd649 ATA pci cards; they work great with single CPU
> > kernels, not at all with SMP kernels.  The SMP kernel just does not make
> > an entry in /proc/ide.  Some details are in my post on 13 Feb, with
> > subject: cmd649 ok 1 cpu, 2 cpus, not working.  I would appreciate any
> > pointers that may lead to getting them working.
> >
> > So if this is not a common problem, does _anyone_ use ATA cards with SMP
> > boxes?  If so, which ones work?  HPT?
>
> LOL, I had the same question asked to me by CMD and probed to them it
> works.  Obviously you have not configured something correct :-/

Thanks for your reply, Andre.

Okay, this has happened repeatably on two Acer Altos boxes.  Sorry to be so
silly, but I can't think what else I can configure.

The jumper on the disk is set to master, it is plugged into the primary using
an ATA100 cable, the power is on :-)

On the other dual CPU box (using older kernels), I could boot into a single
CPU kernel on the machine, and the disks would work.  Boot into a SMP kernel,
no recognition of the bus in /proc/ide, and fdisk reports the other disks,
but not those plugged into the cmd card.  The cmd64x driver is compiled
directly into the kernel, not loaded as a module.

Any other suggestions?  Where can I find more evidence?  Willing to try
anything!

--
Nick Urbanik   RHCE                                  nicku@vtc.edu.hk
Dept. of Information & Communications Technology
Hong Kong Institute of Vocational Education (Tsing Yi)
Tel:   (852) 2436 8576, (852) 2436 8579          Fax: (852) 2436 8526
PGP: 53 B6 6D 73 52 EE 1F EE EC F8 21 98 45 1C 23 7B     ID: 7529555D
GPG: 7FFA CDC7 5A77 0558 DC7A 790A 16DF EC5B BB9D 2C24   ID: BB9D2C24



