Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269755AbUJWBuL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269755AbUJWBuL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 21:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269841AbUJWBsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 21:48:01 -0400
Received: from quechua.inka.de ([193.197.184.2]:5299 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S269805AbUJWBov (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 21:44:51 -0400
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Gigantic memory leak in linux-2.6.[789]!
Organization: Deban GNU/Linux Homesite
In-Reply-To: <200410221613.35913.ks@cs.aau.dk>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.6-20040906 ("Baleshare") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1CLAxd-0001cC-00@calista.eckenfels.6bone.ka-ip.net>
Date: Sat, 23 Oct 2004 03:44:49 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200410221613.35913.ks@cs.aau.dk> you wrote:
> When the loop has completed, the system use 124 MB memory more _each_ time.... 
> so it is pretty easy to make a denial-of-service attack :-(

for starters i recommend to look at "free" and only at the marked number:

             total       used       free     shared    buffers     cached
Mem:        126368     108432      17936          0       6532      42104
-/+ buffers/cache:      59796*     66572*
Swap:       262128      43400     218728

or at the swap numbers if you have low memory (like i do).

Gruss
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
