Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261663AbTHTQkq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 12:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262047AbTHTQkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 12:40:46 -0400
Received: from altern.org ([80.67.174.57]:54989 "HELO altern.org")
	by vger.kernel.org with SMTP id S261663AbTHTQkp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 12:40:45 -0400
Date: Wed, 20 Aug 2003 18:39:19 +0200 (CEST)
From: <linuxmodule@altern.org>
Subject: 2.6.0-test3 module compilation
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Message-Id: <S261663AbTHTQkp/20030820164045Z+1122@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to compile a module on 2.6.0-test3 kernel. The makefile i am using is a pretty normal one : 

CFLAGS = -D__KERNEL__ -DMODULE -I/usr/src/linux-2.6.0-test3/include -O
dummy.o: dummy.c

The module i am trying to compile is taken from the kernel itself (dummy network device driver). The
compilation works flawlessly but when i try to insert the module i get : invalid module format.
What am i doing wrong because i have modutils and module-init and both work, since the same module (dummy)
compiled with the kernel itself can be inserted and removed without the previous error message.
Is there something i should know about the compilation process ? The kernel-compiled module (dummy.ko) has
about 10 Kbytes and dummy.ko compiled by me has only 2 Kbytes :(

Thank you in advance
Snowdog
