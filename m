Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751211AbWHYPSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbWHYPSN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 11:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWHYPSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 11:18:12 -0400
Received: from smarthost1.sentex.ca ([64.7.153.18]:35317 "EHLO
	smarthost1.sentex.ca") by vger.kernel.org with ESMTP
	id S1751211AbWHYPSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 11:18:10 -0400
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "'linux-os \(Dick Johnson\)'" <linux-os@analogic.com>,
       "'Krzysztof Halasa'" <khc@pm.waw.pl>
Cc: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "'David Woodhouse'" <dwmw2@infradead.org>,
       <linux-serial@vger.kernel.org>, "'LKML'" <linux-kernel@vger.kernel.org>
Subject: RE: Serial custom speed deprecated?
Date: Fri, 25 Aug 2006 11:17:42 -0400
Organization: Connect Tech Inc.
Message-ID: <043401c6c859$9c611350$294b82ce@stuartm>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <Pine.LNX.4.61.0608241635090.13499@chaos.analogic.com>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: On Behalf Of linux-os (Dick Johnson)
> But the baud-rates have always been some approximation that starts
> at 75 and increases by powers-of-two. This is because the hardware
> always had fixed clocks with dividers that divided by powers-of-two.
> What is the claim for the requirement of strange baud-rates set
> as an integer of dimension "baud?" Where does this requirement
> come from and what devices use these?

Perhaps you'd like to check out our products
http://www.connecttech.com/

We build a lot of custom boards that have odd clocks to generate very
odd baud rates for random serial devices. The Bxxx style has been a
thorn in my side since 1999.

Also, Oxford's 16PCI95x family has three different points of altering
the clock; the clock prescaler, the actual sample rate (which is the
classic /16 that most are used to), and the actual divisor. That can
produce pretty much any baud rate, albeit with some error.

..Stu

