Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310264AbSCBCKn>; Fri, 1 Mar 2002 21:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310260AbSCBCKe>; Fri, 1 Mar 2002 21:10:34 -0500
Received: from slip-202-135-78-11.ad.au.prserv.net ([202.135.78.11]:44416 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S310262AbSCBCKQ>; Fri, 1 Mar 2002 21:10:16 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: benh@kernel.crashing.org
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        Hubertus Franke <frankeh@watson.ibm.com>
Subject: Re: [PATCH] Fast Userspace Mutexes. 
In-Reply-To: Your message of "Fri, 01 Mar 2002 01:46:19 BST."
             <20020301004619.5314@mailhost.mipsys.com> 
Date: Sat, 02 Mar 2002 10:34:54 +1100
Message-Id: <E16gwYA-0007E0-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020301004619.5314@mailhost.mipsys.com> you write:
> There seem to be a problem with PPC, you didn't put back the
> PPC405_ERR77 macro in your new implementation. That means you
> may hit a PPC 405gp CPU bugs and lose atomicity of lwarx/stwcx.

Oops... That comes from taking the 2.4 implementation (which I used
for testing) straight to 2.5.

Well spotted, thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
