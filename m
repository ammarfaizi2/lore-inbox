Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261434AbSJ2BGn>; Mon, 28 Oct 2002 20:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261438AbSJ2BGn>; Mon, 28 Oct 2002 20:06:43 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:2181 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261434AbSJ2BGm>;
	Mon, 28 Oct 2002 20:06:42 -0500
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Erich Focht <efocht@ess.nec.de>, Michael Hohnbaum <hohnbaum@us.ibm.com>,
       mingo@redhat.com, habanero@us.ibm.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: NUMA scheduler (was: 2.5 merge candidate list 1.5) 
In-reply-to: Your message of Mon, 28 Oct 2002 16:00:19 PST.
             <737410000.1035849619@flay> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5015.1035853972.1@us.ibm.com>
Date: Mon, 28 Oct 2002 17:12:52 -0800
Message-Id: <E186Kw8-0001Ix-00@w-gerrit2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <737410000.1035849619@flay>, > : "Martin J. Bligh" writes:
> 
> Yup, 32Mb cache. Not sure if it's faster than local memory or not.

Yes, NUMA-Q cache can be faster than local memory, but it *only* caches
remote memory.  Some other architectures use the L3 cache to cache *all*
memory (local _and_ remote).  Reasoning:  why polute the valuable
cache with things that are already close at hand?

gerrit
