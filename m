Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbUCAXic (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 18:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbUCAXic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 18:38:32 -0500
Received: from mailout2.pacific.net.au ([61.8.0.85]:26304 "EHLO
	mailout2.pacific.net.au") by vger.kernel.org with ESMTP
	id S261496AbUCAXiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 18:38:20 -0500
Date: Tue, 2 Mar 2004 10:38:04 +1100
From: David Luyer <david@luyer.net>
To: Rik van Riel <riel@redhat.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Linux 2.4.25-rc1
Message-ID: <20040301233804.GC5447@pacific.net.au>
References: <Pine.LNX.4.44.0403011209200.4148-100000@dmt.cyclades> <Pine.LNX.4.44.0403011020190.21897-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403011020190.21897-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2004 at 10:20:46AM -0500, Rik van Riel wrote:
> On Mon, 1 Mar 2004, Marcelo Tosatti wrote:
> > > INIT: Sending processes the TERM signal
> > > memory.c:100: bad pmd 000001e3.
> > > memory.c
> > 
> > This looks like hardware fault to me or a (maybe, not sure) badly
> > behaving driver. The inode-highmem modifications can't cause such
> > breakage, as far as I can see.
> 
> Agreed, this looks like a hardware fault.

I swapped CPU, memory and kernel all at once which resolved the
fault, as I had a second failure after this and I had to resolve
the fault ASAP so I couldn't trouble-shoot changing things one by one.

I'll re-upgrade to 2.4.25 after the system has been stable for around
a week; the original CPU and memory have been placed in a test box and
have shown no faults running a memory tester for 24 hours but perhaps
it was just a seating issue on a component; I'll report back if there
are any problems after re-upgrading.

David.
