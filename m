Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318690AbSIFPOC>; Fri, 6 Sep 2002 11:14:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318706AbSIFPOC>; Fri, 6 Sep 2002 11:14:02 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:54289 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S318690AbSIFPOB>; Fri, 6 Sep 2002 11:14:01 -0400
Date: Sat, 7 Sep 2002 01:18:03 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Kirk Reiser <kirk@braille.uwo.ca>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.xx kernels won't run on my Athlon boxes
In-Reply-To: <x765xj9wgg.fsf@speech.braille.uwo.ca>
Message-ID: <Mutt.LNX.4.44.0209070106200.10905-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 Sep 2002, Kirk Reiser wrote:

> I can't be the only person experiencing this.

I'm not sure if this is related, but I've noticed a major performance
issue starting in 2.5.32 (and still present in .33) on a dual celeron
system that has otherwise been working fine for a couple of years with all
kinds of bleeding edge kenels.  Some initial profiling output is showing
up to a factor of 10x the number of clock ticks and load for kernel
compiles and local copying of kernel trees.  hdparm -t is showing a 25%
decrease in throughput.  This is an IDE system with a PIIX4 controller.

If time permits, I'll do some more investigation.

- James
-- 
James Morris
<jmorris@intercode.com.au>



