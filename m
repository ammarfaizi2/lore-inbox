Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316582AbSFZNwT>; Wed, 26 Jun 2002 09:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316585AbSFZNwS>; Wed, 26 Jun 2002 09:52:18 -0400
Received: from iris.mc.com ([192.233.16.119]:45732 "EHLO mc.com")
	by vger.kernel.org with ESMTP id <S316582AbSFZNwR>;
	Wed, 26 Jun 2002 09:52:17 -0400
Message-Id: <200206261352.JAA09553@mc.com>
Content-Type: text/plain; charset=US-ASCII
From: mbs <mbs@mc.com>
To: linux-kernel@vger.kernel.org
Subject: advice on benchmarks for smp/scsi system
Date: Wed, 26 Jun 2002 09:54:21 -0400
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

what tools are the state of the art benchmarking tools for network, disk and 
interrupt latency testing?

I need to do some kernel performance characterization on a dual xeon, dual Gb 
ethernet, SCSI320/RAID system.

I need to measure network throughput vs CPU load, disk throughput, interrupt 
latency, network to disk streaming and disk to net streaming.

I need to characterize the stock rh7.3 2.4 smp kernel, stock + pre-emption 
patch, stock + latency patch and stock + both.  I also need to test the same 
basic combinations, but stripped and optimized for my specific hardware. I 
know in a general way that I will probably find the most joy with 
stripped/optimized + both, but I need specifics.

I also need to compare compiled in scsi and e-net vs modules

any recommendations for which sets of benchmarking tools to use would be 
appreciated greatly

	Thanks for your time,

		Mark
-- 
/**************************************************
**   Mark Salisbury       ||      mbs@mc.com     **
**************************************************/
