Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263410AbTCNSYx>; Fri, 14 Mar 2003 13:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263424AbTCNSYx>; Fri, 14 Mar 2003 13:24:53 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:60853 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S263410AbTCNSYv>; Fri, 14 Mar 2003 13:24:51 -0500
Date: Fri, 14 Mar 2003 10:25:48 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andreas Dilger <adilger@clusterfs.com>, Alex Tomas <bzzz@tmi.comex.ru>
cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH] concurrent block allocation for ext2 against 2.5.64
Message-ID: <120000000.1047666348@flay>
In-Reply-To: <20030313165641.H12806@schatzie.adilger.int>
References: <m3el5bmyrf.fsf@lexa.home.net> <20030313015840.1df1593c.akpm@digeo.com> <m3of4fgjob.fsf@lexa.home.net> <20030313165641.H12806@schatzie.adilger.int>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> First of all, thanks for this work, Alex.  It's been a long time in coming.
> 
> One thing I would wonder about is whether we should be implementing this in
> ext2, or in ext3 only.  One of the decisions we made in the past is that we
> shouldn't necessarily implement everything in ext2 (especially features that
> complicated the code, and are only useful on high-end systems).
> 
> There was a desire to keep ext2 small and simple, and ext3 would get the
> fancy high-end features that make sense if you have a large filesystem
> that you would likely be using in conjunction with ext3 anyways.

Errrm ... if you want to start advocating that sort of thing, I suggest 
you make ext3 usable on high end systems first. At the moment, that makes 
no sense whatsoever. Ext3 still doesn't scale to big systems.

M.


