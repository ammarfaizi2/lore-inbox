Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275211AbRJNNs1>; Sun, 14 Oct 2001 09:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275224AbRJNNsR>; Sun, 14 Oct 2001 09:48:17 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:7880 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S275211AbRJNNsG>; Sun, 14 Oct 2001 09:48:06 -0400
Date: Sun, 14 Oct 2001 09:48:16 -0400
From: Chris Mason <mason@suse.com>
To: Alexander Viro <viro@math.psu.edu>, Ed Tomlinson <tomlins@CAM.ORG>
cc: linux-kernel@vger.kernel.org
Subject: Re: mount hanging 2.4.12
Message-ID: <2101790000.1003067296@tiny>
In-Reply-To: <Pine.GSO.4.21.0110140133580.3903-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0110140133580.3903-100000@weyl.math.psu.edu>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sunday, October 14, 2001 01:46:19 AM -0400 Alexander Viro
<viro@math.psu.edu> wrote:

> 
> 
> On Sun, 14 Oct 2001, Alexander Viro wrote:
> 
>> 	Deadlocks on lock_super().  I don't see any changes in that
>> area, though...
> 
> 
> Erm, wait...  What patches do you have applied?  After a second look
> at your objdump it seems that you've got spinlocks turned into semaphores.
> What the hell is going on there?

Ed, does this hang happen without the new reiserfs snapshot locking patch
applied?

-chris

