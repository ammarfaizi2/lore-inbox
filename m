Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751396AbWCaQE2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbWCaQE2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 11:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbWCaQE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 11:04:28 -0500
Received: from unthought.net ([212.97.129.88]:64518 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S1751396AbWCaQE2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 11:04:28 -0500
Date: Fri, 31 Mar 2006 18:04:27 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS client (10x) performance regression 2.6.14.7 -> 2.6.15
Message-ID: <20060331160426.GN9811@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	linux-kernel@vger.kernel.org
References: <20060331094850.GF9811@unthought.net> <1143807770.8096.4.camel@lade.trondhjem.org> <20060331124518.GH9811@unthought.net> <1143810392.8096.11.camel@lade.trondhjem.org> <20060331132131.GI9811@unthought.net> <1143812658.8096.18.camel@lade.trondhjem.org> <20060331140816.GJ9811@unthought.net> <1143814889.8096.22.camel@lade.trondhjem.org> <20060331143500.GK9811@unthought.net> <1143820520.8096.24.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143820520.8096.24.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2006 at 10:55:20AM -0500, Trond Myklebust wrote:
...
> No. They are the nfsstat numbers + timing information. I was interested
> in seeing if the latter can show up something.

Oops sorry. Here you go:

device sparrow:/exported/joe mounted on /u/joe with
fstype nfs statvers=1.0
 opts: rw,vers=3,rsize=32768,wsize=32768,acregmin=3,acregmax=60,acdirmin=30,acdirmax=60,hard,intr,proto=udp,timeo=7,retrans=3
 age:    2526
 caps: caps=0x1,wtmult=4096,dtsize=4096,bsize=0,namelen=255
 sec:    flavor=1
 events: 854 472 4017 4651 56 74 753 8357 3987 3511 0 4016 20 19 20 2 0 56 0 5 4371 0 0 0 0 
 bytes:  131161418 19867448 0 0 114028223 19862777 31282 4349 
 RPC iostats version: 1.0 p/v: 100003/3 (nfs)
 xprt:   udp 1023 0 560 560 0 1832 176
 per-op statistics
  NULL: 1 1 0 0 24 0 0 0
  GETATTR: 115 115 0 0 12880 0 16 24
  SETATTR: 0 0 0 0 0 0 0 0
  LOOKUP: 149 149 0 0 21540 4 28 32
  ACCESS: 97 97 0 0 11640 0 8 8
  READLINK: 2 2 0 0 272 0 0 0
  READ: 193 193 0 0 5977864 176 424 600
  ... all zeroes ...
  READDIRPLUS: 2 2 0 0 6544 0 0 0
  FSSTAT: 0 0 0 0 0 0 0 0
  FSINFO: 1 1 0 0 80 0 4 4
  PATHCONF: 0 0 0 0 0 0 0 0
  COMMIT: 0 0 0 0 0 0 0 0

I'll be offline for a few hours - will check back later tonight.

-- 
/ jakob

