Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263166AbTLIGaS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 01:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263176AbTLIGaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 01:30:18 -0500
Received: from ns0.asml.nl ([194.105.121.194]:19159 "EHLO nlvdhx10.asml.nl")
	by vger.kernel.org with ESMTP id S263166AbTLIGaM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 01:30:12 -0500
From: Tim Timmerman <Tim.Timmerman@asml.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-ID: <16341.27623.254399.958389@asml.com>
Date: Tue, 9 Dec 2003 07:29:59 +0100
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Tim Timmerman <Tim.Timmerman@asml.com>, Mark Symonds <mark@symonds.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23 hard lock, 100% reproducible.
In-Reply-To: <Pine.LNX.4.44.0312080845120.30140-100000@logos.cnet>
References: <16340.9329.913657.900605@asml.com>
	<Pine.LNX.4.44.0312080845120.30140-100000@logos.cnet>
X-Mailer: VM 7.15 under Emacs 21.3.2
X-NAIMIME-Disclaimer: 1
X-NAIMIME-Modified: 1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Marcelo" == Marcelo Tosatti <marcelo.tosatti@cyclades.com> writes:

Marcelo> On Mon, 8 Dec 2003, Tim Timmerman wrote:
>> Let me just add a me-too here. 
>> 
>> Haven't got the oops on my desk, here, but from what I could
>> see, the error occurred in find_appropriate_src, somewhere in
>> ipchains.  
>> 
>> Further, possibly irrelevant datapoint: ABIT BP6, ne2k-pci and
>> 3Com590 network cards. When the oops occurs, everything locks,
>> capslock and scrolllock are lit. 
>> 
>> I can reproduce the error by letting a second system ping the
>> first, on the internal network. Sometimes it doesn't even
>> complete a full boot. 
>> 
>> I'll try and capture more detail tonight. 

Marcelo> Tim,

Marcelo> Please try the updated 2.4 BK tree (you can use -bk5, 
Marcelo> http://www.kernel.org/pub/linux/kernel/v2.4/snapshots/patch-2.4.23-bk5.bz2).

Marcelo> It contains a fix for a known bug in the netfilter which
Marcelo> might what you're hitting.

   Marcello,

	Thanks ! I can confirm that this seems to fix the bug: system
	has been running the patched kernel for the past 12 hours, and
	is stable, even under load.

	TimT

-- 
tim.timmerman@asml.nl                              040-2683613
timt@timt.org   Voodoo Programmer/Keeper of the Rubber Chicken
Do Lipton employees take coffee breaks?



-- 
The information contained in this communication and any attachments is confidential and may be privileged, and is for the sole use of the intended recipient(s). Any unauthorized review, use, disclosure or distribution is prohibited. If you are not the intended recipient, please notify the sender immediately by replying to this message and destroy all copies of this message and any attachments. ASML is neither liable for the proper and complete transmission of the information contained in this communication, nor for any delay in its receipt.

