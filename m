Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262260AbTCWDrR>; Sat, 22 Mar 2003 22:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262264AbTCWDrR>; Sat, 22 Mar 2003 22:47:17 -0500
Received: from dp.samba.org ([66.70.73.150]:26093 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262260AbTCWDrR>;
	Sat, 22 Mar 2003 22:47:17 -0500
Date: Sun, 23 Mar 2003 14:55:23 +1100
From: Anton Blanchard <anton@samba.org>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: smp overhead, and rwlocks considered harmful
Message-ID: <20030323035523.GF5981@krispykreme>
References: <20030322175816.225a1f23.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030322175816.225a1f23.akpm@digeo.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> One thing is noteworthy: ia32's read_unlock() is buslocked, whereas
> spin_unlock() is not.  

Dont forget bitops/atomics used as spinlocks like the rmap pte chain lock.

Anton
