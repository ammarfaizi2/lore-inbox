Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbUDNTmd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 15:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbUDNTmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 15:42:32 -0400
Received: from mail.shareable.org ([81.29.64.88]:48289 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261430AbUDNTmb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 15:42:31 -0400
Date: Wed, 14 Apr 2004 20:41:49 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: READONLY_EXEC is a curious name
Message-ID: <20040414194149.GF12105@mail.shareable.org>
References: <20040414190653.GB12105@mail.shareable.org> <20040414212145.707555f6.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040414212145.707555f6.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> > PAGE_READONLY_EXEC is defined in <asm-x86_64/pgtable.h>.
> > 
> > Does anyone else think PAGE_READONLY_EXEC is an odd name for a set of
> > flags which enables read _and_ execute permission?  What about
> > PAGE_READEXEC instead?
> 
> It just follows the pattern there (default is with NX and _EXEC is
> the variant without NX). I don't care much either ways.

I asked because I'm about to submit a patch to clean up the Alpha
definitions and have to pick a name.  I see parisc picked
PAGE_EXECREAD for this.

-- Jamie
