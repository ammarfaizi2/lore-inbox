Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313743AbSHWXcm>; Fri, 23 Aug 2002 19:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313867AbSHWXcm>; Fri, 23 Aug 2002 19:32:42 -0400
Received: from tempest.prismnet.com ([209.198.128.6]:17673 "EHLO
	tempest.prismnet.com") by vger.kernel.org with ESMTP
	id <S313743AbSHWXcl>; Fri, 23 Aug 2002 19:32:41 -0400
From: Troy Wilson <tcw@tempest.prismnet.com>
Message-Id: <200208232336.g7NNaibw086602@tempest.prismnet.com>
Subject: Re: [Lse-tech] Re: (RFC): SKB Initialization
In-Reply-To: <3D669B4F.7090402@us.ibm.com> "from Dave Hansen at Aug 23, 2002
 01:30:07 pm"
To: Dave Hansen <haveblue@us.ibm.com>
Date: Fri, 23 Aug 2002 18:36:44 -0500 (CDT)
CC: hartner@austin.ibm.com, manand@us.ibm.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 I found the number of simultaneous connections under SPECWeb99 *
to be improved by ~1% when using Mala's SKB patch.

   2.5.25 baseline = 2656 simultaneous connections
2.5.25 + SKB patch = 2688 simultaneous connections


*  SPEC(tm) and the benchmark name SPECweb(tm) are registered
trademarks of the Standard Performance Evaluation Corporation.
This benchmarking was performed for research purposes only,
and is non-compliant, with the following deviations from the
rules -

  1 - It was run on hardware that does not meed the SPEC
      availability-to-the-public criteria.  The machine is
      an engineering sample.

  2 - access_log wasn't kept for full accounting.  It was
      being written, but deleted every 200 seconds.



