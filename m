Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263895AbSITWuE>; Fri, 20 Sep 2002 18:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263910AbSITWuE>; Fri, 20 Sep 2002 18:50:04 -0400
Received: from web13201.mail.yahoo.com ([216.136.174.186]:29313 "HELO
	web13201.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S263895AbSITWuD>; Fri, 20 Sep 2002 18:50:03 -0400
Message-ID: <20020920225506.13191.qmail@web13201.mail.yahoo.com>
Date: Fri, 20 Sep 2002 15:55:06 -0700 (PDT)
From: Srinivas Chavva <chavvasrini@yahoo.com>
Subject: Loading kernel
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I installed RedHat Linux 7.3 on my system. When I
entered as the root and typed "uname -r' I got the
kernel version as 2.4.18.
When I executed the command "rpm -q kernel-headers
kernel-source" I got a message 
"package:kernel-headers not installed
package: kernel-source not installed".
So I downloaded the kernel, unpacked it, configured
the kernel, compiled it with no no problems. I stored
the bzImage into the /boot directory as linux-2.4.18
and edited the lilo.conf file by adding this as the
image. Then I compiled the lilo.conf file. I got no
errors.
When I rebooted the system and selected the kernel
linux-2.4.18 I got the following errors and my system
got hanged.
The errors are as follows
"
/etc/rc.sysinit: /var/log/dmesg: No such file or
directory
/etc/rc.sysinit: /var/log/ksyms.o: No such file or
directory
INIT: Entering run level:3
Updating /etc/fstab execvp: No such file or directory
					[FAILED]
Checking for new hardware
/etc/rc3.d/S05Kudzu:/usr/sbin/kudzu: No such file or
directory
					[FAILED]
touch:creating '/var/lock/subsys/kudzu': No such file
or directory
"
After this my system got hanged. I was able to log in
to the original linux kernel but this kernel
linux-2.4.18 is not working.
I wanted to know what the error was due to and how to
use the kernel linux-2.4.18 bec when I configured and
compiled the kernel there were no errors.
Thanking You.
Regards,
Srinivas Chavva

__________________________________________________
Do you Yahoo!?
New DSL Internet Access from SBC & Yahoo!
http://sbc.yahoo.com
