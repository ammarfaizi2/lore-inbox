Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129858AbRBMXGw>; Tue, 13 Feb 2001 18:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130158AbRBMXGc>; Tue, 13 Feb 2001 18:06:32 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:30220 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129858AbRBMXGX>; Tue, 13 Feb 2001 18:06:23 -0500
Subject: Re: 2.4.1-ac11  swap problems
To: cowboy@vnet.ibm.com (Richard A Nelson)
Date: Tue, 13 Feb 2001 23:07:03 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0102131744020.2104-100000@badlands.lexington.ibm.com> from "Richard A Nelson" at Feb 13, 2001 05:52:48 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14SoXJ-0003CP-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2.4.1-ac10 works fine (I had it up 24 hours before, and am again running
> it).
> 
> Shortly after boot on 2.4.1-ac11, I get a ration of these:
>   kernel: Unused swap offset entry in swap_count 0015fb04

Yep there is a small bug in the tlb shootdown fixes. Ben has fixed that. I'll
put up an ac12


