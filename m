Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265711AbTB0SDF>; Thu, 27 Feb 2003 13:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265815AbTB0SDF>; Thu, 27 Feb 2003 13:03:05 -0500
Received: from smtp2.clear.net.nz ([203.97.37.27]:17897 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP
	id <S265711AbTB0SDE>; Thu, 27 Feb 2003 13:03:04 -0500
Date: Fri, 28 Feb 2003 07:16:31 +1300
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: Software Suspend Functionality in 2.5
In-reply-to: <20030227181220.A3082@in.ibm.com>
To: suparna@in.ibm.com
Cc: Linus Torvalds <torvalds@transmeta.com>, Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1046369790.2190.9.camel@laptop-linux.cunninghams>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1046238339.1699.65.camel@laptop-linux.cunninghams>
 <20030227181220.A3082@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I've looked at LKCD and seen that they have a provision for compressing
the pages which are written. Ideally, I'd like to see us sharing code
because I reckon there's a fair bit in common between the two projects.
For the moment, though, I haven't seriously considered implementing
compression. I've just been concentrating on getting things as stable as
possible under 2.4 (given that there's no driver model there), and
beginning to seek to port the changes to 2.5. Perhaps compression could
be added later, but I am worrying about the basics (getting the pages
saved in any form!) first.

On Fri, 2003-02-28 at 01:42, Suparna Bhattacharya wrote:
> Nigel,
> 
> When I noticed some of your discussions on swsusp mailing
> list earlier, a question that crossed my mind was whether
> you'd thought about the possibility of compression of data 
> at the time of copy. 
> 
> Would that have been another way to helped achieve the 
> objective you have in mind ? Do any issues come to mind ?
> 
> Regards
> Suparna
> 


