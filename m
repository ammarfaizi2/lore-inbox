Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264846AbUEYN4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264846AbUEYN4F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 09:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264850AbUEYN4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 09:56:04 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:39554 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264846AbUEYN4C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 09:56:02 -0400
Date: Tue, 25 May 2004 15:55:36 +0200
From: Jens Axboe <axboe@suse.de>
To: Kevin Corry <kevcorry@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Lars Marowsky-Bree <lmb@suse.de>,
       braam <braam@clusterfs.com>, torvalds@osdl.org, akpm@osdl.org,
       "'Phil Schwan'" <phil@clusterfs.com>
Subject: Re: [PATCH/RFC] Lustre VFS patch
Message-ID: <20040525135535.GT1952@suse.de>
References: <20040525064730.GB14792@suse.de> <20040525082305.BAEE93101A0@moraine.clusterfs.com> <20040525105252.GJ22750@marowsky-bree.de> <200405250835.24110.kevcorry@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405250835.24110.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25 2004, Kevin Corry wrote:
> On Tuesday 25 May 2004 5:52 am, Lars Marowsky-Bree wrote:
> > Maybe you could fix this in the test harness / Lustre itself instead and
> > silently discard the writes internally if told so via an (internal)
> > option, instead of needing a change deeper down in the IO layer, or use
> > a DM target which can give you all the failure scenarios you need?
> >
> > In particular the last one - a fault-injection DM target - seems like a
> > very valuable tool for testing in general, but the Lustre-internal
> > approach may be easier in the long run.
> 
> See dm-flakey.c in the latest -udm patchset for a fairly simple version of a 
> "fault-injection" target.
> 
> http://sources.redhat.com/dm/patches.html

Would by far be the superior solution.

-- 
Jens Axboe

