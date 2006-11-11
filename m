Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947256AbWKKOlX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947256AbWKKOlX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 09:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947257AbWKKOlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 09:41:23 -0500
Received: from bigben2.bytemark.co.uk ([80.68.81.132]:40619 "EHLO
	bigben2.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S1947256AbWKKOlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 09:41:22 -0500
Date: Sat, 11 Nov 2006 14:41:11 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: jurriaan <thunder7@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: wanted: more informative message if root device can't be found/mounted
Message-ID: <20061111144111.GA28206@gallifrey>
References: <20061111085200.GA4167@amd64.of.nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061111085200.GA4167@amd64.of.nowhere>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.4.32 (i686)
X-Uptime: 14:32:03 up 186 days,  3:44,  2 users,  load average: 0.10, 0.56, 1.29
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* jurriaan (thunder7@xs4all.nl) wrote:

> When the kernel mentions it can't mount the root device, all information
> about the 12 harddisks in this system has long scrolled off the screen.
> 
> It would be really nice to see something like this:
> 
> kernel panic - unable to mount root device 09:02
> Possible devices:

I posted a patch to do this about 18 months ago against 2.6.11rc5:

http://marc.theaimsgroup.com/?l=linux-kernel&m=110946077026065&w=2

As people have pointed out the other problem is the lack of scroll
back after panic; if you have a reasonable number of partitions
then it is a pain.

Dave
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
