Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbUKPWR6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUKPWR6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 17:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbUKPWR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 17:17:58 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:33975 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261839AbUKPWB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 17:01:28 -0500
Message-ID: <419A78A5.1060800@nortelnetworks.com>
Date: Tue, 16 Nov 2004 16:01:09 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Dean Nelson <dcn@sgi.com>, Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch] export sched_setscheduler() for kernel module use
References: <4198F70D.mailxMSZ11J00J@aqua.americas.sgi.com> <20041115105801.T14339@build.pdx.osdl.net> <20041115203343.GA32173@sgi.com> <20041116104821.GA31395@elte.hu> <20041116201841.GA29687@sgi.com> <20041116223608.GA27550@elte.hu>
In-Reply-To: <20041116223608.GA27550@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> Using the linear priority has the
> advantage of not having to pass any policy value - priorities between 0
> and 99 implicitly mean SCHED_FIFO, priorities above that would mean
> SCHED_NORMAL, a pretty natural and compact interface.

Just curious--why FIFO and not RR?

Chris
