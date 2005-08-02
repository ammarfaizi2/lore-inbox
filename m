Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261372AbVHBADO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261372AbVHBADO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 20:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261373AbVHBADO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 20:03:14 -0400
Received: from graphe.net ([209.204.138.32]:62849 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261372AbVHBADM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 20:03:12 -0400
Date: Mon, 1 Aug 2005 17:03:11 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Paul Jackson <pj@sgi.com>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de
Subject: Re: [PATCH] String conversions for memory policy
In-Reply-To: <20050801165947.36b5da96.pj@sgi.com>
Message-ID: <Pine.LNX.4.62.0508011701420.9824@graphe.net>
References: <Pine.LNX.4.62.0507291137240.3864@graphe.net>
 <20050729152049.4b172d78.pj@sgi.com> <Pine.LNX.4.62.0507291746000.8663@graphe.net>
 <20050729230026.1aa27e14.pj@sgi.com> <Pine.LNX.4.62.0507301042420.26355@graphe.net>
 <20050730181418.65caed1f.pj@sgi.com> <Pine.LNX.4.62.0507301814540.31359@graphe.net>
 <20050730190126.6bec9186.pj@sgi.com> <Pine.LNX.4.62.0507301904420.31882@graphe.net>
 <20050730191228.15b71533.pj@sgi.com> <Pine.LNX.4.62.0508011147030.5541@graphe.net>
 <20050801160351.71ee630a.pj@sgi.com> <Pine.LNX.4.62.0508011618120.9351@graphe.net>
 <20050801165947.36b5da96.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Aug 2005, Paul Jackson wrote:

> Christoph wrote:
> > you need to create multiple 
> > levels of directories in /proc/<pid>/xx
> 
> You do?
> 
> Where's the new multiple directory levels in the two files:
> 
> 	/proc/<pid>/numa_policy		# contains one word
> 	/proc/<pid>/numa_nodelist	# contains one nodelist
> 
> There are some obvious negatives to this idea, but having to
> "create multiple levels of directories" doesn't seem to be
> one of them.

One would need /proc/<pid>/<vma>/policy and /proc/<pid>/<vma>/nodelist 
to control the allocation in the vmas.


