Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161340AbWKEQn4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161340AbWKEQn4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 11:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161341AbWKEQn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 11:43:56 -0500
Received: from mx1.mandriva.com ([212.85.150.183]:16258 "EHLO mx1.mandriva.com")
	by vger.kernel.org with ESMTP id S1161340AbWKEQnx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 11:43:53 -0500
Date: Sun, 5 Nov 2006 14:43:45 -0200
From: Arnaldo Carvalho de Melo <acme@mandriva.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, lwn@lwn.net,
       linux-mtd@lists.infradead.org
Subject: Re: Fw: Top 100 inline functions (make allyesconfig) was Re: [ANNOUNCE] pahole and other DWARF2 utilities
Message-ID: <20061105164344.GB3363@mandriva.com>
References: <20061104132050.4950866b.akpm@osdl.org> <1162708337.3374.21.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1162708337.3374.21.camel@shinybook.infradead.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 05, 2006 at 02:32:17PM +0800, David Woodhouse wrote:
> On Sat, 2006-11-04 at 13:20 -0800, Andrew Morton wrote:
> > cfi_build_cmd() is nutty. 
> 
> Damn right it's nutty. Imagine the number of ways you can wire up 1-8
> flash chips in either 8-bit or 16-bit mode to a bus which is between 8
> and 64 bits wide. Deal with it in software, with a "chip driver"
> abstraction which knows what data to put at which address on each
> _chip_, and which needs to calculate the corresponding bus data/address.
> 
> In the sensible case where you build in support for what you have -- one
> interleave, one mode, one bus size -- it's simple. And that's why it's
> inline. This is one of the cases where 'allyesconfig' just doesn't make
> much sense.
> 
> I'm not entirely averse to taking it out-of-line, but show me data on
> the interesting case rather than the allyesconfig case.

See my Answer to Adrian, it was just extreme testing the tools, I'll use
config files shipped by distros to get even more interesting and down to
earth results.

- Arnaldo
