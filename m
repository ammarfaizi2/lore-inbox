Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262873AbVAFPxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262873AbVAFPxk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 10:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262875AbVAFPxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 10:53:40 -0500
Received: from thunk.org ([69.25.196.29]:12472 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S262873AbVAFPxf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 10:53:35 -0500
Date: Thu, 6 Jan 2005 10:50:03 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Adrian Bunk <bunk@stusta.de>, William Lee Irwin III <wli@holomorphy.com>,
       Diego Calleja <diegocg@teleline.es>, Willy Tarreau <willy@w.ods.org>,
       davidsen@tmr.com, aebr@win.tue.nl, solt2@dns.toxicfilms.tv,
       linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
Message-ID: <20050106155003.GA22502@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Adrian Bunk <bunk@stusta.de>,
	William Lee Irwin III <wli@holomorphy.com>,
	Diego Calleja <diegocg@teleline.es>,
	Willy Tarreau <willy@w.ods.org>, davidsen@tmr.com, aebr@win.tue.nl,
	solt2@dns.toxicfilms.tv, linux-kernel@vger.kernel.org
References: <20050103011935.GQ29332@holomorphy.com> <20050103053304.GA7048@alpha.home.local> <20050103142412.490239b8.diegocg@teleline.es> <20050103134727.GA2980@stusta.de> <20050104125738.GC2708@holomorphy.com> <20050104150810.GD3097@stusta.de> <20050104153445.GH2708@holomorphy.com> <20050104165301.GF3097@stusta.de> <20050104210117.GA7280@thunk.org> <20050106094519.GD20203@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050106094519.GD20203@logos.cnet>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 07:45:19AM -0200, Marcelo Tosatti wrote:
> 
> You got to be kidding now?
> 
> 99% of the features distributions have applied to their 2.4 based kernels 
> are "enterprise" features such as direct IO, AIO, etc.
> 
> Really I can't recall any "attempt to make 2.4 stable" from the distros,
> its mostly "attempt to backport nice v2.6 feature".

Sorry, those were two separate points; I should have been more careful
to keep the two separate.

I believe 2.4 has been less successful than other stable series for
two reasons.  The first is the very large divergence of what the
distributions (and therefore most users) were actually using from each
other and from kernel.org.  The second is the lack of stability, in
particular with systems with HIGHMEM configured, where low memory
exhuastion is the first thing I suspect when a customer tells me that
a 2.4-based system with a lot of memory freezes up.

						- Ted
