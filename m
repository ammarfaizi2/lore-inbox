Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261585AbUJ0CbB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261585AbUJ0CbB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 22:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbUJ0CbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 22:31:00 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:51431 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S261585AbUJ0Cao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 22:30:44 -0400
Date: Wed, 27 Oct 2004 04:31:30 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Andrew Morton <akpm@osdl.org>
Cc: riel@redhat.com, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: lowmem_reserve (replaces protection)
Message-ID: <20041027023130.GT14325@dualathlon.random>
References: <417DCFDD.50606@yahoo.com.au> <Pine.LNX.4.44.0410262029210.21548-100000@chimarrao.boston.redhat.com> <20041027005425.GO14325@dualathlon.random> <20041027005637.GP14325@dualathlon.random> <20041027013522.GR14325@dualathlon.random> <20041026190856.1472b58e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041026190856.1472b58e.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2004 at 07:08:56PM -0700, Andrew Morton wrote:
> Andrea Arcangeli <andrea@novell.com> wrote:
> >
> > this _incremental_ 2/? patch should fix the longtanding kswapd issue
> >  vs protection algorithm
> 
> Could you please email the patch which this depends on?

it's against this one:

http://www.kernel.org/pub/linux/kernel/people/andrea/patches/v2.6/2.6.9/lowmem_reserve-2

(the patch only address the wakeup issue, the stop is still unsolved,
but it can be done in a separate patch)
