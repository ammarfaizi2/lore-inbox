Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266274AbTA2QIb>; Wed, 29 Jan 2003 11:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266286AbTA2QIb>; Wed, 29 Jan 2003 11:08:31 -0500
Received: from franka.aracnet.com ([216.99.193.44]:63972 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S266274AbTA2QIa>; Wed, 29 Jan 2003 11:08:30 -0500
Date: Wed, 29 Jan 2003 08:17:44 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: kexec reboot code buffer
Message-ID: <1947260000.1043857063@titus>
In-Reply-To: <m165s855fr.fsf@frodo.biederman.org>
References: <3E31AC58.2020802@us.ibm.com> <m1znppco1w.fsf@frodo.biederman.org><3E35AAE4.10204@us.ibm.com> <203100000.1043705004@flay><m1n0ll68jd.fsf@frodo.biederman.org> <1470350000.1043770519@titus> <m165s855fr.fsf@frodo.biederman.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > I am fine with memory that is not physically contiguous.  The memory
>> > I really want the kernel is currently sitting on.....
>> 
>> Oh, in that case you should have no problem getting it from ZONE_NORMAL,
>> especially if you can wake up kswapd and wait for a few seconds.
> 
> Nope, kswapd will not free the kernels text segment.  So in practice
> I can use anything below 4GB. 

Oh, I'm well aware that the kernel won't get swapped out ;-) 
I was referring to the getting memory that's "not physically contiguous"
by waking up kswapd ;-)

> There is even a distribution built to be run completely out of a ramdisk. 
> http://warewulf-cluster.org/

Terrifying ;-)
  

M.

