Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263938AbTDDTLO (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 14:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263939AbTDDTLO (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 14:11:14 -0500
Received: from inet-mail2.oracle.com ([148.87.2.202]:8391 "EHLO
	inet-mail2.oracle.com") by vger.kernel.org with ESMTP
	id S263938AbTDDTLM (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 14:11:12 -0500
Date: Fri, 4 Apr 2003 11:19:38 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: linux-kernel@vger.kernel.org
Subject: WimMark I report for 2.5.66-mm3
Message-ID: <20030404191938.GN31739@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

WimMark I report for 2.5.66-mm3 

Runs (deadline):  1736.51 1681.50 1010.98
Runs (antic):  579.62 496.75 517.06

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
10K RPM U2W SCSI of similar vintage.  The data files are living on an
ext3 filesystem.  Unless mentioned, all runs are
on this machine (variation in hardware would indeed change the
benchmark).


-- 

"Gone to plant a weeping willow
 On the bank's green edge it will roll, roll, roll.
 Sing a lulaby beside the waters.
 Lovers come and go, the river roll, roll, rolls."

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
