Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262015AbULHCWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbULHCWc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 21:22:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbULHCWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 21:22:32 -0500
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:27816 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S262009AbULHCWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 21:22:23 -0500
Date: Wed, 8 Dec 2004 03:22:12 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: nickpiggin@yahoo.com.au, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Time sliced CFQ io scheduler
Message-ID: <20041208022212.GI16322@dualathlon.random>
References: <20041202130457.GC10458@suse.de> <20041202134801.GE10458@suse.de> <20041202114836.6b2e8d3f.akpm@osdl.org> <20041202195232.GA26695@suse.de> <20041208003736.GD16322@dualathlon.random> <1102467253.8095.10.camel@npiggin-nld.site> <20041208013732.GF16322@dualathlon.random> <1102470428.8095.29.camel@npiggin-nld.site> <20041208020923.GG16322@dualathlon.random> <20041207181137.2998369c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041207181137.2998369c.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2004 at 06:11:37PM -0800, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> >  One hidden side effect of "as" is that by writing so slowly (and
> >  64KiB/sec really is slow), it increases the time it will take for a
> >  dirty page to be flushed to disk
> 
> The 64k/sec only happens for direct-io, and those pages aren't dirty.

I agree my above claim was wrong, thanks for correcting it.
