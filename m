Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751759AbWHSPIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751759AbWHSPIc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 11:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751758AbWHSPIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 11:08:31 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52436 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751469AbWHSPIa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 11:08:30 -0400
Message-ID: <44E728E2.4000804@redhat.com>
Date: Sat, 19 Aug 2006 11:06:10 -0400
From: Rik van Riel <riel@redhat.com>
Organization: Red Hat, Inc
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Daniel Phillips <phillips@google.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       David Miller <davem@davemloft.net>, tgraf@suug.ch, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Mike Christie <michaelc@cs.wisc.edu>
Subject: Re: [RFC][PATCH 2/9] deadlock prevention core
References: <20060808211731.GR14627@postel.suug.ch>	<44DBED4C.6040604@redhat.com>	<44DFA225.1020508@google.com>	<20060813.165540.56347790.davem@davemloft.net>	<44DFD262.5060106@google.com>	<20060813185309.928472f9.akpm@osdl.org>	<1155530453.5696.98.camel@twins>	<20060813215853.0ed0e973.akpm@osdl.org>	<44E3E964.8010602@google.com>	<20060816225726.3622cab1.akpm@osdl.org>	<44E5015D.80606@google.com>	<20060817230556.7d16498e.akpm@osdl.org>	<44E62F7F.7010901@google.com>	<20060818153455.2a3f2bcb.akpm@osdl.org>	<44E650C1.80608@google.com> <20060818194435.25bacee0.akpm@osdl.org>
In-Reply-To: <20060818194435.25bacee0.akpm@osdl.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> - We expect that the lots-of-dirty-anon-memory-over-swap-over-network
>   scenario might still cause deadlocks.  
> 
>   I assert that this can be solved by putting swap on local disks.  Peter
>   asserts that this isn't acceptable due to disk unreliability.  I point
>   out that local disk reliability can be increased via MD, all goes quiet.
> 
>   A good exposition which helps us to understand whether and why a
>   significant proportion of the target user base still wishes to do
>   swap-over-network would be useful.

You cannot put disks in many models of blade servers.

At all.

-- 
What is important?  What you want to be true, or what is true?
