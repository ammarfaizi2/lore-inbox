Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422781AbWHXXQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422781AbWHXXQP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 19:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422783AbWHXXQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 19:16:15 -0400
Received: from ns2.suse.de ([195.135.220.15]:4060 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1422781AbWHXXQP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 19:16:15 -0400
From: Andi Kleen <ak@suse.de>
To: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: boot failure, "DWARF2 unwinder stuck at 0xc0100199"
Date: Fri, 25 Aug 2006 01:16:08 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Jan Beulich <jbeulich@novell.com>, linux-kernel@vger.kernel.org
References: <20060820013121.GA18401@fieldses.org> <20060822174251.GB16145@fieldses.org> <20060824224031.GA14188@fieldses.org>
In-Reply-To: <20060824224031.GA14188@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608250116.08083.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 25 August 2006 00:40, J. Bruce Fields wrote:
> On Tue, Aug 22, 2006 at 01:42:51PM -0400, J. Bruce Fields wrote:
> > On Tue, Aug 22, 2006 at 10:01:36AM +0200, Andi Kleen wrote:
> > > On Tuesday 22 August 2006 06:20, Andrew Morton wrote:
> > > > Has anyone even tried to reproduce Bruce's crash?
> > > 
> > > I looked at it a bit, but it puzzles me. The chaining for the interrupt stacks
> > > on i386 -- which is what seems to be corrupted here -- shouldn't have changed at all 
> > > by the unwinder changes.
> > > 
> > > I suspect it would crash without unwinder too. Bruce, do you get the 
> > > same crash when you boot with "call_trace=old" ? 
> > 
> > After appending "call_trace=old" to the boot commandline, and it booted
> > succesfully.
> 
> Do you consider this closed, or do you need more information from me?

It's not closed, but i can probably reproduce it myself.
-Andi

