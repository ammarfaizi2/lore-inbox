Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314087AbSEAXGC>; Wed, 1 May 2002 19:06:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314089AbSEAXGB>; Wed, 1 May 2002 19:06:01 -0400
Received: from air-2.osdl.org ([65.201.151.6]:59918 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S314087AbSEAXGB>;
	Wed, 1 May 2002 19:06:01 -0400
Date: Wed, 1 May 2002 16:05:48 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Brian Gerst <bgerst@didntduck.org>
cc: Andrew Morton <akpm@zip.com.au>, Dave Jones <davej@suse.de>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] percpu updates
In-Reply-To: <3CD07209.5060301@didntduck.org>
Message-ID: <Pine.LNX.4.33L2.0205011602320.7436-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 May 2002, Brian Gerst wrote:

| Andrew Morton wrote:
| > Brian Gerst wrote:
| >
| >>These patches convert some of the existing arrays based on NR_CPUS to
| >>use the new per cpu code.
| >>
| > When I did this a couple of weeks back it failed in
| > mysterious ways and I ended up parking it.  Failure
| > symptoms included negative numbers being reported in
| > /proc/meminfo for "Locked" and "Dirty".
| >
| > How well has this been tested?  (If the answer
| > is "not very" then please wait until I've tested
| > it out...)
|
| Well, the answer is not very.  I don't have an SMP machine to do
| thorough testing on.  The best I can do is boot an SMP kernel on a UP
| machine.  I did check the disassembly of vmlinux, and it looked like it
| would work as advertised.

uh, do you know where you could find/use some SMP machines,
gratis ?  maybe OSDL ?  hint hint.

(of course, you could just let akpm do it on his smp system,
as he suggested)

-- 
~Randy

