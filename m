Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265229AbRF0JlW>; Wed, 27 Jun 2001 05:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265310AbRF0JlM>; Wed, 27 Jun 2001 05:41:12 -0400
Received: from ip-33-237-104-152.anlai.com ([152.104.237.33]:52495 "EHLO
	exchsh01.viatech.com.cn") by vger.kernel.org with ESMTP
	id <S265229AbRF0JlA>; Wed, 27 Jun 2001 05:41:00 -0400
Message-ID: <61F2703C314FD5118C0300010250D52E0580BC@exchsh01.viatech.com.cn>
From: "Frank Zhu (Shanghai)" <FrankZhu@viatech.com.cn>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "'neilb@cse.unsw.edu.au'" <neilb@cse.unsw.edu.au>,
        "'nfs-devel@linux.kernel.org'" <nfs-devel@linux.kernel.org>,
        "'nfs@lists.sourceforge.net'" <nfs@lists.sourceforge.net>
Subject: PROBLEM:Illegal instruction when mount nfs file systems using cyr
	ixIII
Date: Wed, 27 Jun 2001 17:42:01 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="gb2312"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi:
I use a PIII machine as the server and cyrixIII machine as the client.The
kernel is 2.4.5.The distribute is red hat 7.1
when i mount the nfs file system at the client it failed.The core file is
created.using the gdb it report  :
Program terminated with signal 4(SIGILL),Illegal instruction
#0  0x40003e28 in ??()

If i change the cpu (CyrixIII) to PIII all is ok.

help

frank

