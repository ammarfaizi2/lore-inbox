Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268458AbUHQVKB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268458AbUHQVKB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 17:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268456AbUHQVJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 17:09:07 -0400
Received: from out003pub.verizon.net ([206.46.170.103]:50560 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S268442AbUHQVIg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 17:08:36 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bio_uncopy_user mem leak
Date: Tue, 17 Aug 2004 17:08:29 -0400
User-Agent: KMail/1.6.82
Cc: Kurt Garloff <garloff@suse.de>, Andrew Morton <akpm@osdl.org>
References: <20040817155918.GA5312@tpkurt.garloff.de>
In-Reply-To: <20040817155918.GA5312@tpkurt.garloff.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408171708.29463.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [151.205.55.227] at Tue, 17 Aug 2004 16:08:30 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 August 2004 11:59, Kurt Garloff wrote:

Posted a patch for a memory leak.  I have no idea whats got into me, 
but I just applied this one to see if it has anything to do with my 
"possible dcache problem".

FWIW, I had to do it by hand even though it looked dead on for 
2.6.8-rc4/fs/bio.c

No errors when recompiling.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
