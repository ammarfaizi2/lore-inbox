Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135281AbRECWc7>; Thu, 3 May 2001 18:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135283AbRECWcu>; Thu, 3 May 2001 18:32:50 -0400
Received: from domino1.resilience.com ([209.245.157.33]:18832 "EHLO
	intranet.resilience.com") by vger.kernel.org with ESMTP
	id <S135281AbRECWcl>; Thu, 3 May 2001 18:32:41 -0400
Mime-Version: 1.0
Message-Id: <p05100301b7177e779892@[10.128.7.49]>
In-Reply-To: <15089.47157.268005.262050@gargle.gargle.HOWL>
In-Reply-To: <200105011445.KAA01117@localhost.localdomain>
 <3AEEDFFC.409D8271@redhat.com>
 <15086.60620.745722.345084@gargle.gargle.HOWL>
 <3AF025AE.511064F3@redhat.com>	<3AF04648.73F5BFCE@cds.duke.edu>
 <3AF0483C.49C8CF90@redhat.com>	<20010502230357.A9507@bug.ucw.cz>
 <15089.47157.268005.262050@gargle.gargle.HOWL>
Date: Thu, 3 May 2001 15:32:29 -0700
To: Eric.Ayers@intec-telecom-systems.com
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: Linux Cluster using shared scsi
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 3:57 PM -0400 2001-05-03, Eric Z. Ayers wrote:
>However distateful it sounds, there is precedent for the
>behavior that Doug is proposing in commercial clustering
>implementations.  My recollection is that both Compaq TruCluster and
>HP Service Guard have logic that will panic the kernel when a disk is
>"stolen" from under a running service and there is a "network
>partition" in the cluster.
>
>A network partition occurs when multiple machines in the cluster are
>runnig, but the HA software agents on two nodes can't communicate via
>the network to arbitrate which node should be the owner of the disk.

There are also the more extreme STONITH and STOMITH [shoot the other 
node/machine in the head] required by some shared filesystems (eg 
GFS).

http://linux-ha.org/stonith.html
http://sistina.com/gfs/howtos/gfs_howto/STOMITH__IO_Fencing.html
-- 
/Jonathan Lundell.
