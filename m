Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280845AbRKLRFf>; Mon, 12 Nov 2001 12:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280840AbRKLRFQ>; Mon, 12 Nov 2001 12:05:16 -0500
Received: from mailer.zib.de ([130.73.108.11]:30341 "EHLO mailer.zib.de")
	by vger.kernel.org with ESMTP id <S280738AbRKLRFJ>;
	Mon, 12 Nov 2001 12:05:09 -0500
Date: Mon, 12 Nov 2001 18:05:05 +0100
From: Sebastian Heidl <heidl@zib.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: doing a callback from the kernel to userspace
Message-ID: <20011112180505.A5446@csr-pc1.zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-www.distributed.net: 27 OGR packets (3.56 Tnodes) [4.21 Mnodes/s]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,

I read some of the signaling code and must admit that I could not extract the
necessary information from it. Ideally I'd like to call a user-supplied function
having just a pointer to this function and say the task_struct of the owning
process.
What steps are needed to savely do the callback ?  (How) can I retrieve the
necessary information from the task_struct ?

any pointers are welcome
_sh_

PS: Yes, I really do need this as signals form the kernel to userspace add to
    much latency (10 to 20 usecs) and I want to avoid waiting in a system call.

