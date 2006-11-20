Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933972AbWKTGjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933972AbWKTGjJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 01:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933971AbWKTGjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 01:39:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:16340 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S933965AbWKTGjI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 01:39:08 -0500
Message-ID: <45614D41.2050303@redhat.com>
Date: Mon, 20 Nov 2006 01:37:53 -0500
From: Chris Snook <csnook@redhat.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: Jay Cliburn <jacliburn@bellsouth.net>
CC: jeff@garzik.org, shemminger@osdl.org, romieu@fr.zoreil.com,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] atl1: Revised Attansic L1 ethernet driver
References: <20061119202817.GA29736@osprey.hogchain.net>
In-Reply-To: <20061119202817.GA29736@osprey.hogchain.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jay Cliburn wrote:
> Based upon feedback from Stephen Hemminger and Francois Romieu, please
> consider this resubmitted patchset that provides support for the Attansic 
> L1 gigabit ethernet adapter.  This patchset is built against 2.6.19-rc6.  
> The original patchset was submitted 20060927.
> 
> The monolithic version of this patchset may be found at:
> ftp://hogchain.net/pub/linux/m2v/attansic/kernel_driver/atl1-2.0.2/atl1-2.0.2-kernel2.6.19.rc6.patch.bz2
> 
> As a reminder, this driver a modified version of the Attansic reference 
> driver for the L1 ethernet adapter.  Attansic has granted permission for 
> its inclusion in the mainline kernel.
> 
> The patch contains:
> 
>  Kconfig             |   12 
>  Makefile            |    1 
>  atl1/Makefile       |   30 
>  atl1/atl1.h         |  251 +++++
>  atl1/atl1_ethtool.c |  530 ++++++++++
>  atl1/atl1_hw.c      |  840 +++++++++++++++++
>  atl1/atl1_hw.h      |  991 ++++++++++++++++++++
>  atl1/atl1_main.c    | 2551 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  atl1/atl1_osdep.h   |   78 +
>  atl1/atl1_param.c   |  203 ++++
>  10 files changed, 5487 insertions(+)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

I've been working on this with Jay since his initial submission.  Thanks 
to everyone who has provided feedback on the resubmit.  We're currently 
quite short on actual testers, since the chip only seems to be on Asus 
M2V motherboards at present.  Please let me and Jay know if you have one 
of these boards and would like to test and/or have encountered bugs.

	-- Chris
