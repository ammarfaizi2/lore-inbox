Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261461AbSJHQez>; Tue, 8 Oct 2002 12:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261463AbSJHQez>; Tue, 8 Oct 2002 12:34:55 -0400
Received: from pop.gmx.net ([213.165.64.20]:58995 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S261461AbSJHQew>;
	Tue, 8 Oct 2002 12:34:52 -0400
Date: Tue, 8 Oct 2002 18:40:24 +0200
From: Marc Giger <gigerstyle@gmx.ch>
To: linux-kernel@vger.kernel.org
Subject: dead processes
Message-Id: <20021008184024.27c95217.gigerstyle@gmx.ch>
X-Mailer: Sylpheed version 0.8.3claws (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there

I have a problem:

  PID TTY      STAT   TIME COMMAND
    1 ?        S      0:07 init [3]       
    2 ?        SW     0:00 [keventd]
    3 ?        SWN    0:00 [ksoftirqd_CPU0]
    4 ?        SWN    0:00 [ksoftirqd_CPU1]
    5 ?        SW     0:17 [kswapd]
    6 ?        SW     0:00 [bdflush]
    7 ?        SW     0:16 [kupdated]
    8 ?        SW     0:00 [scsi_eh_0]
    9 ?        SW<    0:00 [mdrecoveryd]
   10 ?        SW     0:00 [kreiserfsd]
   27 ?        S      0:00 /sbin/devfsd /dev
 2307 ?        SW     0:00 [khubd]
 4942 ?        S      0:10 /usr/sbin/cupsd
 5177 ?        S      0:00 /sbin/portmap
 5223 ?        S      0:00 /sbin/rpc.statd
 5385 ?        S      0:00 /sbin/rpc.rquotad
 5388 ?        SW     0:15 [nfsd]
 5389 ?        SW     0:14 [nfsd]
 5390 ?        SW     0:15 [nfsd]
 5391 ?        SW     0:14 [nfsd]
 5392 ?        SW     0:15 [nfsd]
 5393 ?        SW     0:14 [nfsd]
 5394 ?        SW     0:16 [nfsd]
 5395 ?        SW     0:16 [nfsd]
 5396 ?        SW     0:00 [lockd]
 5397 ?        SW     0:00 [rpciod]
 5400 ?        S      0:00 /sbin/rpc.mountd
 5459 ?        S      0:07 /usr/sbin/syslogd -m 0
 5462 ?        S      0:00 /usr/sbin/klogd -c 3 -2
 5506 ?        S      0:04 /usr/lib/postfix/master
 5543 ?        S      0:00 /usr/sbin/sshd
 5574 ?        S      0:00 /usr/sbin/cron
 5580 vc/1     S      0:00 login -- hdg     
 5581 vc/2     S      0:00 /sbin/agetty 38400 tty2 linux
 5582 vc/3     S      0:00 /sbin/agetty 38400 tty3 linux
 5583 vc/4     S      0:00 /sbin/agetty 38400 tty4 linux
 5584 vc/5     S      0:00 /sbin/agetty 38400 tty5 linux
 5585 vc/6     S      0:00 /sbin/agetty 38400 tty6 linux
 5586 vc/1     S      0:00 -bash
 5600 vc/1     S      0:00 /bin/sh /usr/X11R6/bin/startx
 5607 vc/1     S      0:00 xinit /home/hdg/.xinitrc --
 5608 ?        S     44:09 X :0
 5614 vc/1     S      0:00 /bin/sh --login /usr/kde/3/bin/startkde
 5642 ?        S      0:00 kdeinit: Running...      
 5645 ?        S      0:01 kdeinit: dcopserver --nosid
 5648 ?        S      0:00 kdeinit: klauncher       
 5650 ?        S      9:38 kdeinit: kded            
 5665 ?        S      0:02 kdeinit: knotify         
 5666 vc/1     S      0:06 kwrapper ksmserver --restore
 5668 ?        S      0:00 kdeinit: ksmserver --restore
 5669 ?        S      1:02 kdeinit: kwin -session 11c0a8000100010334687380000005
 5670 ?        S     52:02 xosview
 5673 ?        S      5:59 kdeinit: kdesktop        
 5676 ?        S      4:33 kdeinit: kicker          
 5683 ?        S      4:44 kdeinit: klipper -icon klipper -miniicon klipper
 5684 ?        S      0:19 kdeinit: konsole -session 11c0a8000100010334940870000
 5685 ?        S      5:05 kdeinit: konsole -session 11c0a8000100010334692170000
 5688 ?        S      5:40 kdeinit: kmix -session 11c0a8000100010334695240000005
 5691 ?        S      0:00 licq -p kde-gui -- -session 11c0a80001000103389425000
 5699 ?        S      0:00 kalarmd --login
 5703 pts/0    S      0:00 /bin/bash
 5712 pts/1    S      0:00 /bin/bash
 5713 ?        S      0:02 licq -p kde-gui -- -session 11c0a80001000103389425000
 5715 ?        S      0:00 licq -p kde-gui -- -session 11c0a80001000103389425000
 5721 ?        S      0:00 licq -p kde-gui -- -session 11c0a80001000103389425000
 5724 ?        S      0:07 licq -p kde-gui -- -session 11c0a80001000103389425000
 5764 pts/0    S      0:00 bash
 5775 ?        S      4:36 ksensors -caption KSensors -icon ksensors.png -miniic
24081 ?        S      1:06 gamix
10762 ?        S      2:00 kdeinit: konsole -icon konsole -miniicon konsole
10764 pts/2    S      0:00 /bin/bash
10776 pts/2    S      0:00 bash
23099 ?        S     11:55 xmms
23111 ?        S      0:01 xmms
23112 ?        S      0:14 xmms
23134 ?        S      0:18 xmms
26213 ?        S      0:00 /usr/kde/3/bin/kdesud
29703 ?        S      0:54 /usr/bin/sylpheed-claws
29761 ?        Z      0:00 [gpg <defunct>]
29762 ?        Z      0:00 [gpg <defunct>]
29763 ?        Z      0:00 [gpg <defunct>]
29765 ?        Z      0:00 [gpg <defunct>]
29766 ?        Z      0:00 [gpg <defunct>]
29767 ?        Z      0:00 [gpg <defunct>]
29773 ?        Z      0:00 [gpg <defunct>]
29774 ?        Z      0:00 [gpg <defunct>]
29775 ?        Z      0:00 [gpg <defunct>]
29790 ?        Z      0:00 [gpg <defunct>]
29791 ?        Z      0:00 [gpg <defunct>]
29792 ?        Z      0:00 [gpg <defunct>]
29834 ?        S      2:51 /usr/lib/mozilla/mozilla-bin
29841 ?        S      0:00 /usr/lib/mozilla/mozilla-bin
29842 ?        S      0:01 /usr/lib/mozilla/mozilla-bin
29843 ?        S      0:00 /usr/lib/mozilla/mozilla-bin
29845 ?        S      0:05 /usr/lib/mozilla/mozilla-bin
 4260 ?        Z      0:00 [gpg <defunct>]
 4261 ?        Z      0:00 [gpg <defunct>]
 4262 ?        Z      0:00 [gpg <defunct>]
 4336 ?        Z      0:00 [gpg <defunct>]
 4337 ?        Z      0:00 [gpg <defunct>]
 4338 ?        Z      0:00 [gpg <defunct>]
 4353 ?        Z      0:00 [gpg <defunct>]
 4354 ?        Z      0:00 [gpg <defunct>]
 4355 ?        Z      0:00 [gpg <defunct>]
 4422 ?        Z      0:00 [gpg <defunct>]
 4423 ?        Z      0:00 [gpg <defunct>]
 4424 ?        Z      0:00 [gpg <defunct>]
 4439 ?        Z      0:00 [gpg <defunct>]
 4440 ?        Z      0:00 [gpg <defunct>]
 4441 ?        Z      0:00 [gpg <defunct>]
 4475 ?        Z      0:00 [gpg <defunct>]
 4476 ?        Z      0:00 [gpg <defunct>]
 4477 ?        Z      0:00 [gpg <defunct>]
 4610 ?        Z      0:00 [gpg <defunct>]
 4611 ?        Z      0:00 [gpg <defunct>]
 4612 ?        Z      0:00 [gpg <defunct>]
 4613 ?        Z      0:00 [gpg <defunct>]
 4614 ?        Z      0:00 [gpg <defunct>]
 4615 ?        Z      0:00 [gpg <defunct>]
 4632 ?        Z      0:00 [gpg <defunct>]
 4635 ?        Z      0:00 [gpg <defunct>]
 4636 ?        Z      0:00 [gpg <defunct>]
 4643 ?        Z      0:00 [gpg <defunct>]
 4644 ?        Z      0:00 [gpg <defunct>]
 4650 ?        Z      0:00 [gpg <defunct>]
 4659 ?        Z      0:00 [gpg <defunct>]
 4660 ?        Z      0:00 [gpg <defunct>]
 4666 ?        Z      0:00 [gpg <defunct>]
 4670 ?        Z      0:00 [gpg <defunct>]
 4675 ?        Z      0:00 [gpg <defunct>]
 4680 ?        Z      0:00 [gpg <defunct>]
 5201 ?        Z      0:00 [gpg <defunct>]
 5202 ?        Z      0:00 [gpg <defunct>]
 5203 ?        Z      0:00 [gpg <defunct>]
 5886 ?        Z      0:00 [gpg <defunct>]
 5887 ?        Z      0:00 [gpg <defunct>]
 5888 ?        Z      0:00 [gpg <defunct>]
15854 ?        S      0:01 java_vm 
15855 ?        S      0:05 java_vm 
15856 ?        S      0:09 java_vm 
15857 ?        S      0:00 java_vm 
15858 ?        S      0:00 java_vm 
15859 ?        S      0:56 java_vm 
15860 ?        S      0:00 java_vm 
15861 ?        S      0:00 java_vm 
15862 ?        S      0:01 java_vm 
15863 ?        S      0:00 java_vm 
15865 ?        S      0:15 java_vm 
15867 ?        S      0:00 java_vm 
15868 ?        S      0:00 java_vm 
15869 ?        S      0:00 /usr/lib/mozilla/mozilla-bin
15870 ?        S      0:00 /usr/lib/mozilla/mozilla-bin
15871 ?        S      0:00 java_vm 
15872 ?        S      0:30 java_vm 
15879 ?        S      0:02 java_vm 
 3775 ?        S      0:00 /usr/lib/mozilla/mozilla-bin
15021 ?        Z      0:00 [gpg <defunct>]
15022 ?        Z      0:00 [gpg <defunct>]
15023 ?        Z      0:00 [gpg <defunct>]
18715 ?        S      0:00 qmgr -l -t fifo -u
23545 ?        S      0:00 pickup -l -t fifo -u
25355 ?        Z      0:00 [gpg <defunct>]
25356 ?        Z      0:00 [gpg <defunct>]
25357 ?        Z      0:00 [gpg <defunct>]
27387 ?        S      0:05 xmms
27388 ?        S      0:00 xmms
27392 ?        S      0:01 xmms
27686 ?        S      0:00 java_vm 
27687 pts/0    R      0:00 ps -ax

There are a lot of defunct processes which I can't kill.
How comes? Normal? Solution?

Kind regards

Marc Giger
