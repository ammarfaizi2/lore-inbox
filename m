Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278879AbRKFJWd>; Tue, 6 Nov 2001 04:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278709AbRKFJWX>; Tue, 6 Nov 2001 04:22:23 -0500
Received: from mail005.syd.optusnet.com.au ([203.2.75.229]:58861 "EHLO
	mail005.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S278714AbRKFJWT>; Tue, 6 Nov 2001 04:22:19 -0500
Date: Tue, 6 Nov 2001 20:22:12 +1100
To: linux-kernel@vger.kernel.org
Cc: riel@conectiva.com.br
Subject: Re: Scheduling of low-priority background processes
Message-ID: <20011106202212.A28518@beernut.flames.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011106190757.A28090@beernut.flames.org.au>
From: Kevin Easton <s3159795@student.anu.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I foolishly muttered:

> What if the SCHED_IDLE behaviour only applies when the process 
> is in userspace? Couldn't scheduler compare the process's 
> instruction pointer against the kernel/user break point, and 
> if the process is in the kernel, then just treat it like a 
> normal process? 

...eek.   I clearly wasn't thinking straight with that one.  There
isn't a (non-disgusting) way of determining in the scheduler if a
process is executing a syscall apart from sys_sched_yield, is there.

Carry on...

   - Kevin.

