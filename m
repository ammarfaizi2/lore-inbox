Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276207AbRI1Rnm>; Fri, 28 Sep 2001 13:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276199AbRI1Rnd>; Fri, 28 Sep 2001 13:43:33 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:50943 "EHLO
	e32.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S276200AbRI1RnU>; Fri, 28 Sep 2001 13:43:20 -0400
Date: Fri, 28 Sep 2001 10:50:05 -0700
From: "Martin J. Bligh" <fletch@aracnet.com>
Reply-To: "Martin J. Bligh" <fletch@aracnet.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Adding a printk in start_secondary breaks 2.4.10, not 2.4.9 ??
Message-ID: <946825303.1001674205@[10.10.1.2]>
In-Reply-To: <E15n1Rz-0007lt-00@the-village.bc.nu>
X-Mailer: Mulberry/2.0.5 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The console locking changes have I suspect broken your bandaid. I guess
> this time you need to fix it properly. Garbled panics normally occur when
> both cpus panic in parallel. That really wants some kind of timed spinlock
> to try and dump them one after the other

Humpf. You mean I've got to get rid of my disgusting hack? Sigh ... OK. ;-)

FWIW, I still think that means that the console locking changes are broken 
-
adding a printk shouldn't panic the kernel. I'll go look at the console 
locking
changes (*and* fix my disgusting hack ;-) )

M.

