Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278100AbRJKF0G>; Thu, 11 Oct 2001 01:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278106AbRJKFZ6>; Thu, 11 Oct 2001 01:25:58 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:7231 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S278100AbRJKFZo>; Thu, 11 Oct 2001 01:25:44 -0400
To: Till Immanuel Patzschke <tip@internetwork-ag.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Q] kernel vs user memory (how to get more kernel mem)
In-Reply-To: <3BC4B011.C61C8AB2@internetwork-ag.de>
From: ebiederman@uswest.net (Eric W. Biederman)
Date: 10 Oct 2001 23:16:14 -0600
In-Reply-To: <3BC4B011.C61C8AB2@internetwork-ag.de>
Message-ID: <m1het6vjs1.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Till Immanuel Patzschke <tip@internetwork-ag.de> writes:

> Hi,
> 
> another simple (?) question - sorry for asking.  There seems to be some
> (fixed?) ratio user ./. kernel memory.  How do I change the amount of kernel
> memory.  I got a reply telling the std ratio is 3:1 - where/how do I change it?
> Thanks for the help,

Hmm.  There is a fixed ration of the amount of virtual address space
with each user space process having 3GB of virutal address space and
the kernel having 1GB.

But since the kernel implements paging the kernel can use all of the
RAM in the system.  While often times user space applications don't
haven't implemented the logic to use it all.

So for a good answer we need to know your application and why it is a
concern.

Eric
