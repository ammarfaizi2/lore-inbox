Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135605AbRDSJKi>; Thu, 19 Apr 2001 05:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135604AbRDSJKa>; Thu, 19 Apr 2001 05:10:30 -0400
Received: from [159.226.41.188] ([159.226.41.188]:24844 "EHLO
	gatekeeper.ncic.ac.cn") by vger.kernel.org with ESMTP
	id <S135600AbRDSJJx>; Thu, 19 Apr 2001 05:09:53 -0400
Date: Thu, 19 Apr 2001 17:10:33 +0800
From: "Xiong Zhao" <xz@gatekeeper.ncic.ac.cn>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: question about the system limits
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Message-ID: <774579F31719.AAA51E8@gatekeeper.ncic.ac.cn>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,all.now i'm completely confused with the meaning of 
some system limits on kernel 2.4.3.there are three main 
limits that i concern:NR_OPEN,NR_FILE,and OPEN_MAX.i didn't
find NR_INODE anywhere.is that due to the change of the 
allocation mechanism of inodes?in limits.h of the source file
of kernel 2.4.3,NR_OPEN and OPEN_MAX are 1024 and 256 respectively.
but in fs.h,NR_OPEN is defined to be 1024*1024,and NR_FILE is
8192.what's the meaning of these limits?which will work on the 
whole system?which work towards a single user or process?
besides,what's the relationship between these limits and file
file-max,threads-max under directory /proc?it is refered in many
papers that performance can be improved by resetting these values.
but what's their meaning and how they make effect?can anyone
give me a clear explaination?

regards

james

