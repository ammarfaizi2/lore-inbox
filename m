Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261727AbTCGTTy>; Fri, 7 Mar 2003 14:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261731AbTCGTTy>; Fri, 7 Mar 2003 14:19:54 -0500
Received: from air-2.osdl.org ([65.172.181.6]:20713 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261727AbTCGTTx>;
	Fri, 7 Mar 2003 14:19:53 -0500
Date: Fri, 7 Mar 2003 11:28:40 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: WimMark I for 2.5.64-mm1
Message-Id: <20030307112840.4591cc68.rddunlap@osdl.org>
In-Reply-To: <20030307175700.GA2835@ca-server1.us.oracle.com>
References: <20030307175700.GA2835@ca-server1.us.oracle.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Mar 2003 09:57:01 -0800 Joel Becker <Joel.Becker@oracle.com> wrote:

| WimMark I report for 2.5.64-mm1
| 
| Runs with anticipatory scheduler:  547.28 580.69
| Runs with deadline scheduler:  1557.79 1360.52
| 
| 	WimMark I is a rough benchmark we have been running
| here at Oracle against various kernels.  Each run tests an OLTP
| workload on the Oracle database with somewhat restrictive memory
| conditions.  This reduces in-memory buffering of data, allowing for
| more I/O.  The I/O is read and sync write, random and seek-laden.
| 	The benchmark is called "WimMark I" because it has no
| official standing and is only a relative benchmark useful for comparing
| kernel changes.  The benchmark is normalized an arbitrary kernel, which
| scores 1000.0.  All other numbers are relative to this.
| 	The machine in question is a 4 way 700 MHz Xeon machine with 2GB
| of RAM.  CONFIG_HIGHMEM4GB is selected.  The disk accessed for data is a
| 10K RPM U2W SCSI of similar vintage.  Unless mentioned, all runs are
| on this machine (variation in hardware would indeed change the
| benchmark).

Is there a web page where we can view/compare results?

Thanks,
--
~Randy
