Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314596AbSFEEqQ>; Wed, 5 Jun 2002 00:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317549AbSFEEqP>; Wed, 5 Jun 2002 00:46:15 -0400
Received: from 12-247-98-98.client.attbi.com ([12.247.98.98]:28545 "EHLO
	Server") by vger.kernel.org with ESMTP id <S314596AbSFEEqO>;
	Wed, 5 Jun 2002 00:46:14 -0400
Date: Tue, 4 Jun 2002 23:46:16 -0500
To: linux-kernel@vger.kernel.org
Subject: amd k6-3 L3 cache 
Message-ID: <20020605044616.GA3297@rabbit.online.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Peter Rabbitson <rabbit@rabbit.online.bg>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone. I have a question regarding hardware caches. When I compile the
kernel on k6/2 cpu I get messages identifying L1 cache of 64k and L2 cache of
1024k which are the actual hardware amounts. But kernel on a k6/3+ cpu gives
out this:
-------
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: L2 Cache: 256K (32 bytes/line)
CPU: After vendor init, caps: 008021bf c08029bf 00000000 00000002
CPU:     After generic, caps: 008021bf c08029bf 00000000 00000002
CPU:             Common caps: 008021bf c08029bf 00000000 00000002
------
Does this mean that I am actually loosing the benefit of having 1m of cache 
on the motherboard (in this case L3)? Or the kernel still uses transparrent
bios routines and stores data in L3? Or maybe such cpus shopuld run kernel
compiled for k7/athlon cpus? I would appreciate any comments or suggestions,
nevertheless I am more than non-proficient in programming. Just a curious
cat in the linux community :)

Peter

