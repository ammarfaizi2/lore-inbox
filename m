Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262069AbVAYTLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbVAYTLQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 14:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbVAYTKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 14:10:42 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:8494
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262065AbVAYTKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 14:10:03 -0500
Date: Tue, 25 Jan 2005 20:09:58 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: CVSps@dm.cobite.com, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org, Andreas Gruenbacher <agruen@suse.de>
Subject: Re: kernel CVS troubles with cvsps
Message-ID: <20050125190958.GC7587@dualathlon.random>
References: <20050125164203.GY7587@dualathlon.random> <tnxsm4po2o6.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tnxsm4po2o6.fsf@arm.com>
X-AA-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-AA-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
X-Cpushare-GPG-Key: 1024D/4D11C21C 5F99 3C8B 5142 EB62 26C3  2325 8989 B72A 4D11 C21C
X-Cpushare-SSL-SHA1-Cert: 3812 CD76 E482 94AF 020C  0FFA E1FF 559D 9B4F A59B
X-Cpushare-SSL-MD5-Cert: EDA5 F2DA 1D32 7560  5E07 6C91 BFFC B885
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 05:10:17PM +0000, Catalin Marinas wrote:
> I noticed this problem some time ago when trying to see whether the
> darcs repository is consistent with the BK one:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=110026570201544&w=2
> 
> A solution is to use the "(Logical change ...)" string within each
> file's commit log instead of the date (I realised that it is simpler
> to write a shell script to generate the diffs rather than modifying
> cvsps).

Thanks for the confirmation. To me this hour difference looks like a bug
in bkcvs. It would be nice to get it fixed so we don't have to
workaround it in cvsps or hack around more scripts.

Thanks.
