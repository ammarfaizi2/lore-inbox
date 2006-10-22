Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbWJVWOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWJVWOX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 18:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWJVWOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 18:14:23 -0400
Received: from xenotime.net ([66.160.160.81]:52707 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750732AbWJVWOW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 18:14:22 -0400
Date: Sun, 22 Oct 2006 15:16:00 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Jeff Garzik <jeff@garzik.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       kernel-janitors@lists.osdl.org
Subject: Re: make pdfdocs broken in 2.6.19rc2 and needs fixes
Message-Id: <20061022151600.a21859df.rdunlap@xenotime.net>
In-Reply-To: <453BEA00.4000601@garzik.org>
References: <200610222347.42418.ak@suse.de>
	<453BEA00.4000601@garzik.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Oct 2006 18:00:32 -0400 Jeff Garzik wrote:

> Andi Kleen wrote:
> > When you do make pdfdocs  with 2.6.19rc2-git7 you get tons of error 
> > messages and  then some corrupted PDFs in the end.
> > 
> > Fixing that (I suppose it will just need comment fixes and
> > should not affect the code) should be a relatively easy task for 
> > a newbie and  would be useful for the 2.6.19 release.
> 
> What userland were you using?  Unfortunately with 'make *docs' that matters.
> 
> Unquestionably, there is breakage regardless of distro.

I find it easier to just use/check make htmldocs && make mandocs
to look for errors and to test fixes.  At least as a first pass.

---
~Randy
