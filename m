Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263295AbUDAWga (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 17:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263124AbUDAWga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 17:36:30 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:35722
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263301AbUDAWgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 17:36:20 -0500
Date: Fri, 2 Apr 2004 00:36:19 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com
Subject: Re: disable-cap-mlock
Message-ID: <20040401223619.GB18585@dualathlon.random>
References: <20040401135920.GF18585@dualathlon.random> <Pine.LNX.4.44.0404011443250.5589-100000@chimarrao.boston.redhat.com> <20040401115252.7cdb9d6f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040401115252.7cdb9d6f.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2004 at 11:52:52AM -0800, Andrew Morton wrote:
> Rik van Riel <riel@redhat.com> wrote:
> >
> >  One of the main reasons for the mlock rlimit is so that
> >  security conscious people can let normal users' gpg
> >  mlock a few pages.
> 
> Could you please refresh-n-send the RLIMIT_MEMLOCK patch?

I asked it to Rik too but he redirected me at some rpm, but luckily
Marc-Christian extracted it and he posted it on l-k some week ago, so
you can just check l-k (From: Marc-Christian) and you'll find it. It's
against 2.4 however. Problem is that it's absolutely useless for the
problem I had to solve, or I would be using it already instead.
