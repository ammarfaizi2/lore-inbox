Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264836AbSL1PwX>; Sat, 28 Dec 2002 10:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265423AbSL1PwX>; Sat, 28 Dec 2002 10:52:23 -0500
Received: from [81.2.122.30] ([81.2.122.30]:5125 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S264836AbSL1PwX>;
	Sat, 28 Dec 2002 10:52:23 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200212281600.gBSG0P4r001160@darkstar.example.net>
Subject: Re: Want a random entropy source?
To: list@fluent2.pyramid.net (Stephen Satchell)
Date: Sat, 28 Dec 2002 16:00:25 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5.2.0.9.0.20021228073445.01d386c0@fluent2.pyramid.net> from "Stephen Satchell" at Dec 28, 2002 07:40:29 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I was astonished to see that the resulting signal is a white-noise
> pattern with a slight emphasis at the high end (when sampled at 44
> kilosamples per second). In short, it looks like diode noise with a
> 4 kilohertz square wave thrown in.

> "That suggests to me that this would make a fair source of random samples, 
> especially after you slot out the interfering signal.

How can you guarantee that you are sampling noise, though, what if a
sound card was picking up 50 Hz mains hum, for example,  that would
de-randomise the data quite a bit.

> "How many computers don't have cheap sound cards and CD-ROM drives?"

I have never understood how a 16-bit DAC or ADC can have noise above
96 dB.  Surely _by definition_ a 16-bit DAC or ADC is one that does
not have noise above that level.

John.
