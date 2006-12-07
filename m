Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163405AbWLGV1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163405AbWLGV1A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 16:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163406AbWLGV1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 16:27:00 -0500
Received: from zcars04e.nortel.com ([47.129.242.56]:35868 "EHLO
	zcars04e.nortel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1163405AbWLGV07 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 16:26:59 -0500
Message-ID: <4578871C.2010309@nortel.com>
Date: Thu, 07 Dec 2006 15:26:52 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050427 Red Hat/1.7.7-1.1.3.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: additional oom-killer tuneable worth submitting?
References: <45785DDD.3000503@nortel.com> <1165519292.14110.2.camel@lappy>
In-Reply-To: <1165519292.14110.2.camel@lappy>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Dec 2006 21:27:03.0203 (UTC) FILETIME=[6FF9E730:01C71A46]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra wrote:
> On Thu, 2006-12-07 at 12:30 -0600, Chris Friesen wrote:

>>The "oom-thresh" value maps to the max expected memory consumption for 
>>that process.  As long as a process uses less memory than the specified 
>>threshold, then it is immune to the oom-killer.
> 
> You would need to specify the measure of memory used by your process;
> see the (still not resolved) RSS debate.

Currently we simply use mm->total_vm, same as the oom killer.

Chris
