Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751064AbWGWBPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbWGWBPw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 21:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751066AbWGWBPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 21:15:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15034 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750960AbWGWBPw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 21:15:52 -0400
Date: Sat, 22 Jul 2006 18:15:32 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: davej@redhat.com, linux-kernel@vger.kernel.org,
       Ashok Raj <ashok.raj@intel.com>
Subject: Re: remove cpu hotplug bustification in cpufreq.
In-Reply-To: <20060722180602.ac0d36f5.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0607221813020.29649@g5.osdl.org>
References: <20060722194018.GA28924@redhat.com> <Pine.LNX.4.64.0607221707400.29649@g5.osdl.org>
 <20060722180602.ac0d36f5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 22 Jul 2006, Andrew Morton wrote:
> 
> It was just wrong in conception.  We should not and probably cannot fix it.
> Let's just delete it all, then implement version 2.

Well, I just got Ashok's trial patches which turns the thing into a rwsem 
as I outlined earlier.

I'll try them out. If they don't work, we should just delete the lock and 
go totally back to square 1.

		Linus
