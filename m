Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264634AbTDZJJa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 05:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264635AbTDZJJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 05:09:30 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:30168 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S264634AbTDZJJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 05:09:29 -0400
Date: Sat, 26 Apr 2003 11:21:38 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: rmoser <mlmoser@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Coding regulations
Message-ID: <20030426092138.GE23757@wohnheim.fh-wedel.de>
References: <200304252214120970.019AF211@smtp.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200304252214120970.019AF211@smtp.comcast.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 April 2003 22:14:12 -0400, rmoser wrote:
> 
> Yeah just a quick question.  Not that I am actually able to code kernel
> level drivers (I wish), but when I do code that would be part of one, I would
> prefer not to make it a hassle for others to impliment.
> 
> To the point, I tend to do C++ classes, then make a C interface.  Makes
> it easier for me to program.  Now, you may not want to mess with the C++
> and convert it over, plus you may not want C++ code in the kernel.  I am
> about to start on the compression code for the fast algorithm that may be
> used for kernel swap compression and compressed swap-on-ram, assuming
> these swap modules are implimented.  I don't want to cause any... oddities.
> 
> The C interfaces are just C functions that take a numerical handle which
> identifies a class in a self-sorting linked list, as well as all the other data that
> goes to each member function of the classes.  I can still do it in C alone but
> it's a little more work.  Just don't wanna mess anyone/anything up.

The kernel uses c only (plus a little asm, if there is just no other
possibility). If it is trivial for me to convert your c++ to c, I will
do that. But since I don't really speak c++, c would be nicer.

Jörn

-- 
Data dominates. If you've chosen the right data structures and organized
things well, the algorithms will almost always be self-evident. Data
structures, not algorithms, are central to programming.
-- Rob Pike
