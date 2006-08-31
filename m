Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932324AbWHaOUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbWHaOUq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 10:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbWHaOUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 10:20:46 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:35745 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932324AbWHaOUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 10:20:46 -0400
Date: Thu, 31 Aug 2006 07:20:36 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andi Kleen <ak@suse.de>
Cc: piet@bluelane.com, Andrew Morton <akpm@osdl.org>,
       kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       George Anzinger <george@wildturkeyranch.net>, vgoyal@in.ibm.com,
       Subhachandra Chandra <schandra@bluelane.com>,
       "Discussion list for crash utility usage, maintenance and development" 
	<crash-utility@redhat.com>
Subject: Re: [Kgdb-bugreport] [RFC] [Crash-utility] Patch to use gdb's bt in crash - works	great with kgdb! - KGDB in Linus Kernel.
Message-ID: <20060831142036.GF23227@smtp.west.cox.net>
References: <44EC8CA5.789286A@redhat.com> <20060824111259.GB22145@in.ibm.com> <44EDA676.37F12263@redhat.com> <1156966522.29300.67.camel@piet2.bluelane.com> <20060830204032.GD30392@in.ibm.com> <1156974093.29300.103.camel@piet2.bluelane.com> <20060830145300.7d728f6c.rdunlap@xenotime.net> <1156976522.24314.1.camel@piet2.bluelane.com> <p73lkp5578s.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73lkp5578s.fsf@verdi.suse.de>
Organization: Embedded Alley Solutions, Inc
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2006 at 04:07:15PM +0200, Andi Kleen wrote:
> Piet Delaney <piet@bluelane.com> writes:
> > > 
> > > ENOPATCH
> > 
> > Opps. 
> 
> What an ugly patch!
> 
> But it should be totally obsolete with the unwinder work Jan and me have been
> doing recently which does this all properly. .18 isn't quite there
> yet in all cases, but .19 will be hopefully.

Indeed.  But quite functional.  Have you guys been doing i386 as well?
This kind of thing was needed to convince gdb when it really was time to
stop trying unwind in a few cases, but looks quite bad on x86_64/i386.
Thankfully getting it to stop on ARM was pretty easy (but it wasn't
full/true annotations).

-- 
Tom Rini
