Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263583AbUJ2Xqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263583AbUJ2Xqn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 19:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263727AbUJ2XqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 19:46:20 -0400
Received: from cantor.suse.de ([195.135.220.2]:35549 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263695AbUJ2XkP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 19:40:15 -0400
Date: Sat, 30 Oct 2004 01:37:51 +0200
From: Andi Kleen <ak@suse.de>
To: Chris Wright <chrisw@osdl.org>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove duplicate FAKE_STACK_FRAME macro
Message-ID: <20041029233751.GH31914@wotan.suse.de>
References: <20041029161456.S2357@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041029161456.S2357@build.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 04:14:56PM -0700, Chris Wright wrote:
> Hi Andi,
> 
> FAKE_STACK_FRAME macro is defined twice.  The one that gets used is in
> arch/x86_64/kernel/entry.S, and is slightly different codewise, although
> should have the same end result (uses pushq rather than addq %rsp + movq
> and has the extra dwarf annotations).  Looks like we can remove the dups?

Yes. Thanks. I added it to my tree.

-Andi
