Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271789AbRHRGjQ>; Sat, 18 Aug 2001 02:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271790AbRHRGiz>; Sat, 18 Aug 2001 02:38:55 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:22278 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S271789AbRHRGiy>;
	Sat, 18 Aug 2001 02:38:54 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200108180639.f7I6d73116969@saturn.cs.uml.edu>
Subject: Re: more kernel .01
To: fattymikefx@yahoo.com
Date: Sat, 18 Aug 2001 02:39:07 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010817204358.38BAB501D7@localhost.localdomain> from "tristan" at Aug 17, 2001 04:43:57 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tristan writes:

> The reason i was hoping to run an old version of the kernel,
> .01 or .02(as someone proposed), is so i can use it as a basis
> for learning to add on to, compile, and change an os's kernel.
> I know i can do this with all kernels, but the .01 kernel is very small

The 0.01 kernel is very crude. The keyboard and IDE drivers are
written in assembly. The memory management uses 1 page table for
everything, with segmentation used to split it up into 63 processes
of 64 MB each plus a 64 MB kernel space. Swap isn't supported, so
you'll need at least 4 MB of RAM to run gcc.

> and the very beginning of the kernel so i can build on it. i am 
> open to installing say red hat 5.2 and then running .01 on a 

Red Hat is kind of new. :-) Use an old Linux distribution like MCC
or Tamu. Those came first, then SLS, then Slackware and Yggdrasil.
I gave you a URL for a slightly-hacked MCC that might do the job.

Remember to use the minix filesystem instead of ext2.
