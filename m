Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264459AbUADBsn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 20:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264477AbUADBsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 20:48:43 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:57566 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S264459AbUADBsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 20:48:42 -0500
Date: Sat, 03 Jan 2004 17:48:33 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: 2.6.1-rc1-mjb1
Message-ID: <48590000.1073180912@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.58.0401040130450.2752@student.dei.uc.pt>
References: <4690000.1073090546@[10.10.2.4]> <Pine.LNX.4.58.0401040130450.2752@student.dei.uc.pt>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The patchset contains ... oh hell, anything I feel like putting in it.
>> It's meant to be pretty stable - performance should be better than mainline,
>> particularly on larger machines.
>> 
>> I'd be very interested in feedback from anyone willing to test on any
>> platform, however large or small.
>> 
>> ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/2.6.1-rc1/patch-2.6.1-rc1-mjb1.bz2
> 
> Hi there...
> 
> Have you thought in doing a patch-2.6.1-rc1-mm1-mjb1 and continuing to make a
> patchset to the -mm sources?

I considered it once, for about 30s - the answer was no. For one, Andrew 
moves way too fast for me to keep up with. For another, he has different 
objectives - he basically runs a testing tree, whereas I want to go for
something more stable, with cherry picked enhancements (mostly performance
and serviceability stuff).

There's a fair amount of common code between the two trees, which I try
to keep pretty much in sync between the two - I pick up changes he makes
from his latest trees, and send him changes I make.

M.

