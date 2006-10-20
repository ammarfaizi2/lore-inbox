Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992620AbWJTScJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992620AbWJTScJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 14:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992613AbWJTScJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 14:32:09 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:36370 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030298AbWJTScH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 14:32:07 -0400
Date: Fri, 20 Oct 2006 19:31:59 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [0/3] 2.6.19-rc2: known regressions
Message-ID: <20061020183159.GB8894@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0610130941550.3952@g5.osdl.org> <20061014111458.GI30596@stusta.de> <20061015122453.GA12549@flint.arm.linux.org.uk> <20061015124210.GX30596@stusta.de> <20061019081753.GA29883@flint.arm.linux.org.uk> <20061020180722.GA8894@flint.arm.linux.org.uk> <20061020111900.30d3cb03.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061020111900.30d3cb03.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2006 at 11:19:00AM -0700, Andrew Morton wrote:
> On Fri, 20 Oct 2006 19:07:22 +0100
> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> 
> > > > Subject    : undefined reference to highest_possible_node_id
> > > > References : http://lkml.org/lkml/2006/9/4/233
> > > >              http://lkml.org/lkml/2006/10/15/11
> > > > Submitter  : Olaf Hering <olaf@aepfle.de>
> > > > Caused-By  : Greg Banks <gnb@melbourne.sgi.com>
> > > >              commit 0f532f3861d2c4e5aa7dcd33fb18e9975eb28457
> > > > Status     : unknown
> > > 
> > > Looking at this commit and the mails, it was known on the 4th September
> > > that this patch caused build errors while this change was in -mm, yet it
> > > still found its way into mainline on 2nd October.
> > > 
> > > Is anyone going to look at fixing this problem, or should we be asking
> > > for the commit to be reverted?
> > 
> > Since everyone seems intent at ignoring this issue, here's a patch to
> > try to solve it.
> 
> I sent the below to Linus yesterday...

Ah, okay.  Must not have poped out of the other side of Linus by 6am GMT
then.  (We also seem to have non-working git snapshots again, so when I
looked at the ARM kautobuild it showed the same old errors.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
