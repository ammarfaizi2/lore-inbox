Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262903AbRE3Xyv>; Wed, 30 May 2001 19:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262909AbRE3Xyl>; Wed, 30 May 2001 19:54:41 -0400
Received: from jalon.able.es ([212.97.163.2]:22916 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S262903AbRE3XyX>;
	Wed, 30 May 2001 19:54:23 -0400
Date: Thu, 31 May 2001 01:54:10 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: flush_dirty_buffers warning
Message-ID: <20010531015410.E1144@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.1.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -D__KERNEL__ -I/usr/src/linux-2.4.5-ac5/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686    -c -o buffer.o buffer.c
buffer.c:2561: warning: static declaration for `flush_dirty_buffers' follows non-static.

conflicts with include/linux/fs.h

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Linux Mandrake release 8.1 (Cooker) for i586
Linux werewolf 2.4.5-ac5 #1 SMP Thu May 31 00:01:43 CEST 2001 i686
