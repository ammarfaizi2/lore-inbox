Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317577AbSGTXJI>; Sat, 20 Jul 2002 19:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317578AbSGTXJH>; Sat, 20 Jul 2002 19:09:07 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:35314 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317577AbSGTXJG>; Sat, 20 Jul 2002 19:09:06 -0400
Subject: Re: [2.6] Most likely to be merged by Halloween... THE LIST
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: David Weinehall <tao@acc.umu.se>,
       Austin Gonyou <austin@digitalroadkill.net>,
       Mark Peloquin <peloquin@us.ibm.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020720212414.GL10315@clusterfs.com>
References: <OF918E6F71.637B1CBC-ON85256BFB.004CDDD0@pok.ibm.com>
	<1027199147.16819.39.camel@irongate.swansea.linux.org.uk>
	<1027197028.26159.2.camel@UberGeek.digitalroadkill.net>
	<20020720205520.GX29001@khan.acc.umu.se> 
	<20020720212414.GL10315@clusterfs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 21 Jul 2002 01:24:02 +0100
Message-Id: <1027211042.16819.45.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-07-20 at 22:24, Andreas Dilger wrote:
> I, for one, would like to have the choice to use the AIX LVM format, and
> I'm sure that people thinking of migrating from HP/UX or whatever would
> want to be able to add support for their on-disk LVM format.  It really
> provides a framework to consolidate all of the partition/MD code into
> a single place (e.g. RAID, LVM, LDM (windows NT), DOS, BSD, Sun, etc).

The LVM format for AIX and so on call all be handled by LVM2

> EVMS also allows things like creating snapshots and resizing for
> partitions that were not originally set up as LVM volumes (i.e. you can
> "upgrade" your existing DOS partitions in-place to support LVM features
> instead of requiring a backup/restore cycle.

LVM2 has had this for months


