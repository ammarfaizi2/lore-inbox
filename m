Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030235AbWFIPwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030235AbWFIPwA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 11:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030231AbWFIPwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 11:52:00 -0400
Received: from [80.71.248.82] ([80.71.248.82]:12690 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S1030225AbWFIPv6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 11:51:58 -0400
X-Comment-To: Jeff Garzik
To: Jeff Garzik <jeff@garzik.org>
Cc: Alex Tomas <alex@clusterfs.com>, Andreas Dilger <adilger@clusterfs.com>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       cmm@us.ibm.com, linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
	<4488E1A4.20305@garzik.org>
	<20060609083523.GQ5964@schatzie.adilger.int>
	<44898EE3.6080903@garzik.org> <m3r71ycprd.fsf@bzzz.home.net>
	<44899778.1010705@garzik.org>
From: Alex Tomas <alex@clusterfs.com>
Organization: HOME
Date: Fri, 09 Jun 2006 19:53:55 +0400
In-Reply-To: <44899778.1010705@garzik.org> (Jeff Garzik's message of "Fri, 09 Jun 2006 11:44:56 -0400")
Message-ID: <m3mzcmcoks.fsf@bzzz.home.net>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Jeff Garzik (JG) writes:

 JG> Alex Tomas wrote:
 JG> "ext3" will become more and more meaningless.  It could mean
 >> _any_ of  JG> several filesystem metadata variants, and the admin
 >> will have no clue  JG> which variant they are talking to until they
 >> try to mount the blkdev  JG> (and possibly fail the mount).
 >> debugfs <dev> -R stats | grep features ?

 JG> The question is, do you

 JG> a) expect users to run this magic command, and DTRT or

 JG> b) watch users boot w/ extents, accidentally do something silly like
 JG> writing data to a file, and become locked into a new subset of kernels?

at the moment there is no way to "boot w/ extents". you must enable
them by mount option.


thanks, Alex
