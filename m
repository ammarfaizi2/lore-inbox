Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268378AbUJTETj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268378AbUJTETj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 00:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266034AbUJTETg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 00:19:36 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:6571 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269503AbUJTES2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 00:18:28 -0400
Subject: Re: Linux v2.6.9 and GPL Buyout
From: Lee Revell <rlrevell@joe-job.com>
To: Ryan Anderson <ryan@michonline.com>
Cc: "Jeff V. Merkey" <jmerkey@drdos.com>, Dax Kelson <dax@gurulabs.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041020034524.GD10638@michonline.com>
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org>
	 <417550FB.8020404@drdos.com>
	 <1098218286.8675.82.camel@mentorng.gurulabs.com>
	 <41757478.4090402@drdos.com>  <20041020034524.GD10638@michonline.com>
Content-Type: text/plain
Message-Id: <1098245904.23628.84.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 20 Oct 2004 00:18:25 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-19 at 23:45, Ryan Anderson wrote:
> RCU - originally a paper, implemented in Dynix and in other operating
> systems from the paper (and patent), implemented in Linux as well.

You could also make a strong argument that that patent is invalid
because RCU is obvious.  I was doing this with perl and SQL before I
ever heard of RCU.  If you don't want to lock a table (or didn't realize
SQL had such a thing as table locking :-) you just fetch a value, make
some calculation on it, then do the update iff that value has not
changed.  If it has changed you fetch the new value and go back to step
1.  It's just the obvious way to update a shared data structure if you
have cmpxchg but no locking.

Lee 

