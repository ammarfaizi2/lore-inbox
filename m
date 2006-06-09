Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030424AbWFITUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030424AbWFITUu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 15:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030423AbWFITUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 15:20:49 -0400
Received: from [80.71.248.82] ([80.71.248.82]:36501 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S1030422AbWFITUs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 15:20:48 -0400
X-Comment-To: Linus Torvalds
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alex Tomas <alex@clusterfs.com>, Andreas Dilger <adilger@clusterfs.com>,
       Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
	<4488E1A4.20305@garzik.org>
	<20060609083523.GQ5964@schatzie.adilger.int>
	<44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org>
	<Pine.LNX.4.64.0606090836160.5498@g5.osdl.org>
	<m33beecntr.fsf@bzzz.home.net>
	<Pine.LNX.4.64.0606090913390.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606090933130.5498@g5.osdl.org>
	<20060609181020.GB5964@schatzie.adilger.int>
	<Pine.LNX.4.64.0606091114270.5498@g5.osdl.org>
	<m31wty9o77.fsf@bzzz.home.net>
	<Pine.LNX.4.64.0606091137340.5498@g5.osdl.org>
From: Alex Tomas <alex@clusterfs.com>
Organization: HOME
Date: Fri, 09 Jun 2006 23:22:12 +0400
Message-ID: <m3vera6snv.fsf@bzzz.home.net>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


IMHO ...

the main reason is that ext4 would be treated as a new generation
fs which will be used for lots of new features probably. and it
will take long to get into production-ready state. at the same
time, proposed patches (at least extents itself) are heavily
tested in production and could be made available for our users
very soon.

thanks, Alex


>>>>> Linus Torvalds (LT) writes:

 LT> On Fri, 9 Jun 2006, Alex Tomas wrote:
 >> 
 >> would "#if CONFIG_EXT3_EXTENTS" be a good solution then?

 LT> Let's put it this way:
 LT>  - have you had _any_ valid argument at all against "ext4"?

 LT> Think about it. Honestly. Tell me anything that doesn't work?

 LT> 		Linus
