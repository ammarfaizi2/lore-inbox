Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267345AbUJIUEd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267345AbUJIUEd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 16:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267350AbUJIUEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 16:04:32 -0400
Received: from opersys.com ([64.40.108.71]:4366 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S267345AbUJIUDV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 16:03:21 -0400
Message-ID: <416845E4.206@opersys.com>
Date: Sat, 09 Oct 2004 16:11:16 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: stefan.eletzhofer@eletztrick.de,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
References: <41677E4D.1030403@mvista.com> <416822B7.5050206@opersys.com>	 <1097346628.1428.11.camel@krustophenia.net>	 <20041009212614.GA25441@tier.local>	 <1097350227.1428.41.camel@krustophenia.net>	 <20041009213817.GB25441@tier.local> <1097351221.1428.46.camel@krustophenia.net>
In-Reply-To: <1097351221.1428.46.camel@krustophenia.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Lee Revell wrote:
> Yes.  The upper bound on the response time of an RT task is a function
> of the longest non-preemptible code path in the kernel.  Currently this
> is the processing of a single packet by netif_receive_skb.

And this has been demonstrated mathematically/algorithmically to be
true 100% of the time, regardless of the load and the driver set? IOW,
if I was building an automated industrial saw (based on a VP+IRQ-thread
kernel or a combination of the above-mentioned agregate) with a
safety mechanism that depended on the kernel's responsivness to
outside events to avoid bodily harm, would you be willing to put your
hand beneath it?

How about things like a hard-rt deterministic nanosleep() 100% of the
time with RTAI/fusion?

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546

