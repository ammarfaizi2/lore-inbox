Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316657AbSFFBUl>; Wed, 5 Jun 2002 21:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316663AbSFFBUk>; Wed, 5 Jun 2002 21:20:40 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:46758 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316657AbSFFBUj>;
	Wed, 5 Jun 2002 21:20:39 -0400
To: Robert Love <rml@tech9.net>
cc: Rick Bressler <rickb@mushroom.ca.boeing.com>, linux-kernel@vger.kernel.org
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [PATCH] scheduler hints 
In-Reply-To: Your message of 05 Jun 2002 18:11:38 PDT.
             <1023325903.912.390.camel@sinai> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <24407.1023326371.1@us.ibm.com>
Date: Wed, 05 Jun 2002 18:19:31 -0700
Message-Id: <E17Flw4-0006Lj-00@w-gerrit2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1023325903.912.390.camel@sinai>, > : Robert Love writes:
> On Wed, 2002-06-05 at 18:05, Gerrit Huizenga wrote:
> 
> > Actually, process-to-process affinity, which was later generalized
> > as a process gang affinity.
> 
> Oh OK, gang affinity - a bit different and not what we do now :)
> 
> Interesting to look into, although not terribly useful I suspect weighed
> against its implementation...
> 
> 	Robert Love

Our scheduler *was* a long set of conditionals.  However, from the
stock BSD scheduler through the contorted thing that it became, we
saw something like 30-50% increases in some workloads.  I think
the motivator was actually not Oracle originally but something like
SAP.  Specific numbers are hard to extract now since we did so many
SMP & NUMA changes over the years, but I think I remember a slide
showing over 30% increase in SAP for this one additional feature.
I don't know that I ever saw specific Oracle or Oracle Apps numbers
for this although it was viewed as a "large" benefit, especially
in NUMA machines, but even on SMP machines.

gerrit
