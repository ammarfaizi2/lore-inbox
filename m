Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752230AbWAEVtq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752230AbWAEVtq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 16:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752234AbWAEVtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 16:49:46 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:39382 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1752229AbWAEVtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 16:49:45 -0500
Date: Thu, 5 Jan 2006 16:49:28 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Vegard Lima <Vegard.Lima@hia.no>
cc: Esben Nielsen <simlo@phys.au.dk>, Daniel Walker <dwalker@mvista.com>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.15-rt1-sr1: xfs mount crash
In-Reply-To: <1136496867.12042.5.camel@tordenfugl.lima.heim>
Message-ID: <Pine.LNX.4.58.0601051646060.27590@gandalf.stny.rr.com>
References: <Pine.LNX.4.44L0.0601051618200.3110-100000@lifa02.phys.au.dk>
 <1136496867.12042.5.camel@tordenfugl.lima.heim>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jan 2006, Vegard Lima wrote:

> to den 05.01.2006 Klokka 16:19 (+0100) skreiv Esben Nielsen:
> >
> > On Thu, 5 Jan 2006, Daniel Walker wrote:
> > >
> > > Looks like a race , so maybe a timing issue. Just turn on some debugging
> > > in the code path that slows/speeds things just enough .
> >
> > CONFIG_DEBUG_RT_LOCKING_MODE turns spinlock_t into raw_spinlock_t again as
> > far as I can see. It is probably some spinlock_t which has to be a
> > raw_spinlock_t for the time being.
>
> Just FYI 2.5.14-rt22 worked fine with
> CONFIG_DEBUG_RT_LOCKING_MODE _not_ set.

Unfortunately, *a lot* changed between 2.6.14-rt22 (assuming you had a
typo) and 2.6.15-rt1 so this doesn't narrow it down very much.  Have you
tried any of the 2.6.15-rcX-rtX versions?

-- Steve

