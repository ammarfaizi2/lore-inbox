Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266660AbSKLRkJ>; Tue, 12 Nov 2002 12:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266665AbSKLRkJ>; Tue, 12 Nov 2002 12:40:09 -0500
Received: from kfw.debis.hu ([195.228.20.2]:7665 "EHLO dns.debis.hu")
	by vger.kernel.org with ESMTP id <S266660AbSKLRkG> convert rfc822-to-8bit;
	Tue, 12 Nov 2002 12:40:06 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: IDE TCQ
Date: Tue, 12 Nov 2002 18:46:34 +0100
Message-ID: <71EE24368CCFB940A79BD7002F14D760409348@exchange.uns.t-systems.tss>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: IDE TCQ
Thread-Index: AcKKc2rbWVpTfTslS12DuHnf3U/5eA==
From: =?iso-8859-2?Q?Sasi_P=E9ter?= <Peter.Sasi@t-systems.co.hu>
To: <axboe@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Jens,

I would like to ask a few simple question: what does it take to make use of this nifty feature?

My example:
I have a box with an ABIT BH6 mainboard (Intel chipset, 2xUATA33 channels), A Leadtek WinFast CMD648 with 2xUATA66 channels, and a Promise Ultra100 TX2 2xUATA100.
I have 3x IBM GXP120 120GB UATA100 IDE HDDs (have read you write these to be capable of TCQ).

First set of questions:
On which of the three different IDE controllers are the disks supposed to be doing TCQ?

Is it limited to UATA100 and up?
Is it limited to specific chipsets?
Maybe a combination of these two?

Is there any list of the disks that support TCQ?
Or does that come compulsory with eg. UATA100?

Second set of questions:
Does it do any good to one-channel-one-disk setups?
Is it supposed to do good to access time, operations/sec, throughput, random reqs rearrangement or what?
Do you have any figures how much TCQ helps performace (e.g. in file serving case)?

Now I see I piled up quite a few questions. Maybe it is more polite to ask you if you can recommend any reading on the topic on the web first?

Maybe I should rather be asking Andre Hedrick about the internals of TCQ?

I have CCd LKML, since others might also like some clarification around IDE TCQ. If you reply, please keep me CCd as well, since I am not subscribed to LKML currently.

Thank you very much!

Peter
