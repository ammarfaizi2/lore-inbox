Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261973AbSL2WIP>; Sun, 29 Dec 2002 17:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261978AbSL2WIP>; Sun, 29 Dec 2002 17:08:15 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:52633 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S261973AbSL2WIO>; Sun, 29 Dec 2002 17:08:14 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Date: Mon, 30 Dec 2002 09:16:21 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15887.29749.799810.949032@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RAID0 problems with 2.4.21-BK current
In-Reply-To: message from Marc-Christian Petersen on Sunday December 29
References: <200212292012.11556.m.c.p@wolk-project.de>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday December 29, m.c.p@wolk-project.de wrote:
> Hi Neil,
> 
> this:
> 
> http://linux.bkbits.net:8080/linux-2.4/patch@1.884.1.69?nav=index.html|ChangeSet@-2w|cset@1.884.1.69
> 
> patch breaks at least RAID 0 recognition at boottime (infinite loop) and also 
> breaks mkraid /dev/md0. Never stops, State D.

Odd. It works for me.  
Can you find out more about the 'D' state the it is stuck in?
alt-sysrq-T
should provide a stack trace which should get caught in some log
file. 

 ps axgl
could list something vaguely useful in the 'wchan' column.

NeilBrown
