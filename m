Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318072AbSHNA7d>; Tue, 13 Aug 2002 20:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319101AbSHNA7d>; Tue, 13 Aug 2002 20:59:33 -0400
Received: from antigonus.hosting.pacbell.net ([216.100.98.13]:15842 "EHLO
	antigonus.hosting.pacbell.net") by vger.kernel.org with ESMTP
	id <S318072AbSHNA7c>; Tue, 13 Aug 2002 20:59:32 -0400
Reply-To: <imran.badr@cavium.com>
From: "Imran Badr" <imran.badr@cavium.com>
To: "'Ralf Baechle'" <ralf@linux-mips.org>
Cc: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: RE: Cache coherency and snooping
Date: Tue, 13 Aug 2002 18:00:43 -0700
Message-ID: <0aa401c2432e$04a95cc0$9e10a8c0@IMRANPC>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20020814022958.B11645@linux-mips.org>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Please advise if following sequence of operations are going to help:

alloc memory
reserve the page
flush every cache
call ioremap_nocache


Thanks,
Imran.



-----Original Message-----
From: Ralf Baechle [mailto:ralf@linux-mips.org]
Sent: Tuesday, August 13, 2002 5:30 PM
To: Imran Badr
Cc: 'Alan Cox'; linux-kernel@vger.kernel.org
Subject: Re: Cache coherency and snooping


On Tue, Aug 13, 2002 at 05:19:56PM -0700, Imran Badr wrote:

> What if I allocate memory at boot-time using alloc_bootmem*(..)?

That wouldn't change the picture either.

  Ralf

