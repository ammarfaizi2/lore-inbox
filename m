Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750974AbWITKK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbWITKK2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 06:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbWITKK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 06:10:28 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:63701 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750956AbWITKK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 06:10:27 -0400
Subject: Re: [PATCH] Linux Kernel Markers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Richard J Moore <richardj_moore@uk.ibm.com>
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
In-Reply-To: <OFD1A61531.0E2D11C4-ON802571EF.002D4111-802571EF.002DA3BC@uk.ibm.com>
References: <OFD1A61531.0E2D11C4-ON802571EF.002D4111-802571EF.002DA3BC@uk.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 20 Sep 2006 11:32:07 +0100
Message-Id: <1158748327.7705.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-09-20 am 09:18 +0100, ysgrifennodd Richard J Moore:
> > Are you referring to Intel erratum "unsynchronized cross-modifying code"
> > - where it refers to the practice of modifying code on one processor
> > where another has prefetched the unmodified version of the code.

> In the special case of replacing an opcode with int3 that erratum doesn't
> apply. I know that's not in the manuals but it has been confirmed by the
> Intel microarchitecture group. And it's not reasonable to it to be any
> other way.

Ok thats cool to know and I wish they'd documented it. Is the same true
for AMD ?

Alan

