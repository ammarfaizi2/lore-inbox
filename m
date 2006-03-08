Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750996AbWCHMeq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbWCHMeq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 07:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbWCHMeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 07:34:46 -0500
Received: from mx1.redhat.com ([66.187.233.31]:61396 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750779AbWCHMep (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 07:34:45 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.64.0603071918460.32577@g5.osdl.org> 
References: <Pine.LNX.4.64.0603071918460.32577@g5.osdl.org>  <31492.1141753245@warthog.cambridge.redhat.com> <17422.19209.60360.178668@cargo.ozlabs.ibm.com> 
To: Linus Torvalds <torvalds@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>, David Howells <dhowells@redhat.com>,
       akpm@osdl.org, mingo@redhat.com, linux-arch@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document Linux's memory barriers 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Wed, 08 Mar 2006 12:34:25 +0000
Message-ID: <27607.1141821265@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:

> > Linus explained recently that wmb() on x86 does not order stores to
> > system memory w.r.t. stores to stores to prefetchable I/O memory (at
> > least that's what I think he said ;).

On i386 and x86_64, do IN and OUT instructions imply MFENCE? It's not obvious
from the x86_64 docs.

David
