Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268034AbUGWUak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268034AbUGWUak (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 16:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268036AbUGWUak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 16:30:40 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:36625 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S268034AbUGWUai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 16:30:38 -0400
Message-ID: <41017BBF.6020106@techsource.com>
Date: Fri, 23 Jul 2004 16:57:35 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Adrian Bunk <bunk@fs.tum.de>, corbet@lwn.net, linux-kernel@vger.kernel.org
Subject: Re: New dev model (was [PATCH] delete devfs)
References: <40FEEEBC.7080104@quark.didntduck.org>	<20040721231123.13423.qmail@lwn.net>	<20040721235228.GZ14733@fs.tum.de>	<20040722025539.5d35c4cb.akpm@osdl.org>	<20040722193337.GE19329@fs.tum.de> <20040722160112.177fc07f.akpm@osdl.org>
In-Reply-To: <20040722160112.177fc07f.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:
> Adrian Bunk <bunk@fs.tum.de> wrote:
> 
>>my personal opinon is that this new development model isn't a good 
>>idea from the point of view of users:
>>
>>There's much worth in having a very stable kernel. Many people use for 
>>different reasons self-compiled ftp.kernel.org kernels. 
> 
> 
> Well.  We'll see.  2.6 is becoming stabler, despite the fact that we're
> adding features.
> 
> I wouldn't be averse to releasing a 2.6.20.1 which is purely stability
> fixes against 2.6.20 if there is demand for it.  Anyone who really cares
> about stability of kernel.org kernels won't be deploying 2.6.20 within a
> few weeks of its release anyway, so by the time they doodle over to
> kernel.org they'll find 2.6.20.2 or whatever.


So instead of even minor numbers indicating stability, you have pushed 
two levels down so that higher sub-revision (minorminorminor?) numbers 
indicate increased levels of stability?

Kinda makes sense.

Does that mean that 2.6.21 and 2.6.20.1 are two separate forks of 
2.6.20, one for development, and the other for stability?

How is this fundamentally different from how it was done before with 
odd/even minor numbers?

It's like the details have been changed to give the illusion that 
development will go faster, when in reality, the fundamental approach 
hasn't really changed.

