Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264468AbRFSRgg>; Tue, 19 Jun 2001 13:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264473AbRFSRg0>; Tue, 19 Jun 2001 13:36:26 -0400
Received: from intranet.resilience.com ([209.245.157.33]:54434 "EHLO
	intranet.resilience.com") by vger.kernel.org with ESMTP
	id <S264468AbRFSRgM>; Tue, 19 Jun 2001 13:36:12 -0400
Mime-Version: 1.0
Message-Id: <p05100302b7553d481172@[10.128.7.49]>
In-Reply-To: <20010619090956.R3089@work.bitmover.com>
In-Reply-To: <Pine.LNX.4.30.0106190940420.28643-100000@gene.pbi.nrc.ca>
 <3B2F769C.DCDB790E@kegel.com> <20010619090956.R3089@work.bitmover.com>
Date: Tue, 19 Jun 2001 10:36:00 -0700
To: linux-kernel@vger.kernel.org
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 9:09 AM -0700 2001-06-19, Larry McVoy wrote:
>Don't you think it is funny that Sun doesn't publish numbers comparing
>their thread performance to process performance?  Sure, you can find
>context switch benchmarks where they have user level switching going on
>but those are a red herring.  The real numbers you want are the kernel
>level context switches and those are just as expensive as the process
>context switch numbers.

Sun (or at least SPARC) is a bit of a special case, though. SPARC's 
register-window architecture makes thread-switching (not to mention 
recursion) significantly more expensive than on most other 
architectures.
-- 
/Jonathan Lundell.
