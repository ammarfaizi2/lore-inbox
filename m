Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264423AbRFOPMk>; Fri, 15 Jun 2001 11:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264424AbRFOPMa>; Fri, 15 Jun 2001 11:12:30 -0400
Received: from quasar.osc.edu ([192.148.249.15]:35523 "EHLO quasar.osc.edu")
	by vger.kernel.org with ESMTP id <S264423AbRFOPMS>;
	Fri, 15 Jun 2001 11:12:18 -0400
Date: Fri, 15 Jun 2001 11:12:13 -0400
From: Pete Wyckoff <pw@osc.edu>
To: "David S. Miller" <davem@redhat.com>
Cc: nick@snowman.net, Kip Macy <kmacy@netapp.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 3com Driver and the 3XP Processor
Message-ID: <20010615111213.C2245@osc.edu>
In-Reply-To: <15145.11935.992736.767777@pizda.ninka.net> <Pine.LNX.4.21.0106141739140.16013-100000@ns> <15145.12192.199302.981306@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15145.12192.199302.981306@pizda.ninka.net>; from davem@redhat.com on Thu, Jun 14, 2001 at 02:41:52PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

davem@redhat.com said:
> nick@snowman.net writes:
>  > So are there any intresting changes one can make to the acenic?
> 
> Like I said, there is an entire firmware developer kit, so the only
> limit is your imagination and coding skills :-)

I wrote a new firmware from scratch to offload most of a message passing
implementation (MPI, actually) into the Alteon NIC, including timeout
and retransmit, message matching, header building, etc.  It's almost
ready for release.  We're currently working on using both processors
of the Tigon in parallel.

There is other work which has modified the Alteon firmware to do, for
example, segmentation and reassembly (Underwood et al.), and further
work in progress on other topics.

Programmable NICs are fun.  I'd like to get one of those Tigon3 cards
to see if any of the register layout on the Tigon2 is still there,
hoping the interface is similar at least.

		-- Pete
