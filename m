Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261996AbUCSUgs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 15:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262017AbUCSUgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 15:36:48 -0500
Received: from ns.suse.de ([195.135.220.2]:34739 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261996AbUCSUgq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 15:36:46 -0500
Subject: Re: True  fsync() in Linux (on IDE)
From: Chris Mason <mason@suse.com>
To: reiser@namesys.com
Cc: Peter Zaitsev <peter@mysql.com>, Jens Axboe <axboe@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <405B58BB.1020208@namesys.com>
References: <1079572101.2748.711.camel@abyss.local>
	 <20040318064757.GA1072@suse.de> <1079639060.3102.282.camel@abyss.local>
	 <20040318194745.GA2314@suse.de>  <1079640699.11062.1.camel@watt.suse.com>
	 <1079641026.2447.327.camel@abyss.local>
	 <1079642001.11057.7.camel@watt.suse.com>
	 <1079642801.2447.369.camel@abyss.local>
	 <1079643740.11057.16.camel@watt.suse.com>
	 <1079644190.2450.405.camel@abyss.local>
	 <1079644743.11055.26.camel@watt.suse.com>  <405AA9D9.40109@namesys.com>
	 <1079704347.11057.130.camel@watt.suse.com>
	 <1079724411.2576.178.camel@abyss.local>
	 <1079727833.11062.200.camel@watt.suse.com>  <405B58BB.1020208@namesys.com>
Content-Type: text/plain
Message-Id: <1079728706.11061.210.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 19 Mar 2004 15:38:27 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-03-19 at 15:31, Hans Reiser wrote:
> Chris Mason wrote:
> 
> >
> >>- It depends on type of write (if it changes mata data or not)
> >>- Finally it depends on file system and even journal mount options
> >>
> >>    
> >>
> >All of the above is correct.
> >  
> >
> Doesn't the above statement contradict the following?:
> 
Sorry for the confusion, I thought he was asking about 2.4.x. 

> >In 2.6 does fsync always insert a write barrier when the metadata 
> >> journaling option is set for reiserfs?
> >    
> >
> 
> Yes, fsync is done in the 2.6 patches. 
> 
> and I was imprecise, I should have asked, does fsync flush the disk 
> cache regardless of what mount options are set or data/metadata touched 
> in the 2.6 patches?
> 

-chris


