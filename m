Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317339AbSFLWo3>; Wed, 12 Jun 2002 18:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317342AbSFLWo2>; Wed, 12 Jun 2002 18:44:28 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:8445 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317339AbSFLWo1>; Wed, 12 Jun 2002 18:44:27 -0400
Subject: Re: [CHECKER] 37 stack variables >= 1K in 2.4.17
From: Robert Love <rml@tech9.net>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Alexander Viro <viro@math.psu.edu>,
        Dawson Engler <engler@csl.Stanford.EDU>, linux-kernel@vger.kernel.org,
        mc@cs.Stanford.EDU
In-Reply-To: <20020612183854.B4081@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 12 Jun 2002 15:44:16 -0700
Message-Id: <1023921856.1476.64.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-06-12 at 15:38, Benjamin LaHaise wrote:

> Perfection isn't what I'm looking for, rather just an approximation.  
> Any tool would have to give up on non-trivial recursion, or have 
> additional rules imposed on the system.  Checker seems to be growing 
> functionality in this area, so it seems like a useful feature request.

I do not want to give up on this idea, either... if the implementation
needs to be "hackish" or even explicitly ignore certain functions, so be
it.  There is a _lot_ that can be done with detailed call chain analysis
-- the point you gave is one of many.

Checker already has some basic functionality here I suspect based on
what it is capable of reporting... imagine what more could be reported?

	Robert Love

