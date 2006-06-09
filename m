Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030243AbWFIPzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030243AbWFIPzF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 11:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030242AbWFIPzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 11:55:04 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:62640 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030240AbWFIPzB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 11:55:01 -0400
To: Alex Tomas <alex@clusterfs.com>
cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       cmm@us.ibm.com, linux-fsdevel@vger.kernel.org,
       Andreas Dilger <adilger@clusterfs.com>
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3 
In-reply-to: Your message of Fri, 09 Jun 2006 19:28:22 +0400.
             <m3r71ycprd.fsf@bzzz.home.net> 
Date: Fri, 09 Jun 2006 08:53:57 -0700
Message-Id: <E1FojJ7-0002gC-9w@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 09 Jun 2006 19:28:22 +0400, Alex Tomas wrote:
>  JG> "ext3" will become more and more meaningless.  It could mean _any_ of 
>  JG> several filesystem metadata variants, and the admin will have no clue 
>  JG> which variant they are talking to until they try to mount the blkdev 
>  JG> (and possibly fail the mount).
> 
> debugfs <dev> -R stats | grep features ?

Sounds similar to cat /proc/cpuinfo.  How *do* we deal with processors
which have all these many different features?  Probably better than we
would if each variant were viewed as a different architecture.

Jeff's approach taken to the rediculous would mean that we'd have
ext versions 1-40 by now at least.  I don't think that helps much,
either.

I think the ext2/3 team has done a great job of providing compatibility.
It isn't perfect compatibility forwards *and* backwards, but moving
forwards always seems to be pretty reasonable.

gerrit
