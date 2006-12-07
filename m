Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163324AbWLGUqG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163324AbWLGUqG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 15:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162461AbWLGUqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 15:46:06 -0500
Received: from smtp3.Stanford.EDU ([171.67.20.26]:59894 "EHLO
	smtp3.stanford.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1163324AbWLGUqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 15:46:03 -0500
Subject: Re: v2.6.19-rt6, yum/rpm
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: nando@ccrma.Stanford.EDU, linux-kernel@vger.kernel.org,
       linux-rt-users@vger.kernel.org, Mike Galbraith <efault@gmx.de>,
       Clark Williams <williams@redhat.com>,
       Sergei Shtylyov <sshtylyov@ru.mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       Giandomenico De Tullio <ghisha@email.it>
In-Reply-To: <20061205171114.GA25926@elte.hu>
References: <20061205171114.GA25926@elte.hu>
Content-Type: text/plain
Date: Thu, 07 Dec 2006 12:45:57 -0800
Message-Id: <1165524358.9244.33.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-12-05 at 18:11 +0100, Ingo Molnar wrote:
> i have released the 2.6.19-rt6 tree, which can be downloaded from the 
> usual place:
> 
>     http://redhat.com/~mingo/realtime-preempt/
> 
> more info about the -rt patchset can be found on the RT wiki:
> 
>   http://rt.wiki.kernel.org
> 
> this is a fixes-only release. Changes since -rt1:
[MUNCH]

A first non-scientific feedback report. 

Much better performance in terms of xruns with Jackd. Hardly any at all
as it should be. I'm starting to test -rt8 right now. 

Now, I still don't have an smp machine to test so the improvement could
be because I'm just running 64 bit up instead of smp. Or it could have
been the hardware on that other machine that had some problem (either
because it was starting to fail or because the kernel drivers for that
hardware were somehow triggering the xruns). 

Anyway, looks good!
Thanks.
-- Fernando


