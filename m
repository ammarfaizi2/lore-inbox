Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbTIQA7F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 20:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262581AbTIQA7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 20:59:05 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:40347 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S262574AbTIQA7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 20:59:03 -0400
Date: Tue, 16 Sep 2003 17:58:08 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Ben Johnson <ben@blarg.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linear vs. logical addresses?  how does cpu interpret kernel addrs?
Message-ID: <1563260000.1063760286@[10.10.2.4]>
In-Reply-To: <20030917005446.GW4306@holomorphy.com>
References: <20030916154747.A22526@blarg.net> <1562370000.1063759683@[10.10.2.4]> <20030917005446.GW4306@holomorphy.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> At some point in the past, someone had their attribution stripped from:
>>> 1) When I am referencing a pointer in the kernel, is the value of that
>>> pointer variable interpreted by the cpu as a logical or linear address?
>>> 2) if I have two overlapping data/stack segments presently selected,
>>> each with a different base, how does the cpu know which segment/base
>>> address to use to get the linear address?
> 
> On Tue, Sep 16, 2003 at 05:48:04PM -0700, Martin J. Bligh wrote:
>> IIRC, all the base segments are 0, so none of this matters ;-)
> 
> 2.0.x used such things as the segment bits, hardware tasking, and so on.

And happily is now supremely irrelevant ;-)

BTW, to the original question ... chapter 2 of "Understanding the Linux Kernel"
had a good explanation of all this.

M.

