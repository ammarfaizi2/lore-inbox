Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263731AbTETL6x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 07:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263746AbTETL6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 07:58:53 -0400
Received: from ns.suse.de ([213.95.15.193]:59911 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263731AbTETL6v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 07:58:51 -0400
Date: Tue, 20 May 2003 14:11:50 +0200
From: Andi Kleen <ak@suse.de>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org, plars@austin.ibm.com, akpm@digeo.com
Subject: Re: [PATCH] Exception trace for i386
Message-ID: <20030520121150.GA29889@Wotan.suse.de>
References: <20030519192814.GA975@averell.suse.lists.linux.kernel> <1053377808.588720@palladium.transmeta.com.suse.lists.linux.kernel> <p73k7cmzl7d.fsf@oldwotan.suse.de> <20030520131717.J626@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030520131717.J626@nightmaster.csn.tu-chemnitz.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 20, 2003 at 01:17:17PM +0200, Ingo Oeser wrote:
> On Mon, May 19, 2003 at 11:21:42PM +0200, Andi Kleen wrote:
> > I especially like it being a global option. It has catched bugs on x86-64 
> > that were never noticed before (e.g. subprocesses silently segfaulting 
> > that nobody noticed doing the same on i386). Clearly it's an debugging 
> > thing and you definitely want an option to turn it off. But having 
> > the global option is useful.
> 
> Would you consider doing the logging only, if the process has no
> real handler for that? (so it's blocking, ignoring or not caring
> about this signal)

Yes, I had this idea too and it's already implemented for x86-64.

-Andi

