Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265650AbSL1UpG>; Sat, 28 Dec 2002 15:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265667AbSL1UpF>; Sat, 28 Dec 2002 15:45:05 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:45722 "EHLO
	muur.intranet.vanheusden.com") by vger.kernel.org with ESMTP
	id <S265650AbSL1UpB>; Sat, 28 Dec 2002 15:45:01 -0500
From: "Folkert van Heusden" <folkert@vanheusden.com>
To: "'John Bradford'" <john@grabjohn.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Want a random entropy source?
Date: Sat, 28 Dec 2002 21:53:17 +0100
Message-ID: <004401c2aeb3$26c32f20$3640a8c0@boemboem>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
In-Reply-To: <200212282039.gBSKdGWF001663@darkstar.example.net>
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, the 50hz from the mains isn't a perfect 50hz; it has random (yes)
> fluctuations.
JB> Yes, that's true.
JB> More generally, though, is there any point in this going in to the
JB> mainline kernel, if:
JB> * Most users don't need faster entropy generation than we've got
JB> and
JB> * The entropy gathered from the soundcard is statistically inferior to
JB> that gathered from the current sources of entropy.

Well, there isn't any :o) That's why there's a user-level implementation
for such a beast for those who do need it.
( http://www.vanheusden.com/mirrors/audio-entropyd-0.0.5.tgz )

JB> I don't see how it's possible to guarantee that the data below a
JB> certain dB level from the soundcard is noise.

Some guy contacted me about audio-entropyd and told me he'd done a lot
of analysis on all how this and gave me a few hints how to improve the
quality of what is produced with this tool. A quick fourier-
transformation doesn't really show any peaks.

