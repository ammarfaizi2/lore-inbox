Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316587AbSGQS03>; Wed, 17 Jul 2002 14:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316544AbSGQSZ3>; Wed, 17 Jul 2002 14:25:29 -0400
Received: from bgm-24-169-49-60.stny.rr.com ([24.169.49.60]:4602 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S316465AbSGQSYU>; Wed, 17 Jul 2002 14:24:20 -0400
Date: Wed, 17 Jul 2002 13:31:22 -0400 (EDT)
From: Steven Rostedt <rostedt@stny.rr.com>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: Steven Rostedt <rostedt@stny.rr.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Reserve memory from the command line
Message-ID: <Pine.LNX.4.44.0207171307380.29293-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Today I just discoved that my Toshiba laptop has a small bit of bad 
memory.  So I went on looking for a way to reserve the memory area from 
the command line, because I run several kernels for various reasons and 
that it would be easiest to just modify lilo.conf.

After seaching the web and scanning the source code I realize that there 
are only patches to do this and not in the vanilla kernel.  I was 
wondering why such a usefull feature is not in the kernel?

I'm using kernel versions 2.4.7 to 2.4.18 and didn't want to go patching 
each one.  I'll probably just hardcode the bad memory as reserved and be 
done with it.

Is this feature planned on becoming part of the kernel, at least as a 
config option, and if not, then why not?

If it is already there, and I missed it, please let me know.

Thanks,

Steven Rostedt

