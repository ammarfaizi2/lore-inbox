Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030205AbWFIQqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030205AbWFIQqn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 12:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030268AbWFIQqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 12:46:43 -0400
Received: from [80.71.248.82] ([80.71.248.82]:32490 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S1030205AbWFIQqm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 12:46:42 -0400
X-Comment-To: Linus Torvalds
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alex Tomas <alex@clusterfs.com>, Jeff Garzik <jeff@garzik.org>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org, Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
	<4488E1A4.20305@garzik.org>
	<20060609083523.GQ5964@schatzie.adilger.int>
	<44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org>
	<Pine.LNX.4.64.0606090836160.5498@g5.osdl.org>
	<m33beecntr.fsf@bzzz.home.net>
	<Pine.LNX.4.64.0606090913390.5498@g5.osdl.org>
From: Alex Tomas <alex@clusterfs.com>
Organization: HOME
Date: Fri, 09 Jun 2006 20:48:16 +0400
In-Reply-To: <Pine.LNX.4.64.0606090913390.5498@g5.osdl.org> (Linus Torvalds's message of "Fri, 9 Jun 2006 09:25:57 -0700 (PDT)")
Message-ID: <m3k67qb7hr.fsf@bzzz.home.net>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


so, instead of taking one (quite-well-tested) part that solves one of
the biggest ext3 limitation, you propose to start a new project and
get something in a year (probably) ?

I think about extents as a step-by-step way ...

thanks, Alex



>>>>> Linus Torvalds (LT) writes:

 LT> Just as an example: ext3 _sucks_ in many ways. It has huge inodes that 
 LT> take up way too much space in memory. It has absolutely disgusting code to 
 LT> handle directory reading and writing (buffer heads! In 2006!). It's 
 LT> conditional indexing code is horrible. Its performance absolutely sucks 
 LT> when the journal is being drained or something.

 LT> Are you going to improve on any of those _fundamnetal_ problems? Or are 
 LT> you going to make them worse?

 LT> Hint: I'm betting you're not going to improve them by adding more 
 LT> features.
