Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261755AbUK2QgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbUK2QgE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 11:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261756AbUK2QgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 11:36:04 -0500
Received: from mx1.redhat.com ([66.187.233.31]:39882 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261755AbUK2QgA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 11:36:00 -0500
To: David Howells <dhowells@redhat.com>
Cc: Matthew Wilcox <matthew@wil.cx>, torvalds@osdl.org, hch@infradead.org,
       dwmw2@infradead.org, linux-kernel@vger.kernel.org,
       libc-alpha@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
References: <20041125210137.GD2849@parcelfarce.linux.theplanet.co.uk>
	<19865.1101395592@redhat.com>
	<orvfbtzt7t.fsf@livre.redhat.lsd.ic.unicamp.br>
	<12983.1101470307@redhat.com>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat Global Engineering Services Compiler Team
Date: 29 Nov 2004 14:34:52 -0200
In-Reply-To: <12983.1101470307@redhat.com>
Message-ID: <orhdn8vck3.fsf@livre.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 26, 2004, David Howells <dhowells@redhat.com> wrote:

> How about calling the interface headers "kapi*/" instead of "user*/". In case
> you haven't guessed, "kapi" would be short for "kernel-api".

I've seen kapi being used to reference the api exposed by the kernel
to modules, but not the abi exposed to userland.  ukabi sounds more
appropriate for the latter, although many people might wonder what's
with this United Kingdom ABI :-)

-- 
Alexandre Oliva             http://www.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
