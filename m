Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbTLHTM1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 14:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbTLHTM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 14:12:27 -0500
Received: from holomorphy.com ([199.26.172.102]:27868 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261754AbTLHTMX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 14:12:23 -0500
Date: Mon, 8 Dec 2003 11:12:17 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Anton Blanchard <anton@samba.org>
Subject: Re: [patch] sched-HT-2.6.0-test11-A5
Message-ID: <20031208191217.GZ19856@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Anton Blanchard <anton@samba.org>
References: <20031117021511.GA5682@averell> <Pine.LNX.4.56.0311231300290.16152@earth> <1027750000.1069604762@[10.10.2.4]> <Pine.LNX.4.58.0312011102540.3323@earth> <20031208175622.GY19856@holomorphy.com> <Pine.LNX.4.58.0312081859100.8707@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312081859100.8707@earth>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Dec 2003, William Lee Irwin III wrote:
>> Why not per_cpu for __rq_idx[] and __cpu_idx[]? This would have the
>> advantage of residing on node-local memory for sane architectures (and
>> perhaps in the future, some insane ones).

On Mon, Dec 08, 2003 at 07:21:14PM +0100, Ingo Molnar wrote:
> agreed, i've changed them to be per-cpu.
> new patch with all your suggestions included is at:
>   redhat.com/~mingo/O(1)-scheduler/sched-SMT-2.6.0-test11-C1
> it also includes the bounce-to-cpu1 fix from/for Anton.

This looks pretty good, thanks.


-- wli
