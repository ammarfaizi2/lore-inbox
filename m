Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318298AbSG3PiS>; Tue, 30 Jul 2002 11:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318300AbSG3PiS>; Tue, 30 Jul 2002 11:38:18 -0400
Received: from avscan1.sentex.ca ([199.212.134.11]:35595 "EHLO
	avscan1.sentex.ca") by vger.kernel.org with ESMTP
	id <S318298AbSG3PiR>; Tue, 30 Jul 2002 11:38:17 -0400
Message-ID: <00f801c237df$d09d4e40$294b82ce@connecttech.com>
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "Matthew Wilcox" <willy@debian.org>
Cc: "Matthew Wilcox" <willy@debian.org>, "Russell King" <rmk@arm.linux.org.uk>,
       <greg@kroah.com>, <linux-kernel@vger.kernel.org>,
       <linuxppc-dev@lists.linuxppc.org>
References: <20020729040824.GA2351@zax> <20020729100009.A23843@flint.arm.linux.org.uk> <20020729144408.GA11206@opus.bloom.county> <20020729181702.E25451@flint.arm.linux.org.uk> <20020729231927.D3317@parcelfarce.linux.theplanet.co.uk> <008801c237d6$8b7dc640$294b82ce@connecttech.com> <20020730161940.P1441@parcelfarce.linux.theplanet.co.uk>
Subject: Re: [parisc-linux] 3 Serial issues up for discussion (was: Re: Serial core problems on embedded PPC)
Date: Tue, 30 Jul 2002 11:43:13 -0400
Organization: Connect Tech Inc.
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox" <willy@debian.org>
> I think you were confused with char major 180 which has
> printers/mice/scanners/etc on it.

No, I was wondering if leaving the USB serial major 18[89] alone would
be a better idea. Since posting, I've been thinking that the usb
serial driver presents the same interface to the tty layer as any
other serial device so I guess it's not a bad idea.

..Stu


