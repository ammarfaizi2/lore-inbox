Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751754AbWB0Teu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751754AbWB0Teu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 14:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751753AbWB0Teu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 14:34:50 -0500
Received: from mail.suse.de ([195.135.220.2]:13785 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751754AbWB0Tet (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 14:34:49 -0500
To: Paul Jackson <pj@sgi.com>
Cc: dgc@sgi.com, steiner@sgi.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: [PATCH 01/02] cpuset memory spread slab cache filesys
References: <20060227070209.1994.26823.sendpatchset@jackhammer.engr.sgi.com>
From: Andi Kleen <ak@suse.de>
Date: 27 Feb 2006 20:34:40 +0100
In-Reply-To: <20060227070209.1994.26823.sendpatchset@jackhammer.engr.sgi.com>
Message-ID: <p731wxo1tpr.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> writes:

> From: Paul Jackson <pj@sgi.com>
> 
> Mark file system inode and similar slab caches subject to
> SLAB_MEM_SPREAD memory spreading.
> 
> If a slab cache is marked SLAB_MEM_SPREAD, then anytime that
> a task that's in a cpuset with the 'memory_spread_slab' option
> enabled

Is there a way to use it without cpumemsets? 

I would assume it's useful for smaller machines too, but they
generally don't use cpumemsets.
-Andi
