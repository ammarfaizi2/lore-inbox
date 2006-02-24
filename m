Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbWBXPb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbWBXPb0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 10:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbWBXPb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 10:31:26 -0500
Received: from 217-133-42-200.b2b.tiscali.it ([217.133.42.200]:38710 "EHLO
	g5.random") by vger.kernel.org with ESMTP id S932278AbWBXPbZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 10:31:25 -0500
Date: Fri, 24 Feb 2006 16:31:08 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Arjan van de Ven <arjan@intel.linux.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [Patch 3/3] prepopulate/cache cleared pages
Message-ID: <20060224153108.GA5866@g5.random>
References: <1140686238.2972.30.camel@laptopd505.fenrus.org> <1140772543.2874.20.camel@laptopd505.fenrus.org> <43FED128.1030500@yahoo.com.au> <200602241327.27390.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602241327.27390.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2006 at 01:27:26PM +0100, Andi Kleen wrote:
> I used the generic algorithm because Andrea originally expressed some doubts 
> on the correctness of the xadd algorithms and after trying to understand them 
> myself I wasn't sure myself. Generic was the safer choice.

Amittedly we never had bugreports for the xadd ones, but trust me that's
not a good reason to assume that they must be correct. I'd be more
confortable if somebody would provide a demonstration of their
correctnes. Overall I gave up also because I felt that the small gain
was by far not worth the risk.
