Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262853AbTCUCco>; Thu, 20 Mar 2003 21:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263012AbTCUCcn>; Thu, 20 Mar 2003 21:32:43 -0500
Received: from inet-mail2.oracle.com ([148.87.2.202]:53432 "EHLO
	inet-mail2.oracle.com") by vger.kernel.org with ESMTP
	id <S262853AbTCUCcJ>; Thu, 20 Mar 2003 21:32:09 -0500
Date: Thu, 20 Mar 2003 18:42:57 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: WimMark I report for 2.5.65-mm2 (now with deadline)
Message-ID: <20030321024256.GW2835@ca-server1.us.oracle.com>
References: <20030320204041.GO2835@ca-server1.us.oracle.com> <20030320175805.1625dbcc.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030320175805.1625dbcc.akpm@digeo.com>
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 20, 2003 at 05:58:05PM -0800, Andrew Morton wrote:
> > WimMark I report for 2.5.65-mm2
> > 
> > Runs (antic):  1374.22 1487.19 1437.26
> > Runs (deadline):  1238.58 1537.36 1513.04
> 
> The averages of these are equal.  Can we safely conclude that this is fixed
> up now?

	Not really, I think, because the 1238 seems a slightly fluke
run.  I see these from time to time, but almost all of the deadline runs
are in the 1500-1600 range.  In fact, -mm2 is lower than some other
kernels by about 50 for deadline.
	I wouldn't disagree with you if I didn't see that consistency.
antic has never really jumped above 1500, and deadline almost never goes
below.
	Certainly they are much closer than they were.

Joel

-- 

Life's Little Instruction Book #109

	"Know how to drive a stick shift."

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
