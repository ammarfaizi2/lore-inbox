Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264692AbUHCAkE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264692AbUHCAkE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 20:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264655AbUHCAiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 20:38:00 -0400
Received: from gizmo09ps.bigpond.com ([144.140.71.19]:20420 "HELO
	gizmo09ps.bigpond.com") by vger.kernel.org with SMTP
	id S264692AbUHCAdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 20:33:43 -0400
Message-ID: <410EDD60.8040406@bigpond.net.au>
Date: Tue, 03 Aug 2004 10:33:36 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Michal Kaczmarski <fallow@op.pl>, Shane Shrybman <shrybman@aei.ca>
Subject: Re: [PATCH] V-3.0 Single Priority Array O(1) CPU Scheduler Evaluation
References: <410DDFD2.5090400@bigpond.net.au> <20040802134257.GE2334@holomorphy.com>
In-Reply-To: <20040802134257.GE2334@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> On Mon, Aug 02, 2004 at 04:31:46PM +1000, Peter Williams wrote:
> 
>>3. Priority based O(1) scheduler with active/expired arrays replaced by 
>>a single array and an O(1) promotion mechanism plus scheduling 
>>statistics with new interactive bonus mechanism and throughput bonus 
>>mechanism:
> 
> 
> Hmm. Given do_promotions() I'd expect fenceposts, not iteration over
> the priority levels of the runqueue.

I don't understand what you mean.  Do you mean something like the more 
complex promotion mechanism in the (earlier) EBS scheduler where tasks 
only get promoted if they've been on a queue without being serviced 
within a given time?

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

