Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132936AbRD1Lgi>; Sat, 28 Apr 2001 07:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132940AbRD1Lg3>; Sat, 28 Apr 2001 07:36:29 -0400
Received: from [159.226.41.188] ([159.226.41.188]:9998 "EHLO
	gatekeeper.ncic.ac.cn") by vger.kernel.org with ESMTP
	id <S132936AbRD1LgQ>; Sat, 28 Apr 2001 07:36:16 -0400
Date: Sat, 28 Apr 2001 19:36:47 +0800
From: "Xiong Zhao" <xz@gatekeeper.ncic.ac.cn>
To: majordomo linux kernel list <linux-kernel@vger.kernel.org>
Subject: question about kernel limits
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Message-ID: <77457D7A904.AAA3C96@gatekeeper.ncic.ac.cn>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello. because i'm going to run lotus domino with large number of
concurrent users on linux, the kernel limits(of open file,processes,
inodes for the whole system,a single user and a process)is a key factor
to the performance. currently,the number of users cannot exceed 500 on 2.4.3.
i change the value of /proc/sys/fs/file-max and open files in ulimit
but it doesn't work. besides, what are the meaning of NR_OPEN,NR_FILE,
file-max,and OPEN_MAX. which do they effect on respectively, system, a
user, or a process. in limits.h,NR_OPEN is set to 1024,but in fs.h it is 
defined as 1024*1024. what do they mean? in addition, i cannot find 
inode-max under /proc/sys/fs, is it due to the change of the mechanism 
of its allocation. what's the change? and last question, what are the 
actual values of these limits, is there any way to increase the supported
number of users? it will be very kind of you if you can introduce me 
some materials on linux kernel, especially on process management(pthread,
fork,clone and so on).
regards 

james

