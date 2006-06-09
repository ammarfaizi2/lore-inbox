Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030265AbWFIQFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030265AbWFIQFg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 12:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030262AbWFIQFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 12:05:35 -0400
Received: from [80.71.248.82] ([80.71.248.82]:35471 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S1030263AbWFIQFc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 12:05:32 -0400
X-Comment-To: Jeff Garzik
To: Jeff Garzik <jeff@garzik.org>
Cc: Alex Tomas <alex@clusterfs.com>, Linus Torvalds <torvalds@osdl.org>,
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
	<448997FA.50109@garzik.org> <m3irnacohp.fsf@bzzz.home.net>
	<44899A1C.7000207@garzik.org>
From: Alex Tomas <alex@clusterfs.com>
Organization: HOME
Date: Fri, 09 Jun 2006 20:07:21 +0400
In-Reply-To: <44899A1C.7000207@garzik.org> (Jeff Garzik's message of "Fri, 09 Jun 2006 11:56:12 -0400")
Message-ID: <m3ac8mcnye.fsf@bzzz.home.net>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Jeff Garzik (JG) writes:

 JG> Think about how this will be deployed in production, long term.

 JG> If extents are not made default at some point, then no one will use
 JG> the feature, and it should not be merged.

sorry, I disagree. for example, NUMA isn't default and shouldn't be.
but we have it in the tree and any one may choose to use it. the same
with extents. let's have it in. but let's make clear it's experimental,
it makes sense for large files only, it isn't backward compatible and
so on.

thanks, Alex

