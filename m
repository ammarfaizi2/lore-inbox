Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262412AbSJLIzD>; Sat, 12 Oct 2002 04:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262413AbSJLIzD>; Sat, 12 Oct 2002 04:55:03 -0400
Received: from stroke.of.genius.brain.org ([206.80.113.1]:20965 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id <S262412AbSJLIzC>; Sat, 12 Oct 2002 04:55:02 -0400
Date: Sat, 12 Oct 2002 05:00:40 -0400
From: "Murray J. Root" <murrayr@brain.org>
To: linux-kernel@vger.kernel.org
Subject: 2.5.42 ieee1394 won't build
Message-ID: <20021012090040.GA11816@Master.Wizards>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make -f drivers/ieee1394/Makefile 
  gcc -Wp,-MD,drivers/ieee1394/.ieee1394_core.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -                   
Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boun                   
dary=2 -march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include -DMODULE -include include                   
/linux/modversions.h   -DKBUILD_BASENAME=ieee1394_core -DEXPORT_SYMTAB  -c -o drivers/ieee1394/ieee1                   
394_core.o drivers/ieee1394/ieee1394_core.c
drivers/ieee1394/ieee1394_core.c:22:26: linux/tqueue.h: No such file or directory
In file included from drivers/ieee1394/ieee1394_core.c:29:
drivers/ieee1394/hosts.h:5:26: linux/tqueue.h: No such file or directory
In file included from drivers/ieee1394/ieee1394_core.c:29:
drivers/ieee1394/hosts.h:26: field `timeout_tq' has incomplete type
In file included from drivers/ieee1394/ieee1394_core.c:30:
drivers/ieee1394/ieee1394_core.h:5:26: linux/tqueue.h: No such file or directory
drivers/ieee1394/ieee1394_core.c: In function `process_complete_tasks':
drivers/ieee1394/ieee1394_core.c:75: dereferencing pointer to incomplete type
drivers/ieee1394/ieee1394_core.c:75: warning: type defaults to `int' in declaration of `__mptr'
drivers/ieee1394/ieee1394_core.c:75: warning: initialization from incompatible pointer type
drivers/ieee1394/ieee1394_core.c:75: dereferencing pointer to incomplete type
drivers/ieee1394/ieee1394_core.c:76: dereferencing pointer to incomplete type
drivers/ieee1394/ieee1394_core.c:77: warning: implicit declaration of function `schedule_task'
drivers/ieee1394/ieee1394_core.c: In function `hpsb_add_packet_complete_task_Ra6229666':
drivers/ieee1394/ieee1394_core.c:90: dereferencing pointer to incomplete type
make[2]: *** [drivers/ieee1394/ieee1394_core.o] Error 1

-- 
Murray J. Root
------------------------------------------------
DISCLAIMER: http://www.goldmark.org/jeff/stupid-disclaimers/
------------------------------------------------
Mandrake on irc.freenode.net:
  #mandrake & #mandrake-linux = help for newbies 
  #mdk-cooker = Mandrake Cooker 

