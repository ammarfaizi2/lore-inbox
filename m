Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030184AbWFIP0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030184AbWFIP0i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 11:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965287AbWFIP0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 11:26:37 -0400
Received: from [80.71.248.82] ([80.71.248.82]:19922 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S1030184AbWFIP0g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 11:26:36 -0400
X-Comment-To: Jeff Garzik
To: Jeff Garzik <jeff@garzik.org>
Cc: Andreas Dilger <adilger@clusterfs.com>, Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       cmm@us.ibm.com, linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
	<4488E1A4.20305@garzik.org>
	<20060609083523.GQ5964@schatzie.adilger.int>
	<44898EE3.6080903@garzik.org>
From: Alex Tomas <alex@clusterfs.com>
Organization: HOME
Date: Fri, 09 Jun 2006 19:28:22 +0400
In-Reply-To: <44898EE3.6080903@garzik.org> (Jeff Garzik's message of "Fri, 09 Jun 2006 11:08:19 -0400")
Message-ID: <m3r71ycprd.fsf@bzzz.home.net>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 JG> "ext3" will become more and more meaningless.  It could mean _any_ of 
 JG> several filesystem metadata variants, and the admin will have no clue 
 JG> which variant they are talking to until they try to mount the blkdev 
 JG> (and possibly fail the mount).

debugfs <dev> -R stats | grep features ?


thanks, Alex
