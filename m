Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282966AbRLVX00>; Sat, 22 Dec 2001 18:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282969AbRLVX0G>; Sat, 22 Dec 2001 18:26:06 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:51508 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S282966AbRLVXZ6>; Sat, 22 Dec 2001 18:25:58 -0500
Date: Sat, 22 Dec 2001 18:25:57 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Keith Owens <kaos@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Assigning syscall numbers for testing
Message-ID: <20011222182556.A19700@redhat.com>
In-Reply-To: <20011222140126.B19442@redhat.com> <17322.1009063106@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <17322.1009063106@ocs3.intra.ocs.com.au>; from kaos@sgi.com on Sun, Dec 23, 2001 at 10:18:26AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 23, 2001 at 10:18:26AM +1100, Keith Owens wrote:
> You did not read my mail all the way through, did you?  I said -
> 
> If the [user space] code cannot open /proc/dynamic_syscalls or cannot
> find the desired syscall name, fall back to the assigned syscall number
> (if any) or fail if there is no assigned syscall number.  By falling
> back to the assigned syscall number, new versions of the user space
> code are backwards compatible, on older kernels it will use the dynamic
> syscall number, on newer kernels it will use the assigned number.

No, that's not the case I'm talking about: what happens when a vendor 
starts shipping this patch and Linus decides to add a new syscall that 
uses a syscall number that the old kernel used for dynamic syscalls?

		-ben
-- 
Fish.
