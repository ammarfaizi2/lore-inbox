Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264953AbUGMNKR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264953AbUGMNKR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 09:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265082AbUGMNKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 09:10:16 -0400
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:429 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264953AbUGMNKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 09:10:12 -0400
Message-ID: <40F3DF31.3000003@yahoo.com.au>
Date: Tue, 13 Jul 2004 23:10:09 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: preempt-timing-2.6.8-rc1
References: <20040713122805.GZ21066@holomorphy.com> <40F3DACC.9070703@yahoo.com.au> <20040713125331.GA21066@holomorphy.com> <40F3DC52.1030308@yahoo.com.au> <20040713130448.GB21066@holomorphy.com>
In-Reply-To: <20040713130448.GB21066@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> William Lee Irwin III wrote:
> 
>>>AFAICT this is nothing more than rounding up.
> 
> 
> On Tue, Jul 13, 2004 at 10:57:54PM +1000, Nick Piggin wrote:
> 
>>But you want to round down by definition of preempt_thresh, don't you?
>>preempt_thresh = 1ms = 1000000us
>>ie. warn me if the lock hold goes _to or above_ 1000000us
> 
> 
> The semantics I implemented are warning for strictly above the
> preempt_thresh. Whether those semantics are ideal is irrelevant; it's
> faithful to those semantics.

You are right - I misread it, sorry.

> Given that people are asking for sub-
> millisecond latencies, maybe I should increase the precision.
> 

Would soon be useful I think.
