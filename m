Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281319AbRKQU7L>; Sat, 17 Nov 2001 15:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281321AbRKQU7A>; Sat, 17 Nov 2001 15:59:00 -0500
Received: from mail126.mail.bellsouth.net ([205.152.58.86]:14004 "EHLO
	imf26bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S281319AbRKQU6n>; Sat, 17 Nov 2001 15:58:43 -0500
Message-ID: <3BF6CE2B.857A2AEB@bellsouth.net>
Date: Sat, 17 Nov 2001 15:52:59 -0500
From: Steve Martin <ecprod@bellsouth.net>
Organization: WATE-TV, Knoxville, TN
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.4.14 loop.o missing symbol
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI: in kernel 2.4.14, symbol "deactivate_page()"
is not exported from kernel/ksyms.c, causing
unresolved reference in drivers/block/loop.c

