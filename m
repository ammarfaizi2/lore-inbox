Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964827AbWB0Uuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbWB0Uuf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 15:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964828AbWB0Uue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 15:50:34 -0500
Received: from cantor2.suse.de ([195.135.220.15]:56545 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964827AbWB0Uue (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 15:50:34 -0500
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: [PATCH 01/02] cpuset memory spread slab cache filesys
Date: Mon, 27 Feb 2006 21:49:49 +0100
User-Agent: KMail/1.9.1
Cc: Paul Jackson <pj@sgi.com>, dgc@sgi.com, steiner@sgi.com,
       Simon.Derr@bull.net, linux-kernel@vger.kernel.org, clameter@sgi.com
References: <20060227070209.1994.26823.sendpatchset@jackhammer.engr.sgi.com> <20060227121605.fb41d505.pj@sgi.com> <Pine.LNX.4.64.0602271235200.8242@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0602271235200.8242@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602272149.51257.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 February 2006 21:36, Christoph Lameter wrote:

> On the other hand setting memory policy to MPOL_INTERLEAVE already 
> provides that functionality.

Yes, but not selective for these slabs caches. I think it would be useful
if we could interleave inodes/dentries but still keep a local policy for
normal program memory.

-Andi
