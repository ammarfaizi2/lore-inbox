Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262668AbVDYRz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262668AbVDYRz2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 13:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262675AbVDYRz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 13:55:28 -0400
Received: from 113.135.160.66.in-arpa.com ([66.160.135.113]:16647 "EHLO
	furrylvs.randyg.org") by vger.kernel.org with ESMTP id S262668AbVDYRzV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 13:55:21 -0400
Message-ID: <426D2F03.2040001@bushytails.net>
Date: Mon, 25 Apr 2005 10:55:15 -0700
From: Randy Gardner <lkml@bushytails.net>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: ide-cd?  Can burn DVDs, just not read them...
References: <426972E5.4000408@bushytails.net> <20050425163436.GA15693@csclub.uwaterloo.ca>
In-Reply-To: <20050425163436.GA15693@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennart Sorensen wrote:
> Have you checked that the drive is running the latest firmware release
> for it?  Bad firmware causes all sorts of problems.

Don't have an easy way to test that; I'd have to take it back to the 
person with a dual-boot box, as I'm pretty sure their update utility is 
a windoze bianry...

But, since problems are also happening with my cd-rw drive (even with 
the dvd-rw out of the system), which I know worked before, I don't think 
it's a drive problem.


> What other device is it sharing the cable with?  Which is master and
> which is slave?

Originally it shared a cable with my cd-rw drive, but I've tried it both 
on its own cable and sharing with one of my hard drives, on both the 
ata/66 controller and the ata/100 raid controller, with no changes at all.

> Is it a 40 or 80 conductor ide cable?  Most 8x+ DVD writers want an 80
> conductor as far as I know (at least to operate at full speed).

80 conductor cables for all tests.  I might be able to dig up a 40 
conductor one for testing, but I don't think that'll help...

> Len Sorensen
> 

Someone suggested I try a binary search of kernel versions to figure out 
exactly when the cd-rw drive was broken (which worked before, unlike the 
dvd, which I have no idea if it ever worked), in an effort to figure out 
what caused it to break...  going to try this, but haven't had the 
time...  a long project.  :)


Thanks again,
--Randy

