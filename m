Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315454AbSGEGUV>; Fri, 5 Jul 2002 02:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315455AbSGEGUU>; Fri, 5 Jul 2002 02:20:20 -0400
Received: from mail.vtc.edu.hk ([202.75.80.229]:7977 "EHLO pandora.vtc.edu.hk")
	by vger.kernel.org with ESMTP id <S315454AbSGEGUT>;
	Fri, 5 Jul 2002 02:20:19 -0400
Message-ID: <3D253B36.BE0BC22@vtc.edu.hk>
Date: Fri, 05 Jul 2002 14:22:46 +0800
From: Nick Urbanik <nicku@vtc.edu.hk>
Organization: Institute of Vocational Education (Tsing Yi)
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-5 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: cmd649 not working with 2 CPU box
References: <Pine.LNX.4.44.0207041128570.21993-100000@netfinity.realnet.co.sz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:

> On Thu, 4 Jul 2002, Nick Urbanik wrote:
>
> > hda: ATAPI CD-ROM DRIVE 50X MAXIMUM, ATAPI CD/DVD-ROM drive
> > hdc: ST360021A, ATA DISK drive
> > hde: ST320420A, ATA DISK drive
> > hde: IRQ probe failed (0xfffffef8)
> > hdf: IRQ probe failed (0xfffffef8)
> > hdf: IRQ probe failed (0xfffffef8)
> > ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> > ide1 at 0x170-0x177,0x376 on irq 15
> > ide2: DISABLED, NO IRQ
> > ^^^^^^^^^^^^^^^^^^^^^^____________Oh dear!!!!
>
> Does booting with noapic change anything?

I still got the same "ide2: DISABLED, NO IRQ" message.  I tried booting with
pirq=0,0,18,0,16 and a number of other combinations (until somone complained
about the server not being available), and only succeeded in disabling the
keyboard at my last permutation; sshed in to reboot.

the PCI slots are like this:

back of main board
|  |  |  |  |  |
|  |  |  |  |  |
|  |  |  |  |  |
e  e  e  e  c  |
m  m  t  m  m  a
p  p  h  p  d  g
t  t  1  t  6  p
y  y     y  4
            9

I think I'll wait till there's less demand for the server, then try booting it
with other kernel parameter values for pirq.

> Cheers,
>         Zwane Mwaikambo

Thank you; I think I may eventually get these things working!

--
Nick Urbanik   RHCE                                  nicku@vtc.edu.hk
Dept. of Information & Communications Technology
Hong Kong Institute of Vocational Education (Tsing Yi)
Tel:   (852) 2436 8576, (852) 2436 8579          Fax: (852) 2436 8526
PGP: 53 B6 6D 73 52 EE 1F EE EC F8 21 98 45 1C 23 7B     ID: 7529555D
GPG: 7FFA CDC7 5A77 0558 DC7A 790A 16DF EC5B BB9D 2C24   ID: BB9D2C24



