Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264842AbTFLO5H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 10:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264843AbTFLO5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 10:57:07 -0400
Received: from [65.248.4.18] ([65.248.4.18]:26283 "EHLO
	gesundheit.complete.org") by vger.kernel.org with ESMTP
	id S264842AbTFLO5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 10:57:03 -0400
Date: Thu, 12 Jun 2003 10:10:38 -0500
From: John Goerzen <jgoerzen@complete.org>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cpufreq on Pentium M
Message-ID: <20030612151038.GA7795@complete.org>
References: <87n0go3pcp.fsf@complete.org> <20030612061803.GA21509@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030612061803.GA21509@suse.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 12, 2003 at 07:18:03AM +0100, Dave Jones wrote:
> It should turn up in 2.5 sometime real soon, and at some point, maybe
> someone will backport it.

I do hope so.  I can be a risk taker but I've learned that running a
development kernel on a laptop does not make for a good travel experience. 
(When you've got no 'net connection and no backup device handy, getting the
latest patch for the IDE driver isn't fun <g>)

> Looks like missing cache descriptors. Grab x86info[1] and mail me
> the output of x86info -c

Here ya go:

heinrich:~# x86info -c
x86info v1.11.  Dave Jones 2001, 2002
Feedback to <davej@suse.de>.

Found 1 CPU
Family: 6 Model: 9 Stepping: 5 Type: 0
CPU Model: Unknown CPU Original OEM
unknown TLB/cache descriptor:
        0xb0
unknown TLB/cache descriptor:
        0xb3
Instruction TLB: 4MB pages, fully associative, 2 entries
unknown TLB/cache descriptor:
        0x87
unknown TLB/cache descriptor:
        0x30
Data TLB: 4MB pages, 4-way associative, 8 entries
unknown TLB/cache descriptor:
        0x2c

