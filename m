Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265470AbSL1UUX>; Sat, 28 Dec 2002 15:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265608AbSL1UUX>; Sat, 28 Dec 2002 15:20:23 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:128 "EHLO
	muur.intranet.vanheusden.com") by vger.kernel.org with ESMTP
	id <S265470AbSL1UUT>; Sat, 28 Dec 2002 15:20:19 -0500
From: "Folkert van Heusden" <folkert@vanheusden.com>
To: "'John Bradford'" <john@grabjohn.com>,
       "'Stephen Satchell'" <list@fluent2.pyramid.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Want a random entropy source?
Date: Sat, 28 Dec 2002 21:28:24 +0100
Message-ID: <003c01c2aeaf$ac673530$3640a8c0@boemboem>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
In-Reply-To: <200212281600.gBSG0P4r001160@darkstar.example.net>
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I was astonished to see that the resulting signal is a white-noise
> pattern with a slight emphasis at the high end (when sampled at 44
> kilosamples per second). In short, it looks like diode noise with a
> 4 kilohertz square wave thrown in.
> "That suggests to me that this would make a fair source of random samples,
> especially after you slot out the interfering signal.
JB> How can you guarantee that you are sampling noise, though, what if a
JB> sound card was picking up 50 Hz mains hum, for example,  that would
JB> de-randomise the data quite a bit.

Well, the 50hz from the mains isn't a perfect 50hz; it has random (yes)
fluctuations.


