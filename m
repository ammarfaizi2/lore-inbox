Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161227AbVLWR1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161227AbVLWR1q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 12:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161228AbVLWR1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 12:27:46 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:24535 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161227AbVLWR1q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 12:27:46 -0500
Date: Fri, 23 Dec 2005 09:27:33 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Coywolf Qi Hunt <coywolf@gmail.com>
cc: linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-mm@kvack.org, Andi Kleen <ak@suse.de>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: Zoned counters V1 [14/14]: Remove wbs
In-Reply-To: <2cd57c900512230357o17c8d0f0l@mail.gmail.com>
Message-ID: <Pine.LNX.4.62.0512230926400.13126@schroedinger.engr.sgi.com>
References: <20051220220151.30326.98563.sendpatchset@schroedinger.engr.sgi.com>
  <20051220220303.30326.16531.sendpatchset@schroedinger.engr.sgi.com>
 <2cd57c900512230357o17c8d0f0l@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Dec 2005, Coywolf Qi Hunt wrote:

> >  static void
> > -get_dirty_limits(struct writeback_state *wbs, long *pbackground, long *pdirty,
> > -               struct address_space *mapping)
> > +get_dirty_limits(long *pbackground, long *pdirty, struct address_space *mapping)
> 
> Maybe get rid of the odd Hungarian naming too.

s/pbackground/background s/pdirty/dirty ?
