Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263065AbVGAEa6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263065AbVGAEa6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 00:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263189AbVGAEa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 00:30:58 -0400
Received: from smtpout3.uol.com.br ([200.221.4.194]:5024 "EHLO smtp.uol.com.br")
	by vger.kernel.org with ESMTP id S263065AbVGAEaw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 00:30:52 -0400
Date: Fri, 1 Jul 2005 01:30:39 -0300
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Ben Collins <bcollins@debian.org>
Cc: Andrew Morton <akpm@osdl.org>, Stefan Richter <stefanr@s5r6.in-berlin.de>,
       linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: Problems with Firewire and -mm kernels
Message-ID: <20050701043038.GA4537@ime.usp.br>
Mail-Followup-To: Ben Collins <bcollins@debian.org>,
	Andrew Morton <akpm@osdl.org>,
	Stefan Richter <stefanr@s5r6.in-berlin.de>,
	linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
References: <20050628161500.GA25788@phunnypharm.org> <20050701010157.GA7877@ime.usp.br> <20050701011226.GB2067@phunnypharm.org> <20050701024432.GA18150@ime.usp.br> <20050701031801.GA12915@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050701031801.GA12915@phunnypharm.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 30 2005, Ben Collins wrote:
> Try reverting just the sbp2.[ch] changes from the 2.6.13-rc1 tree.

Ok, I did that and it worked fine, thanks! I'm trying to upload the
resulting dmesg so that you can see yourself, but it seems that my
University's site isn't working for some reason. :-(

Oh, I got one warning when I was compiling sbp2.c (it was something like an
invalid initialization around line 27xx--yes, yes, I know that this doesn't
help much, but I don't have the log of the compilation here).

> I'll see if I can figure out why our tree and kernel tree have gotten so
> far out of whack and how such huge changes that don't seem to fix
> anything (like the large changes to sbp2) have gotten into the kernel
> proper without being tested. Most of the sbp2 changes seem to be a new
> feature rather than fixing minor or even major bugs.

Yes, it would help a lot if the fixes were included in 2.6.13 (final).


Thank you very much again, Rogério Brito.
-- 
Rogério Brito : rbrito@ime.usp.br : http://www.ime.usp.br/~rbrito
Homepage of the algorithms package : http://algorithms.berlios.de
Homepage on freshmeat:  http://freshmeat.net/projects/algorithms/
