Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbWITLu4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWITLu4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 07:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbWITLuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 07:50:55 -0400
Received: from ns.suse.de ([195.135.220.2]:24217 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750825AbWITLuz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 07:50:55 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: prasanna@in.ibm.com, Andrew Morton <akpm@osdl.org>,
       Mathieu Desnoyers <compudj@krystal.dyndns.org>,
       "Frank Ch. Eigler" <fche@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>, Jes Sorensen <jes@sgi.com>,
       Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, ltt-dev@shafik.org,
       Martin Bligh <mbligh@google.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Ingo Molnar <mingo@elte.hu>, systemtap@sources.redhat.com,
       systemtap-owner@sourceware.org, Thomas Gleixner <tglx@linutronix.de>,
       William Cohen <wcohen@redhat.com>, Tom Zanussi <zanussi@us.ibm.com>
Subject: Re: [PATCH] Linux Kernel Markers
References: <OFD1A61531.0E2D11C4-ON802571EF.002D4111-802571EF.002DA3BC@uk.ibm.com>
	<1158748327.7705.3.camel@localhost.localdomain>
From: Andi Kleen <ak@suse.de>
Date: 20 Sep 2006 13:50:53 +0200
In-Reply-To: <1158748327.7705.3.camel@localhost.localdomain>
Message-ID: <p731wq6kb8i.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> Ar Mer, 2006-09-20 am 09:18 +0100, ysgrifennodd Richard J Moore:
> > > Are you referring to Intel erratum "unsynchronized cross-modifying code"
> > > - where it refers to the practice of modifying code on one processor
> > > where another has prefetched the unmodified version of the code.
> 
> > In the special case of replacing an opcode with int3 that erratum doesn't
> > apply. I know that's not in the manuals but it has been confirmed by the
> > Intel microarchitecture group. And it's not reasonable to it to be any
> > other way.
> 
> Ok thats cool to know and I wish they'd documented it. Is the same true
> for AMD ?

It pretty much has to, otherwise lots of debuggers would be unhappy

-Andi
