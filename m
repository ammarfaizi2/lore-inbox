Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbTLBNiJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 08:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbTLBNiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 08:38:09 -0500
Received: from mx2.it.wmich.edu ([141.218.1.94]:30906 "EHLO mx2.it.wmich.edu")
	by vger.kernel.org with ESMTP id S261753AbTLBNiF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 08:38:05 -0500
Message-ID: <3FCC95BB.60205@wmich.edu>
Date: Tue, 02 Dec 2003 08:38:03 -0500
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: Ionut Georgescu <george@physik.tu-cottbus.de>
CC: linux-kernel@vger.kernel.org,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Subject: Re: Linux 2.4 future
References: <Pine.LNX.4.44.0312011212090.13692-100000@logos.cnet> <200312011226.04750.nbensa@gmx.net> <20031202115436.GA10288@physik.tu-cottbus.de> <20031202120315.GK13388@conectiva.com.br> <20031202131311.GA10915@physik.tu-cottbus.de>
In-Reply-To: <20031202131311.GA10915@physik.tu-cottbus.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ionut Georgescu wrote:
> Because new hardware requires newest kernel, and neither I, nor the
> majority of the users out there have the knowledge to 'forward' apply
> patches.
> 
> Even if 2.4 is phasing out, the process has just begun and it will last
> a lot until 2.6 will be ready for production systems.
> 
> We are not talking about a fancy, experimental feature. We are talking
> about a mature, serious project, that has been traveling for 3 years
> along the 2.4 kernel and with even more years of testing and research
> behind. I find it just pitty for the linux kernel not to include it.
> 
> When going to a conference, you don't present the brand new stuff you
> have just computed or measured the night before, because you just can't
> know if it is correct or not. Instead, you will present older, but
> mature work, that you can swear on. The same with the 2.6 kernel.
> Everybody is pushing it in front, but no one is using it for production
> systems. XFS and 2.4 are, even together, old, mature work, that anybody
> would 'present' anywhere.
> 
> Regards,
> Ionut


The point was, the patch is perfectly and easily usable the way it is. 
There stands to be no reason to make it part of the vanilla kernel other 
than a very slight convenience factor for a small minority of users. 
Tosatti thinks that that versus changes to this stable kernel that touch 
common code are unacceptable.  Despite the maturity of the project, it 
just doesn't make sense to include it in the vanilla kernel, it would be 
a disservice to the rest of the users of 2.4.x kernels that do so for 
stability, not only in the not crashing sense, but also in the code-base 
  sense. And the number of users who don't use xfs so greatly outnumber 
the users that do that it's a mute point for Tosatti.
Just suck it up, plug on with the complex command of cat xfs.patch | 
patch -p1 or move up to 2.6.  Anyone using xfs can obviously do either 
already and everyone not can continue not being affected by new code if 
they dont want to.

