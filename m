Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261835AbUKCUoB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbUKCUoB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 15:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbUKCUoB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 15:44:01 -0500
Received: from fw.osdl.org ([65.172.181.6]:30931 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261835AbUKCUnV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 15:43:21 -0500
Date: Wed, 3 Nov 2004 12:42:57 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Florian Weimer <fw@deneb.enyo.de>
cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       davidm@snapgear.com, linux-kernel@vger.kernel.org,
       uclinux-dev@uclinux.org
Subject: Re: [PATCH 12/14] FRV: Generate more useful debug info
In-Reply-To: <87wtx2oee3.fsf@deneb.enyo.de>
Message-ID: <Pine.LNX.4.58.0411031242460.2187@ppc970.osdl.org>
References: <20041101162929.63af1d0d.akpm@osdl.org>
 <76b4a884-2c3c-11d9-91a1-0002b3163499@redhat.com>
 <200411011930.iA1JUMgs023243@warthog.cambridge.redhat.com> <5109.1099394496@redhat.com>
 <Pine.LNX.4.58.0411021747420.2187@ppc970.osdl.org>
 <Pine.LNX.4.58.0411021750440.2187@ppc970.osdl.org> <87wtx2oee3.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Nov 2004, Florian Weimer wrote:

> * Linus Torvalds:
> 
> >> That may not be true today, but what is true is that -O1 is not a light 
> >> thing to just do.
> >
> > And btw, in some cases the inlining used to be a correcness issue, so no,
> > just making it be "static inline" doesn't necessarily fix the basic issue. 
> 
> But the always_inline attribute hopefully does.

Not with older compilers. 

		Linus
