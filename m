Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267481AbSLFBAY>; Thu, 5 Dec 2002 20:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267476AbSLFBAY>; Thu, 5 Dec 2002 20:00:24 -0500
Received: from [195.223.140.107] ([195.223.140.107]:55169 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S267481AbSLFBAX>;
	Thu, 5 Dec 2002 20:00:23 -0500
Date: Fri, 6 Dec 2002 02:08:06 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Norman Gaywood <norm@turing.une.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Maybe a VM bug in 2.4.18-18 from RH 8.0?
Message-ID: <20021206010806.GE1567@dualathlon.random>
References: <20021206111326.B7232@turing.une.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021206111326.B7232@turing.une.edu.au>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2002 at 11:13:26AM +1100, Norman Gaywood wrote:
> I think I have a trigger for a VM bug in the RH kernel-bigmem-2.4.18-18
> 
> The system is a 4 processor, 16GB memory Dell PE6600 running RH8.0 +
> errata. More details at the end of this message.

Thanks to lots of feedback from users in the last months I fixed all
known vm bugs todate that can be reproduced on those big machines.
They're all included in my tree and in the current UL/SuSE releases.
Over time I should have posted all of them to the kernel list in one way
or another.  The most critical ones are now pending for merging in
2.4.21pre. So in the meantime you want to try to reproduce on top of
2.4.20aa1 or the UL kernel and (unless your problem is a tape driver bug ;)
I'm pretty sure it will fix the problems on your big machine.

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.20aa1.gz
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.20aa1/

Hope this helps,

Andrea
