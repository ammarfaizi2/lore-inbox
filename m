Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267746AbUG3RIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267746AbUG3RIx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 13:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267748AbUG3RIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 13:08:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8154 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267746AbUG3RIZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 13:08:25 -0400
Message-ID: <410A8077.7020308@pobox.com>
Date: Fri, 30 Jul 2004 13:08:07 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: linux-kernel@vger.kernel.org, Roger Luethi <rl@hellgate.ch>
Subject: Re: List of pending v2.4 kernel bugs
References: <20040720142640.GB2348@dmt.cyclades> <20040721112336.GA9537@k3.hellgate.ch> <20040730155613.GD2748@logos.cnet>
In-Reply-To: <20040730155613.GD2748@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> On Wed, Jul 21, 2004 at 01:23:36PM +0200, Roger Luethi wrote:
> 
>>On Tue, 20 Jul 2004 11:26:40 -0300, Marcelo Tosatti wrote:
>>
>>>I've created a directory to store known pending v2.4 problems,
>>>at http://master.kernel.org/~marcelo/pending-2.4-issues/ 
>>
>>Multicast is still broken for big-endian architectures using via-rhine
>>(2.4.27-rc3). MC use on BE is rare (no bug reports!), but the bug is
>>fatal for anyone trying that combination. Jeff's got the patch.
>>
>>A couple other drivers may be affected by the same thinko as well.
> 
> 
> Hi Roger,
> 
> I have added your comments in "multicast-bigendian-netdriver" entry 
> in the pending bug list.
> 
> I asked Jeff about this but he ignored me, again.

Nudge accepted :)  I've been more busy than usual.

I am worried because this specific area of code has been "fixed" at 
least twice in recent memory, making Roger's changes the third attempt 
to address this sort of problem.

I would really like to see verification of patches on the hardware 
affected (big endian), as well as tests on little endian to ensure 
nothing breaks, before applying them.

	Jeff



