Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbTJSPqt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 11:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbTJSPqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 11:46:48 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:16040 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S261670AbTJSPqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 11:46:46 -0400
Date: Sun, 19 Oct 2003 08:43:27 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@fs.tum.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] add a config option for -Os compilation
Message-ID: <668910000.1066578207@[10.10.2.4]>
In-Reply-To: <20031018105733.380ea8d2.akpm@osdl.org>
References: <20031015225055.GS17986@fs.tum.de><20031015161251.7de440ab.akpm@osdl.org><20031015232440.GU17986@fs.tum.de><20031015165205.0cc40606.akpm@osdl.org><20031018102127.GE12423@fs.tum.de><649730000.1066491920@[10.10.2.4]><20031018102402.3576af6c.akpm@osdl.org><20031018174434.GJ12423@fs.tum.de> <20031018105733.380ea8d2.akpm@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> On Sat, Oct 18, 2003 at 10:24:02AM -0700, Andrew Morton wrote:
>> > "Martin J. Bligh" <mbligh@aracnet.com> wrote:
>> > > 
>> > > Please don't - I benchmarked it a while ago, and it's definitely slower.
>> > 
>> > Alan said he generally found -Os to be faster...
>> 
>> Not exactly:
>>   http://www.ussg.iu.edu/hypermail/linux/kernel/0211.0/1513.html
>> 
> 
> http://www.ussg.iu.edu/hypermail/linux/kernel/0308.1/1261.html
> 
> And bear in mind that you can see significant changes in benchmark results
> between equivalent kernels even when the optimisation level is kept the
> same, due to aliasing and alignment luck.
> 
> It would take a quite a lot of work to measure this properly.  A simple A/B
> comparison doesn't cut it.

So why are we changing it then? ;-) We don't seem to have much evidence
either way. What are the distros doing?

M.

