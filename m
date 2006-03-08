Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbWCHRFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbWCHRFT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 12:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751559AbWCHRFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 12:05:19 -0500
Received: from mx1.redhat.com ([66.187.233.31]:48611 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751233AbWCHRFR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 12:05:17 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060308145506.GA5095@devserv.devel.redhat.com> 
References: <20060308145506.GA5095@devserv.devel.redhat.com>  <31492.1141753245@warthog.cambridge.redhat.com> <29826.1141828678@warthog.cambridge.redhat.com> 
To: Alan Cox <alan@redhat.com>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       mingo@redhat.com, linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document Linux's memory barriers [try #2] 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Wed, 08 Mar 2006 17:04:51 +0000
Message-ID: <9834.1141837491@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@redhat.com> wrote:

> [For information on bus mastering DMA and coherency please read ....]
> 
> sincee have a doc on this

Documentation/pci.txt?

> The use of volatile generates poorer code and hides the serialization in 
> type declarations that may be far from the code.

I'm not sure what you mean by that.

> Is this true of IA-64 ??

Are you referring to non-temporal loads and stores?

> > +There are some more advanced barriering functions:
> 
> "barriering" ... ick,  barrier.

Picky:-)

> Should clarify local ordering v SMP ordering for locks implied here.

Do you mean explain what each sort of lock does?

> > + (*) inX(), outX():
> > +
> > +     These are intended to talk to legacy i386 hardware using an alternate bus
> > +     addressing mode.  They are synchronous as far as the x86 CPUs are
> 
> Not really true. Lots of PCI devices use them. Need to talk about "I/O space"

Which bit is not really true?

David
