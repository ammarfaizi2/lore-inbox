Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267455AbUIZCFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267455AbUIZCFl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 22:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269476AbUIZCFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 22:05:41 -0400
Received: from out004pub.verizon.net ([206.46.170.142]:45700 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP id S267455AbUIZCFi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 22:05:38 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm3 breaks amanda (was: 2.6.9-rc2-mm3)
Date: Sat, 25 Sep 2004 22:05:36 -0400
User-Agent: KMail/1.7
Cc: Matthias Andree <matthias.andree@gmx.de>, Andrew Morton <akpm@osdl.org>
References: <20040924014643.484470b1.akpm@osdl.org> <200409251437.17017.gene.heskett@verizon.net> <20040925213039.GB480@merlin.emma.line.org>
In-Reply-To: <20040925213039.GB480@merlin.emma.line.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409252205.36750.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [151.205.50.119] at Sat, 25 Sep 2004 21:05:37 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 25 September 2004 17:30, Matthias Andree wrote:
>On Sat, 25 Sep 2004, Gene Heskett wrote:
>> Sounds to me as if amanda isn't setup correctly.  its working here
>> just fine with 1 server and 2 clients, one of which is the server
>> itself.  Running version 2.4.5b1-20040915 to virtual tapes on a
>> big disk.
>
>Is Amanda set up incorrectly if SuSE's default 2.6.5 kernel and a
>vanilla 2.6.7 work well even with clients, but 2.6.9-rc2-mm1 to -mm3
>versions fail at the same task, with the same Amanda installation
> and software?
>
>I only exchanged the kernel, nothing else. Same hardware, same
>user-space software.
>
>I doubt that it's Amanda's configuration. I'd expect a "stable"
>2.6.9-whatever kernel to be backwards compatible with its 2.6.X
>predecessors.

I build amanda from tarballs for exactly that reason, and I do it 
everytime Jean-Louis releases a new tarball on his web page at 
umontreal.edu.  I have, over the years, come from a 2.2 kernel and 
amanda-2.4.1, to 2.6.9-rc2-mm3 and amanda-2.4.5b1-20040915, building 
about 1/4th of the test kernels released, half of the amanda 
snapshots and have never, ever had a problem I could blame on a 
kernel version.  Tape changer problems out the wahzoo, finally giving 
up and converting to a large disk drive that is except for a gig of 
swap, all amanda's to play in as she sees fit.

If you play by amanda's rules, she is a very diligent servant.  I'd 
bet a bottle of suds that there is something in the docs that tells 
you how to make amanda run, and that you have skipped over. Please 
re-read them again.  Also, there is an amanda support group, 
amanda-users@amanda.org, where some user like me, or any of the 
authors can probably fix you right up.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.26% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
