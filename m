Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284141AbRL1URk>; Fri, 28 Dec 2001 15:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287001AbRL1URb>; Fri, 28 Dec 2001 15:17:31 -0500
Received: from mout0.freenet.de ([194.97.50.131]:17122 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S287000AbRL1URZ>;
	Fri, 28 Dec 2001 15:17:25 -0500
Message-ID: <3C2CD326.100@athlon.maya.org>
Date: Fri, 28 Dec 2001 21:16:38 +0100
From: Andreas Hartmann <andihartmann@freenet.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20011225
X-Accept-Language: en-us
MIME-Version: 1.0
To: Kernel-Mailingliste <linux-kernel@vger.kernel.org>
Subject: [2.4.17/18pre] VM and swap - it's really unusable
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

Again, I did a rsync-operation as described in
"[2.4.17rc1] Swapping" MID <3C1F4014.2010705@athlon.maya.org>.

This time, the kernel had a swappartition which was about 200MB. As the 
swap-partition was fully used, the kernel killed all processes of knode.
Nearly 50% of RAM had been used for buffers at this moment. Why is there 
so much memory used for buffers?

I know I repeat it, but please:

	Fix the VM-management in kernel 2.4.x. It's unusable. Believe
	me! As comparison: kernel 2.2.19 didn't need nearly any swap for
	the same operation!

Please consider that I'm using 512 MB of RAM. This should, or better: 
must be enough to do the rsync-operation nearly without any swapping - 
kernel 2.2.19 does it!

The performance of kernel 2.4.18pre1 is very poor, which is no surprise, 
because the machine swaps nearly nonstop.


Regards,
Andreas Hartmann

