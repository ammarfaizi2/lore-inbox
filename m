Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261693AbTCGRq5>; Fri, 7 Mar 2003 12:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261690AbTCGRq4>; Fri, 7 Mar 2003 12:46:56 -0500
Received: from inet-mail3.oracle.com ([148.87.2.203]:29167 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id <S261693AbTCGRqj>; Fri, 7 Mar 2003 12:46:39 -0500
Date: Fri, 7 Mar 2003 09:57:01 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: linux-kernel@vger.kernel.org
Subject: WimMark I for 2.5.64-mm1
Message-ID: <20030307175700.GA2835@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


WimMark I report for 2.5.64-mm1

Runs with anticipatory scheduler:  547.28 580.69
Runs with deadline scheduler:  1557.79 1360.52

	WimMark I is a rough benchmark we have been running
here at Oracle against various kernels.  Each run tests an OLTP
workload on the Oracle database with somewhat restrictive memory
conditions.  This reduces in-memory buffering of data, allowing for
more I/O.  The I/O is read and sync write, random and seek-laden.
	The benchmark is called "WimMark I" because it has no
official standing and is only a relative benchmark useful for comparing
kernel changes.  The benchmark is normalized an arbitrary kernel, which
scores 1000.0.  All other numbers are relative to this.
	The machine in question is a 4 way 700 MHz Xeon machine with 2GB
of RAM.  CONFIG_HIGHMEM4GB is selected.  The disk accessed for data is a
10K RPM U2W SCSI of similar vintage.  Unless mentioned, all runs are
on this machine (variation in hardware would indeed change the
benchmark).



-- 

"The lawgiver, of all beings, most owes the law allegiance.  He of all
 men should behave as though the law compelled him.  But it is the
 universal weakness of mankind that what we are given to administer we
 presently imagine we own."
        - H.G. Wells

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
