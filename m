Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261792AbVAYDyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261792AbVAYDyl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 22:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261797AbVAYDyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 22:54:41 -0500
Received: from mail06.syd.optusnet.com.au ([211.29.132.187]:55267 "EHLO
	mail06.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261792AbVAYDyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 22:54:38 -0500
Message-ID: <41F5C347.4030605@kolivas.org>
Date: Tue, 25 Jan 2005 14:55:51 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
Cc: "Jack O'Quin" <joq@io.com>, Ingo Molnar <mingo@elte.hu>,
       linux <linux-kernel@vger.kernel.org>, CK Kernel <ck@vds.kolivas.org>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt scheduling
References: <200501201542.j0KFgOwo019109@localhost.localdomain>	<87y8eo9hed.fsf@sulphur.joq.us> <20050120172506.GA20295@elte.hu>	<87wtu6fho8.fsf@sulphur.joq.us> <20050122165458.GA14426@elte.hu>	<87pszvlvma.fsf@sulphur.joq.us> <41F42BD2.4000709@kolivas.org>	<877jm3ljo9.fsf@sulphur.joq.us> <41F44AC2.1080609@kolivas.org>	<87hdl7v3ik.fsf@sulphur.joq.us> <87651nv356.fsf@sulphur.joq.us>	<87ekgbqr2a.fsf@sulphur.joq.us> <41F49735.5000400@kolivas.org> <873bwrpb4o.fsf@sulphur.joq.us> <41F57D94.4010500@kolivas.org>
In-Reply-To: <41F57D94.4010500@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> -cc list trimmed to those who have recently responded.
> 
> 
> Here is a patch to go on top of 2.6.11-rc2-mm1 that fixes some bugs in 
> the general SCHED_ISO code, fixes the priority support between ISO 
> threads, and implements SCHED_ISO_RR and SCHED_ISO_FIFO as separate 
> policies. Note the bugfixes and cleanups mean the codepaths in this are 
> leaner than the original ISO2 implementation despite the extra features.
> 
> This works safely and effectively on UP (but not tested on SMP yet) so 
> Jack if/when you get a chance I'd love to see more benchmarks from you 
> on this one. It seems on my machine the earlier ISO2 implementation 
> without priority nor FIFO was enough for good results, but not on yours, 
> which makes your testcase a more discriminating one.

Sorry, I see yet another flaw in the design and SMP is broken so hold 
off testing for a bit.

Cheers,
Con
