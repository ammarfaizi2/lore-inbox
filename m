Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317582AbSFRTtP>; Tue, 18 Jun 2002 15:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317583AbSFRTtO>; Tue, 18 Jun 2002 15:49:14 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:37614 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S317582AbSFRTtN>; Tue, 18 Jun 2002 15:49:13 -0400
Date: Tue, 18 Jun 2002 15:49:15 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Robert Love <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: latest linus-2.5 BK broken
Message-ID: <20020618154915.C16091@redhat.com>
References: <20020618152949.B16091@redhat.com> <Pine.LNX.4.44.0206182118310.1263-100000@netfinity.realnet.co.sz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0206182118310.1263-100000@netfinity.realnet.co.sz>; from zwane@linux.realnet.co.sz on Tue, Jun 18, 2002 at 09:19:40PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2002 at 09:19:40PM +0200, Zwane Mwaikambo wrote:
> Hmm i don't understand, mind explaining why it wouldn't work on HT?

On HyperThreading, you want to specify that either cpu in a pair is 
okay.  In larger SMP machines that share a cache between 4 CPUs, the 
mask is likely to contain all 4 CPUs in each quad.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."
