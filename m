Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264810AbTFLNus (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 09:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264826AbTFLNus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 09:50:48 -0400
Received: from lvs01-fl.valueweb.net ([216.219.253.200]:47746 "EHLO
	ams003.ftl.affinity.com") by vger.kernel.org with ESMTP
	id S264810AbTFLNum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 09:50:42 -0400
Message-ID: <3EE887FA.90008@coyotegulch.com>
Date: Thu, 12 Jun 2003 10:02:34 -0400
From: Scott Robert Ladd <coyote@coyotegulch.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030527 Debian/1.3.1-2
X-Accept-Language: en
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: Artemio <artemio@artemio.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SMP question
References: <MDEHLPKNGKAHNMBLJOLKMEJLDJAA.davids@webmaster.com> <200306112313.30903.artemio@artemio.net> <20030611225401.GE2712@werewolf.able.es>
In-Reply-To: <20030611225401.GE2712@werewolf.able.es>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon wrote:
> In short, for FP intensive tasks, hyperthreading is a big lie...
> You can't run 2 computations in parallel.

Yes and no; the benefit of HT depends on the application in question. 
I've seen everything from a 5% LOSS in performance to a 30% INCREASE in 
performance, for intensive floating-point code. This is with programs 
parallelized with OpenMP and Intel's C and Fortran compilers. I'm still 
analyzing the exact nature of the benefits, but they *do* exist.

While I much prefer multiple physical CPUs to "virtual" CPUs, HT *does* 
provide performance improvements for certain applications. To call HT a 
"big lie" is both provacative and inaccurate.

-- 
Scott Robert Ladd
Coyote Gulch Productions (http://www.coyotegulch.com)

