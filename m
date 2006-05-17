Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbWEQM61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbWEQM61 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 08:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbWEQM61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 08:58:27 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:37919 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932242AbWEQM60 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 08:58:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=luKxrxLiZNUT/8ZalybZFyBJ964atcdWTQkA0zVaHQ+oRzH7M/fRW2O0aWm7ktEhm5+3lkaMCIC4jSJVtEOFbK/vqQcwtSp+0Xqyo3cfSZ6vmd3Ld3ot6LoPgje9OTr1aR9yByJqGqO4cOO/lNN3RqweNUO5ZKbf0mw3a6UVMxw=
Message-ID: <3b0ffc1f0605170558h5072b407pa4127abe3743553f@mail.gmail.com>
Date: Wed, 17 May 2006 08:58:25 -0400
From: "Kevin Radloff" <radsaq@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata PATA updated patch
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3b0ffc1f0605161303paabdbfk56fe91e4156fe085@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1147796037.2151.83.camel@localhost.localdomain>
	 <3b0ffc1f0605161303paabdbfk56fe91e4156fe085@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/06, Kevin Radloff <radsaq@gmail.com> wrote:
> On 5/16/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > I've put a patch versus -rc4 in the usual place. This should sort out
> > the PIO problems and a few other glitches
> >
> > Alan
> >
> > http://zeniv.linux.org.uk/~alan/IDE
>
> As expected, all seems to be well on my laptop. Thanks! :)

Okay, I was wrong. :( Sometimes the IDE adapter doesn't resume after
unsuspending (suspend to RAM) or something like that. Whatever is
happening the disks are inaccessible though, so it's hard to get the
exact details.

I don't really have the time/motivation to debug that sort of thing in
the middle of the work week though; I'll need to experiment more this
weekend. (And my typical setup also has the -ck kernel patch and the
madwifi drivers)

0000:00:00.0 Host bridge: Intel Corporation 82852/82855 GM/GME/PM/GMV
Processor to I/O Controller (rev 02)
0000:00:00.1 System peripheral: Intel Corporation 82852/82855
GM/GME/PM/GMV Processor to I/O Controller (rev 02)
0000:00:00.3 System peripheral: Intel Corporation 82852/82855
GM/GME/PM/GMV Processor to I/O Controller (rev 02)
0000:00:02.0 VGA compatible controller: Intel Corporation 82852/855GM
Integrated Graphics Device (rev 02)
0000:00:02.1 Display controller: Intel Corporation 82852/855GM
Integrated Graphics Device (rev 02)
0000:00:1d.0 USB Controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 03)
0000:00:1d.1 USB Controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 03)
0000:00:1d.7 USB Controller: Intel Corporation 82801DB/DBM
(ICH4/ICH4-M) USB2 EHCI Controller (rev 03)
0000:00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev 83)
0000:00:1f.0 ISA bridge: Intel Corporation 82801DBM (ICH4-M) LPC
Interface Bridge (rev 03)
0000:00:1f.1 IDE interface: Intel Corporation 82801DBM (ICH4-M) IDE
Controller (rev 03)
0000:00:1f.3 SMBus: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) SMBus Controller (rev 03)
0000:00:1f.5 Multimedia audio controller: Intel Corporation
82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 03)
0000:00:1f.6 Modem: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) AC'97 Modem Controller (rev 03)
0000:01:0a.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev ab)
0000:01:0a.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev ab)
0000:01:0a.2 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394
Controller (rev 03)
0000:01:0a.3 System peripheral: Ricoh Co Ltd R5C576 SD Bus Host Adapter (rev 01)
0000:01:0a.4 System peripheral: Ricoh Co Ltd R5C592 Memory Stick Bus
Host Adapter
0000:01:0c.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
0000:01:0d.0 Ethernet controller: Atheros Communications, Inc. AR5212
802.11abg NIC (rev 01)

-- 
Kevin 'radsaq' Radloff
radsaq@gmail.com
http://thesaq.com/
