Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932285AbVKUMPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbVKUMPF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 07:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbVKUMPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 07:15:05 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:30599 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S932285AbVKUMPE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 07:15:04 -0500
Date: Mon, 21 Nov 2005 05:14:54 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: David Howells <dhowells@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Russell King <rmk@arm.linux.org.uk>, Ian Molton <spyro@f2s.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 4/5] Centralise NO_IRQ definition
Message-ID: <20051121121454.GA1598@parisc-linux.org>
References: <E1Ee0G0-0004CN-Az@localhost.localdomain> <24299.1132571556@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24299.1132571556@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2005 at 11:12:36AM +0000, David Howells wrote:
> Matthew Wilcox <matthew@wil.cx> wrote:
> 
> > +#define NO_IRQ			((unsigned int)(-1))
> 
> Should this be wrapped with #ifndef?

*sigh*.  The one piece of feedback I got on the last series was from
Ingo, and he asked that I *not* wrap it with ifndef.  So, no.
