Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316088AbSFJUQv>; Mon, 10 Jun 2002 16:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316080AbSFJUQs>; Mon, 10 Jun 2002 16:16:48 -0400
Received: from p508FFB43.dip.t-dialin.net ([80.143.251.67]:61577 "EHLO
	debian01.kingruedi.net") by vger.kernel.org with ESMTP
	id <S316088AbSFJUQQ>; Mon, 10 Jun 2002 16:16:16 -0400
Message-Id: <200206102015.g5AKFk1l001840@debian01.kingruedi.net>
Content-Type: text/plain; charset=US-ASCII
From: =?iso-8859-1?q?R=FCdiger=20Sonderfeld?= <cplusplushelp@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: removing old SYN packets
Date: Mon, 10 Jun 2002 22:15:46 +0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I need some information about the TCP implementation. I didn't find any 
information in my Linux Kernel book or in any other tutorial about TCP and I 
do not really understand the tcp.c

The kernel should remove SYN packets if it doesn't recive the final ACK. But 
where is that implemented in the Linux Kernel?


example

host                       server
      -----SYN----->    remember SYN
      <----ACK------ 
 host shuts down
                               timeout for the threewayhandshake
                                 removing waiting status
