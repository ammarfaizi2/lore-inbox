Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262850AbTJ3URv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 15:17:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262853AbTJ3URu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 15:17:50 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3469 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262850AbTJ3URs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 15:17:48 -0500
Message-ID: <3FA171DD.5060406@pobox.com>
Date: Thu, 30 Oct 2003 15:17:33 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: 2.6.0-test9-mjb1
References: <14860000.1067544022@flay>
In-Reply-To: <14860000.1067544022@flay>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
> The patchset contains mainly scalability and NUMA stuff, and anything 
> else that stops things from irritating me. It's meant to be pretty stable, 
> not so much a testing ground for new stuff.
> 
> I'd be very interested in feedback from anyone willing to test on any 
> platform, however large or small.
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/2.6.0-test9/patch-2.6.0-test9-mjb1.bz2
> 
> Since 2.6.0-test8-mjb1 (~ = changed, + = added, - = dropped)
> 
> Notes: 
> 	Mostly a merge forwards.
> 
> Now in Linus' tree:
> 
> Dropped:
> 
> New:
> 
> + autoswap					Con Kolivas
> 	Auto-tune swapiness
> 
> + ext2_fix					Andrew Morton
> 	Fix a race in ext2
> 
> Pending:
> lotsa_sds
> config_numasched
> 4/4 split
> new kgdb
> list_of_lists
> Hyperthreaded scheduler (Ingo Molnar)
> scheduler callers profiling (Anton or Bill Hartner)
> Child runs first (akpm)
> Kexec
> e1000 fixes


Um...   any e1000 fixes you have, please forward them to me and Intel 
rather than letting them languish in a tree.

	Jeff



