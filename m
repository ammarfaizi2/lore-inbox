Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932312AbWHaOHf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbWHaOHf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 10:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbWHaOHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 10:07:35 -0400
Received: from cantor2.suse.de ([195.135.220.15]:65195 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932312AbWHaOHf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 10:07:35 -0400
To: piet@bluelane.com
Cc: Andrew Morton <akpm@osdl.org>, kgdb-bugreport@lists.sourceforge.net,
       linux-kernel@vger.kernel.org,
       George Anzinger <george@wildturkeyranch.net>, vgoyal@in.ibm.com,
       Subhachandra Chandra <schandra@bluelane.com>,
       "Discussion list for crash utility usage, maintenance and development" 
	<crash-utility@redhat.com>
Subject: Re: [RFC] [Crash-utility] Patch to use gdb's bt in crash - works	great with kgdb! - KGDB in Linus Kernel.
References: <44EC8CA5.789286A@redhat.com> <20060824111259.GB22145@in.ibm.com>
	<44EDA676.37F12263@redhat.com>
	<1156966522.29300.67.camel@piet2.bluelane.com>
	<20060830204032.GD30392@in.ibm.com>
	<1156974093.29300.103.camel@piet2.bluelane.com>
	<20060830145300.7d728f6c.rdunlap@xenotime.net>
	<1156976522.24314.1.camel@piet2.bluelane.com>
From: Andi Kleen <ak@suse.de>
Date: 31 Aug 2006 16:07:15 +0200
In-Reply-To: <1156976522.24314.1.camel@piet2.bluelane.com>
Message-ID: <p73lkp5578s.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Piet Delaney <piet@bluelane.com> writes:
> > 
> > ENOPATCH
> 
> Opps. 

What an ugly patch!

But it should be totally obsolete with the unwinder work Jan and me have been
doing recently which does this all properly. .18 isn't quite there
yet in all cases, but .19 will be hopefully.

-Andi
