Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964816AbWHWKbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbWHWKbI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 06:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbWHWKbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 06:31:07 -0400
Received: from ns1.suse.de ([195.135.220.2]:52179 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964816AbWHWKbG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 06:31:06 -0400
To: Stephane Eranian <eranian@frankl.hpl.hp.com>
Cc: eranian@hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/18] 2.6.17.9 perfmon2 patch for review: sampling format support
References: <200608230805.k7N85v1s000408@frankl.hpl.hp.com>
From: Andi Kleen <ak@suse.de>
Date: 23 Aug 2006 12:31:05 +0200
In-Reply-To: <200608230805.k7N85v1s000408@frankl.hpl.hp.com>
Message-ID: <p737j0z7nh2.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephane Eranian <eranian@frankl.hpl.hp.com> writes:

> This files contains the sampling format support.
> 
> Perfmon2 supports an in-kernel sampling buffer for performance
> reasons. Yet to ensure maximum flexibility to applications,
> the formats is which infmration is recorded into the kernel
> buffer is not specified by the interface. Instead it is
> delegated to a kernel plug-in modules called sampling formats.

This seems quote complicated. Who are the users of different sampling formats?

I assume the code would be considerable simpler if you hardcoded 
the perfmon2 format, right?

-Andi
