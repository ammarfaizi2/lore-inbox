Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318299AbSG3OcJ>; Tue, 30 Jul 2002 10:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318298AbSG3OcJ>; Tue, 30 Jul 2002 10:32:09 -0400
Received: from avscan1.sentex.ca ([199.212.134.11]:10246 "EHLO
	avscan1.sentex.ca") by vger.kernel.org with ESMTP
	id <S318297AbSG3OcH>; Tue, 30 Jul 2002 10:32:07 -0400
Message-ID: <008801c237d6$8b7dc640$294b82ce@connecttech.com>
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "Matthew Wilcox" <willy@debian.org>, "Russell King" <rmk@arm.linux.org.uk>,
       <greg@kroah.com>
Cc: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.linuxppc.org>
References: <20020729040824.GA2351@zax> <20020729100009.A23843@flint.arm.linux.org.uk> <20020729144408.GA11206@opus.bloom.county> <20020729181702.E25451@flint.arm.linux.org.uk> <20020729231927.D3317@parcelfarce.linux.theplanet.co.uk>
Subject: Re: [parisc-linux] 3 Serial issues up for discussion (was: Re: Serial core problems on embedded PPC)
Date: Tue, 30 Jul 2002 10:36:51 -0400
Organization: Connect Tech Inc.
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox" <willy@debian.org>
> I'm not.  All the issues you mention below go away if we make the rule
> that _all_ serial ports are /dev/ttyS*.  Userspace can have symlinks to
> ease the transition if necessary.

I agree.

> but we should be able to reclaim:
>
> Chase serial card (major 17/18), the Cyclades (major 19/20), Digiboard
> (major 22/23), Stallion (major 24/25), Specialix (32/33), isdn4linux
> (43/44), Comtrol (46/47), SDL RISCom (48/49), Hayes (57/58), Computone
> (71/72), Specialix (75/76), PAM (78/79), Comtrol VS (105/106), ISI
> (112/113), Technology Concepts (148/149), Specialix RIO (154/155/156/157),
> Chase Research (164/165), ACM (166/167), Moxa (172/173), SmartIO
> (174/175), USB (188/189), Low-density misc serial ports (204/205),
> userspace (208/209) BlueTooth (216/217), A2232 (224/225) ... holy crap,
> that's a lot of char dev space ;-)  52 majors.. think what those must
> be worth on the open market ;-)

I don't know if reclaiming the USB major is a good idea or not.

..Stu


