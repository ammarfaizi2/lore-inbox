Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292348AbSCAVsu>; Fri, 1 Mar 2002 16:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292362AbSCAVsl>; Fri, 1 Mar 2002 16:48:41 -0500
Received: from voyager.st-peter.stw.uni-erlangen.de ([131.188.24.132]:7861
	"EHLO voyager.st-peter.stw.uni-erlangen.de") by vger.kernel.org
	with ESMTP id <S292348AbSCAVsY>; Fri, 1 Mar 2002 16:48:24 -0500
Message-ID: <3C7FF756.806@st-peter.stw.uni-erlangen.de>
Date: Fri, 01 Mar 2002 22:49:10 +0100
From: svetljo <galia@st-peter.stw.uni-erlangen.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: troubles with isofs linux-2.5.5-xfs-dj2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan *16gusz-0007v6-00*2b0wgaXtyZQ* (Studentenwohnanlage Nuernberg St.-Peter)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
i'm having strange troubles with isofs in linux-2.5.5-xfs-dj2
compiled in i got ' iso9660 filesystem not suported by kernel '
compiled es module ( with or without zisofs)
[root@svetljo linux-2.5.5-xfs-dj2-2]#modprobe isofs
/lib/modules/2.5.6-pre1-xfs-dj2/kernel/fs/isofs/isofs.o: couldn't find 
the kernel version the module was compiled for
modprobe: insmod /lib/modules/2.5.6-pre1-xfs-dj2/kernel/fs/isofs/isofs.o 
failed
modprobe: insmod isofs failed
[root@svetljo linux-2.5.5-xfs-dj2-2]# insmod --force isofs
Using /lib/modules/2.5.6-pre1-xfs-dj2/kernel/fs/isofs/isofs.o
/lib/modules/2.5.6-pre1-xfs-dj2/kernel/fs/isofs/isofs.o: couldn't find 
the kernel version the module was compiled for
[root@svetljo fs]# uname -a
Linux svetljo.st-peter.stw.uni-erlangen.de 2.5.6-pre1-xfs-dj2 #13 SMP 
Fri Mar 1 22:09:13 CET 2002 i686 unknown

i don't get it, what's wrong

