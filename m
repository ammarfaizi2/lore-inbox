Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311906AbSCOCDz>; Thu, 14 Mar 2002 21:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311908AbSCOCDn>; Thu, 14 Mar 2002 21:03:43 -0500
Received: from artemis.rus.uni-stuttgart.de ([129.69.1.28]:25325 "EHLO
	artemis.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S311906AbSCOCDZ>; Thu, 14 Mar 2002 21:03:25 -0500
Date: Fri, 15 Mar 2002 03:03:22 +0100 (MET)
From: Erich Focht <focht@ess.nec.de>
To: Gerrit Huizenga <gh@us.ibm.com>
cc: Jesse Barnes <jbarnes@sgi.com>, lse-tech@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: Node affine NUMA scheduler 
In-Reply-To: <E16lbPH-000705-00@w-gerrit2>
Message-ID: <Pine.LNX.4.21.0203150257450.16174-100000@sx6.ess.nec.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Mar 2002, Gerrit Huizenga wrote:

> Beware of optimizing for the benchmark.  In real life, exec is likely
> a much better place for the balancing.

:-) Thanks for the warning. I'll play around with the possibilities by (at
least temporarilly) including a node_policy or balance_policy. I'm having
in mind some big OpenMP codes which could benefit of initial balancing
which they won't get in do_exec().

Regards,
Erich


