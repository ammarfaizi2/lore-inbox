Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261250AbUJ3S7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbUJ3S7a (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 14:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbUJ3S7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 14:59:30 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:39104 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261250AbUJ3S7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 14:59:25 -0400
Date: Sat, 30 Oct 2004 11:58:43 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Dave Jones <davej@redhat.com>, Christoph Hellwig <hch@infradead.org>,
       Andi Kleen <ak@suse.de>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Drop IRDA ISA dependency
Message-ID: <20041030185843.GB14420@taniwha.stupidest.org>
References: <20041029130846.3D6639DF0EA9@verdi.suse.de> <20041029134549.GA12705@infradead.org> <20041029202214.GC18508@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041029202214.GC18508@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 09:22:14PM +0100, Dave Jones wrote:

> Sounds like there is some confusion over what CONFIG_ISA means.

i think it was vague / different before maybe?

> I always understood it to mean 'We have ISA slots on this
> architecture' regardless of whether theres an ISA style LPC bus.

or pc card --- but this got separate recently didn't it?

> Its a means of disabling a whole slew of drivers that have no
> meaning on a particular platform (in Andi's case, x86-64).

maybe we want CONFIG_BUS_ISA and CONFIG_SLOT_ISA, the former meaning
we have bus/semantics the latter depends on the former and means
physical slots --- which would be used to prune the driver selection
choices?

