Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261699AbTCGR4a>; Fri, 7 Mar 2003 12:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261702AbTCGR4a>; Fri, 7 Mar 2003 12:56:30 -0500
Received: from boden.synopsys.com ([204.176.20.19]:15814 "HELO
	boden.synopsys.com") by vger.kernel.org with SMTP
	id <S261699AbTCGR42>; Fri, 7 Mar 2003 12:56:28 -0500
Date: Fri, 7 Mar 2003 19:06:53 +0100
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: WimMark I for 2.5.64-mm1
Message-ID: <20030307180653.GA30288@riesen-pc.gr05.synopsys.com>
Reply-To: alexander.riesen@synopsys.COM
References: <20030307175700.GA2835@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030307175700.GA2835@ca-server1.us.oracle.com>
User-Agent: Mutt/1.4i
Organization: Synopsys, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Becker, Fri, Mar 07, 2003 18:57:01 +0100:
> 
> WimMark I report for 2.5.64-mm1
> 
> Runs with anticipatory scheduler:  547.28 580.69
> Runs with deadline scheduler:  1557.79 1360.52

What do the numbers mean?
Is AS better or worse DS?

> 	WimMark I is a rough benchmark we have been running
> here at Oracle against various kernels.  Each run tests an OLTP
> workload on the Oracle database with somewhat restrictive memory
> conditions.  This reduces in-memory buffering of data, allowing for
> more I/O.  The I/O is read and sync write, random and seek-laden.
> 	The benchmark is called "WimMark I" because it has no
> official standing and is only a relative benchmark useful for comparing
> kernel changes.  The benchmark is normalized an arbitrary kernel, which
> scores 1000.0.  All other numbers are relative to this.
> 	The machine in question is a 4 way 700 MHz Xeon machine with 2GB
> of RAM.  CONFIG_HIGHMEM4GB is selected.  The disk accessed for data is a
> 10K RPM U2W SCSI of similar vintage.  Unless mentioned, all runs are
> on this machine (variation in hardware would indeed change the
> benchmark).
