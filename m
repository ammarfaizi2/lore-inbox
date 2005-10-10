Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbVJJKy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbVJJKy1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 06:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbVJJKy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 06:54:27 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:11978 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750739AbVJJKy0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 06:54:26 -0400
Date: Mon, 10 Oct 2005 11:54:23 +0100
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: subbie subbie <subbie_subbie@yahoo.com>
Cc: Jon Burgess <jburgess@uklinux.net>, linux-kernel@vger.kernel.org
Subject: Re: 3Ware 9500S-12 RAID controller -- poor performance
Message-ID: <20051010105423.GA11982@gallifrey>
References: <4346EA35.90700@uklinux.net> <20051010104217.20341.qmail@web30305.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051010104217.20341.qmail@web30305.mail.mud.yahoo.com>
User-Agent: Mutt/1.4.1i
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.6.11-1.14_FC3 (i686)
X-Uptime: 11:51:46 up 37 days, 23:18, 38 users,  load average: 0.06, 0.04, 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* subbie subbie (subbie_subbie@yahoo.com) wrote:
> OK,
> 
> I now dumped RAID5 and am running all of my 12 disks
> separately each partitioned with XFS.
>
> 
> I did a very crude test of reading a single 1GB file
> from each of my disks in parallel by putting 12 dd
> processes into the background. Each file was read at
> approximately 35MB/s giving an aggragate of a little
> over 400MB/s.   According to 3Ware support, 400MB/s is
> the "theoretical maximum" of this controller.  I'm
> very happy with these results.

Nice.  Have you tried Software RAID5 on top of that?
I would be very interested to know how software RAID5
goes relative to the 3Ware hardware.


Dave
--
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
