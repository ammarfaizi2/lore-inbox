Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261309AbVEKXH7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbVEKXH7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 19:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbVEKXH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 19:07:59 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:296
	"EHLO g5.random") by vger.kernel.org with ESMTP id S261309AbVEKXFa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 19:05:30 -0400
Date: Thu, 12 May 2005 01:05:23 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Timur Tabi <timur.tabi@ammasso.com>
Cc: William Jordan <bjordan.ics@gmail.com>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
Message-ID: <20050511230523.GO6313@g5.random>
References: <20050425203110.A9729@topspin.com> <4279142A.8050501@ammasso.com> <427A6A7E.8000604@ammasso.com> <427BF8E1.2080006@ammasso.com> <Pine.LNX.4.61.0505071304010.4713@goblin.wat.veritas.com> <427CD49E.6080300@ammasso.com> <Pine.LNX.4.61.0505071617470.5718@goblin.wat.veritas.com> <78d18e2050511131246075b37@mail.gmail.com> <20050511224947.GL6313@g5.random> <42828CF0.2080400@ammasso.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42828CF0.2080400@ammasso.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2005 at 05:53:36PM -0500, Timur Tabi wrote:
> Andrea Arcangeli wrote:
> 
> >If the problem appears again even after the last fix for the COW I did
> >last year, than it means we've another yet another bug to fix.
> 
> All of my memory pinning test cases pass when I use get_user_pages() with 
> kernels 2.6.7 and later.

Well then your problem was the cow bug, that was corrupting userland
with O_DIRECT too...
