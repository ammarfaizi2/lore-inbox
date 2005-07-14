Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263058AbVGNVTW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263058AbVGNVTW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 17:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263059AbVGNVTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 17:19:21 -0400
Received: from khc.piap.pl ([195.187.100.11]:3588 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S263058AbVGNVTU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 17:19:20 -0400
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Linus Torvalds <torvalds@osdl.org>,
       David Lang <david.lang@digitalinsight.com>,
       Bill Davidsen <davidsen@tmr.com>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Lee Revell <rlrevell@joe-job.com>, Diego Calleja <diegocg@gmail.com>,
       azarah@nosferatu.za.org, akpm@osdl.org, cw@f00f.org,
       christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
References: <20050712121008.GA7804@ucw.cz>
	<200507122239.03559.kernel@kolivas.org>
	<200507122253.03212.kernel@kolivas.org> <42D3E852.5060704@mvista.com>
	<20050712162740.GA8938@ucw.cz> <42D540C2.9060201@tmr.com>
	<Pine.LNX.4.62.0507131022230.11024@qynat.qvtvafvgr.pbz>
	<20050713184227.GB2072@ucw.cz>
	<Pine.LNX.4.58.0507131203300.17536@g5.osdl.org>
	<m34qaxlm57.fsf@defiant.localdomain> <20050714121950.GB1072@ucw.cz>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Thu, 14 Jul 2005 23:19:14 +0200
In-Reply-To: <20050714121950.GB1072@ucw.cz> (Vojtech Pavlik's message of
 "Thu, 14 Jul 2005 14:19:50 +0200")
Message-ID: <m3irzdytkd.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz> writes:

> HPETs have a fixed frequency (usually 14.31818 MHz, but that depends
> on the manufacturer).
>
>> - 64-bit "match timer" (i.e., a register in the counter which fires IRQ
>>   when it matches the counter value)
>
> That's implemented in the HPET hardware.

Interesting. So it could theoretically work. Unless the machine in
question lacks HPET.
-- 
Krzysztof Halasa
