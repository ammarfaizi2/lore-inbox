Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266203AbUHBAB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266203AbUHBAB5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 20:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266205AbUHBAB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 20:01:57 -0400
Received: from zcamail05.zca.compaq.com ([161.114.32.105]:1549 "EHLO
	zcamail05.zca.compaq.com") by vger.kernel.org with ESMTP
	id S266203AbUHBAB4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 20:01:56 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Linux-cluster] Re: [ANNOUNCE] OpenSSI 1.0.0 released!!
Date: Sun, 1 Aug 2004 17:00:32 -0700
Message-ID: <3689AF909D816446BA505D21F1461AE4C750EA@cacexc04.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Linux-cluster] Re: [ANNOUNCE] OpenSSI 1.0.0 released!!
Thread-Index: AcR37Zlh+p4q6jCYQgigGGIpzNlPiAANVAmg
From: "Walker, Bruce J" <bruce.walker@hp.com>
To: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>,
       "Daniel Phillips" <phillips@istop.com>
Cc: "Discussion of clustering software components including GFS" 
	<linux-cluster@redhat.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <opengfs-devel@lists.sourceforge.net>,
       <opengfs-users@lists.sourceforge.net>,
       <opendlm-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 02 Aug 2004 00:00:32.0890 (UTC) FILETIME=[BAF31DA0:01C47823]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When processes can freely and transparently move around the cluster (at
exec time, fork time or during any system call), being able to
transparently access your controlling tty is pretty handy.  In 2.4 we
stack our CFS  on top of each node's devfs to give us naming of and
access to all devices on all nodes.  TBD on how will do this in 2.6.

Bruce


> > 
> > I wonder if device-mapper (slightly hacked) wouldn't be a 
> better approach for 
> > 2.6+.
> 
> It appeared from the original posting that their "cluster-wide devfs" 
> actually supported all types of device nodes, not just block 
> devices. I 
> don't know whether accessing a character device on another node would 
> ever be useful, but certainly using device-mapper wouldn't 
> help for that 
> case.
> 
