Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262782AbTCQEtD>; Sun, 16 Mar 2003 23:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262784AbTCQEtD>; Sun, 16 Mar 2003 23:49:03 -0500
Received: from sdfw-ext.castandcrew.com ([63.113.17.130]:58359 "EHLO
	sddev.castandcrew.com") by vger.kernel.org with ESMTP
	id <S262782AbTCQEtC>; Sun, 16 Mar 2003 23:49:02 -0500
From: "Gregory K. Ruiz-Ade" <gregory@castandcrew.com>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.4.20 instability on bigmem systems?
Date: Sun, 16 Mar 2003 20:59:48 -0800
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200303131627.22572.gregory@castandcrew.com> <200303161815.11973.gregory@castandcrew.com> <20030317022646.GN20188@holomorphy.com>
In-Reply-To: <20030317022646.GN20188@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303162059.48245.gregory@castandcrew.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 16 March 2003 18:26, William Lee Irwin III wrote:
> If it didn't behave badly then it won't help to look at the stats.

I'm seriously at my wits end.  (Not because of you!  I hate vague 
problems...)  I have no idea why it behaved itself this time, just like i 
have no idea why it misbehaves.

Right now, I'm back to running 2.4.19 with the inode.c patch from one of the 
2.4.19-preXX-aaY kernels (see 
http://castandcrew.com/~gregory/lkmlstuff/burpr/2.4.19/patches) as the most 
stable thing we've gotten so far.

I'm going to write some scripts to run out of cron ever 5 minutes (or maybe 
even every minute) to collect meminfo, slabinfo, ps output, and whatever 
else i can think of.  What else would be useful to help you track down 
these problems?

Hopefully, the next time the system goes to hell, I'll have _something_ to 
give you.

As a side question, is bigmem >2GB?  I.e., if I pass "mem=2048m" to the 
kernel from lilo, will the bigmem stuff for the VM be disabled, or should I 
instead build a new kernel with high memory support turned off?  Also, with 
highmem support turned off, the max memory is 2GB, right?  I may well just 
ignore the high 6GB out of desperation to get a stable system until 2.6 is 
released.

Thanks again for taking the time.

Working on a migrain,
Gregory

-- 
Gregory K. Ruiz-Ade <gregory@castandcrew.com>
Sr. Systems Administrator
Cast & Crew Entertainment Services, Inc.

