Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132858AbRDDRPD>; Wed, 4 Apr 2001 13:15:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132860AbRDDROx>; Wed, 4 Apr 2001 13:14:53 -0400
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:55410 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S132859AbRDDROt>; Wed, 4 Apr 2001 13:14:49 -0400
From: Kanoj Sarcar <kanoj@google.engr.sgi.com>
Message-Id: <200104041714.KAA43960@google.engr.sgi.com>
Subject: Re: [Lse-tech] Re: a quest for a better scheduler
To: frankeh@us.ibm.com (Hubertus Franke)
Date: Wed, 4 Apr 2001 10:14:28 -0700 (PDT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel List),
        lse-tech@lists.sourceforge.net
In-Reply-To: <OF5E9EE337.4E94D8F7-ON85256A24.005D15F8@pok.ibm.com> from "Hubertus Franke" at Apr 04, 2001 01:03:32 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 
> 
> Kanoj, our cpu-pooling + loadbalancing allows you to do that.
> The system adminstrator can specify at runtime through a
> /proc filesystem interface the cpu-pool-size, whether loadbalacing
> should take place.

Yes, I think this approach can support the various requirements
put on the scheduler.

I think there are two degrees of freedom that are needed in the
scheduler. One, as you say, for the sysadmin to be able to specify
what overall scheduler behavior he wants. 

Secondly, from the kernel standpoint, there needs to be perarch
hooks, to be able to utilize nodelevel/multilevel caches, NUMA
aspects etc.

Kanoj
