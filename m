Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264682AbUD2Owt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264682AbUD2Owt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 10:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264733AbUD2Owt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 10:52:49 -0400
Received: from florence.buici.com ([206.124.142.26]:56711 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S264682AbUD2Owr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 10:52:47 -0400
Date: Thu, 29 Apr 2004 07:52:46 -0700
From: Marc Singer <elf@buici.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@osdl.org>, brettspamacct@fastclick.com,
       linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Message-ID: <20040429145246.GD708@buici.com>
References: <409021D3.4060305@fastclick.com> <20040428170106.122fd94e.akpm@osdl.org> <409047E6.5000505@pobox.com> <40904A84.2030307@yahoo.com.au> <20040429005801.GA21978@buici.com> <40907AF2.2020501@yahoo.com.au> <20040429042047.GB26845@buici.com> <20040429083608.A8169@flint.arm.linux.org.uk> <4090DC89.6060603@yahoo.com.au> <20040429120419.A15866@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040429120419.A15866@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 12:04:19PM +0100, Russell King wrote:
> On Thu, Apr 29, 2004 at 08:44:25PM +1000, Nick Piggin wrote:
> > Anyway, Marc said he tried flushing the tlb and that didn't
> > solve his problem.
> 
> Nevertheless, when you have a TLB with ASIDs, there will be even less
> pressure to flush these entries from the TLB, so in effect we might
> as well save the expense of implementing the page aging in the first
> place.

Uh, oh. My FLA translator just broke.  Whatsa ASID?

