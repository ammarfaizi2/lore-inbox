Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274362AbRJNFqI>; Sun, 14 Oct 2001 01:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274368AbRJNFp7>; Sun, 14 Oct 2001 01:45:59 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:29587 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S274362AbRJNFps>;
	Sun, 14 Oct 2001 01:45:48 -0400
Date: Sun, 14 Oct 2001 01:46:19 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Ed Tomlinson <tomlins@CAM.ORG>
cc: linux-kernel@vger.kernel.org
Subject: Re: mount hanging 2.4.12
In-Reply-To: <Pine.GSO.4.21.0110140103210.3903-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0110140133580.3903-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 14 Oct 2001, Alexander Viro wrote:

> 	Deadlocks on lock_super().  I don't see any changes in that
> area, though...


Erm, wait...  What patches do you have applied?  After a second look
at your objdump it seems that you've got spinlocks turned into semaphores.
What the hell is going on there?


