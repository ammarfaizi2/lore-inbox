Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268548AbTCAOkj>; Sat, 1 Mar 2003 09:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268551AbTCAOkj>; Sat, 1 Mar 2003 09:40:39 -0500
Received: from franka.aracnet.com ([216.99.193.44]:39864 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S268548AbTCAOki>; Sat, 1 Mar 2003 09:40:38 -0500
Date: Sat, 01 Mar 2003 06:47:43 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Bill Huey <billh@gnuppy.monkey.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: kernel BUG at mm/memory.c:757! (2.5.62-mjb2)
Message-ID: <42040000.1046530062@[10.10.2.4]>
In-Reply-To: <20030301062200.GA4523@gnuppy.monkey.org>
References: <4450000.1045526067@flay> <4610000.1045583440@[10.10.2.4]> <20030223034730.GA3136@gnuppy.monkey.org> <20030223035048.GA3223@gnuppy.monkey.org> <20030301062200.GA4523@gnuppy.monkey.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I just found out that it could likely be related to the NVidia driver module
>> from Rik van Riel. Ooops.
> 
> Again, correction, I get a tons of these even without the NVidia driver
> module, so that's not the problem.
> 
> This problem is still pretty live unfortunately. Fixed in the new patchset ?
> 
> The problem doesn't seems fatal and the machine doesn't crash hard, but it's
> still a bug.

OK, this looks like the exit speedup stuff, which is removed in 63-mjb2,
could you retry with that? 

Thanks,

M.

