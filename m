Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbWHGOhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbWHGOhg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 10:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbWHGOhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 10:37:36 -0400
Received: from ns.suse.de ([195.135.220.2]:148 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932070AbWHGOhf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 10:37:35 -0400
To: linux-kernel@vger.kernel.org
Cc: apw@shadowen.org
Subject: Re: x86_64 command line truncated II
References: <20060806030809.2cfb0b1e.akpm@osdl.org>
	<44D742DD.6090004@shadowen.org> <p73wt9kprng.fsf@verdi.suse.de>
From: Andi Kleen <ak@suse.de>
Date: 07 Aug 2006 16:37:31 +0200
In-Reply-To: <p73wt9kprng.fsf@verdi.suse.de>
Message-ID: <p73slk8pq6s.fsf_-_@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> Andy Whitcroft <apw@shadowen.org> writes:
> 
> > It seems that the command line on x86_64 is being truncated during boot:
> 
> in mm right?
> > Will try and track it down.
> 
> Don't bother, it is likely "early-param" (the patch from
> hell). I'll investigate.

Following up myself ... 

Are you sure it's a regression? 2.6.17 does the same
and we always had that 255 character limit (I tried 
to increase it once, but it broke some old lilo setups) 

i386 should be the same btw.

-Andi
