Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264589AbTIJO0z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 10:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264640AbTIJO0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 10:26:55 -0400
Received: from mail013.syd.optusnet.com.au ([211.29.132.67]:48792 "EHLO
	mail013.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264589AbTIJO0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 10:26:52 -0400
Subject: Re: Efficient IPC mechanism on Linux
From: Stewart Smith <stewart@linux.org.au>
To: Luca Veraldi <luca.veraldi@katamail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <00f201c376f8$231d5e00$beae7450@wssupremo>
References: <00f201c376f8$231d5e00$beae7450@wssupremo>
Content-Type: text/plain
Message-Id: <1063203673.7631.35.camel@willster>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 11 Sep 2003 00:21:14 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hrm, you may find things related to the Password-Capability system and
the Walnut kernel of interest - these systems take this kind of IPC to
the extreme :) (ahhh... research OS hw & sw - except you *do not* want
to see the walnut source - it makes ppl want to crawl up and cry).

http://www.csse.monash.edu.au/~rdp/fetch/castro-thesis.ps

and check the Readme.txt at
http://www.csse.monash.edu.au/courseware/cse4333/rdp-ma terial/
for stuff on Multi and password-capabilities.

interesting stuff, the Castro thesis does do some comparisons to FreeBSD
(1.1 amazingly enough) - although the number of real world applications
on these systems is minimal (and in the current state impossible -
nobody can remember how to get userspace going on Walnut, we may have
broken it) and so real-world comparisons just don't really happen these
days. Maybe after a rewrite (removing some brain-damage of the original
design).

This is all related to my honors work,
http://www.flamingspork.com/honors/
although my site needs an update.
I'm working on the design and simulation of an improved storage system.


On Wed, 2003-09-10 at 03:30, Luca Veraldi wrote:
> Hi all.
> At the web page
> http://web.tiscali.it/lucavera/www/root/ecbm/index.htm
> You can find the results of my attempt in modifing the linux kernel sources
> to implement a new Inter Process Communication mechanism.
> 
> It is called ECBM for Efficient Capability-Based Messaging.
> 
> In the reading You can also find the comparison of ECBM 
> against some other commonly-used Linux IPC primitives 
> (such as read/write on pipes or SYS V tools).
> 
> The results are quite clear.
> 
> Enjoy.
> Luca Veraldi
> 
> 
> ----------------------------------------
> Luca Veraldi
> 
> Graduate Student of Computer Science
> at the University of Pisa
> 
> veraldi@cli.di.unipi.it
> luca.veraldi@katamail.com
> ICQ# 115368178
> ----------------------------------------
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

