Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262231AbUCEGWL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 01:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262223AbUCEGWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 01:22:11 -0500
Received: from [202.65.75.150] ([202.65.75.150]:28626 "EHLO
	pythia.bakeyournoodle.com.") by vger.kernel.org with ESMTP
	id S262231AbUCEGWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 01:22:09 -0500
From: Tony Breeds <tony@bakeyournoodle.com>
Date: Fri, 5 Mar 2004 14:16:43 +0800
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.4-rc2: scripts/modpost.c
Message-ID: <20040305061643.GH17221@bakeyournoodle.com>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
References: <20040304172923.6045760e.rddunlap@osdl.org> <20040304212440.30fc8674.randy.dunlap@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040304212440.30fc8674.randy.dunlap@verizon.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2004 at 09:24:40PM -0800, Randy.Dunlap wrote:
 
> The comment and code certainly don't match, and your patch makes sense
> to me.  However, I can't reproduce the problem that you describe.
> 
> I built the kernel image and modules in "www.osdl.org/264rc2/build1",
> and all *.mod.c and *.ko ended up there with no problems.
> Then I modified modpost.c (from 2.6.4-rc1, without your patch) to
> print the "stripped" module names (without the trailing ".o")
> and saw a list like this:
> modpost: stripped mod.name=[fs/jfs/jfs]
> 
> so where are the parent directory names that are causing problems
> for you coming from?

When building external modules.

Yours Tony

        linux.conf.au       http://lca2005.linux.org.au/
	Apr 18-23 2005      The Australian Linux Technical Conference!

