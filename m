Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278755AbRKRUyp>; Sun, 18 Nov 2001 15:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280043AbRKRUyd>; Sun, 18 Nov 2001 15:54:33 -0500
Received: from c0mailgw.prontomail.com ([216.163.180.10]:33271 "EHLO
	c0mailgw11.prontomail.com") by vger.kernel.org with ESMTP
	id <S278755AbRKRUyO>; Sun, 18 Nov 2001 15:54:14 -0500
Message-ID: <3BF81FD1.F7698EA9@starband.net>
Date: Sun, 18 Nov 2001 15:53:37 -0500
From: war <war@starband.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: I turned swap off and wow!
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the list.


USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.0  1384  508 ?        S    09:31   0:06 init [5]
root         2  0.0  0.0     0    0 ?        SW   09:31   0:00 [keventd]

root         3  0.0  0.0     0    0 ?        SW   09:31   0:00
[kapm-idled]
root         4  0.0  0.0     0    0 ?        SWN  09:31   0:00
[ksoftirqd_CPU0]
root         5  0.1  0.0     0    0 ?        RW   09:31   0:18 [kswapd]
root         6  0.0  0.0     0    0 ?        SW   09:31   0:00 [bdflush]

root         7  0.0  0.0     0    0 ?        SW   09:31   0:01
[kupdated]
root         8  0.0  0.0     0    0 ?        SW   09:31   0:00
[scsi_eh_0]
root         9  0.0  0.0     0    0 ?        SW   09:31   0:00 [khubd]
root       473  0.0  0.0  1444  596 ?        S    09:32   0:00 syslogd
-m 0
root       478  0.0  0.1  1952 1096 ?        S    09:32   0:00 klogd -2
root       591  0.0  0.0  1368  508 ?        S    09:32   0:00
/usr/sbin/apmd -p 10 -w 5 -W -P /etc/sysconfig/apm-scripts/apmscript
root       624  0.0  0.0  2248  844 ?        S    09:32   0:00 xinetd
-stayalive -reuse -pidfile /var/run/xinetd.pid
root       642  0.0  0.0  1412  456 ?        S    09:32   0:00 gpm -t
imps2 -m /dev/mouse
root       660  0.0  0.0  1568  668 ?        S    09:32   0:00 crond
xfs        728  0.0  0.5 10356 5152 ?        S    09:32   0:06 xfs
-droppriv -daemon
daemon     764  0.0  0.0  1416  572 ?        S    09:32   0:00
/usr/sbin/atd
root       781  0.0  0.0  1356  432 tty1     S    09:32   0:00
/sbin/mingetty tty1
root       782  0.0  0.0  1356  432 tty2     S    09:32   0:00
/sbin/mingetty tty2
root       783  0.0  0.0  1356  432 tty3     S    09:32   0:00
/sbin/mingetty tty3
root       784  0.0  0.0  1356  432 tty4     S    09:32   0:00
/sbin/mingetty tty4
root       785  0.0  0.0  1356  432 tty5     S    09:32   0:00
/sbin/mingetty tty5
root       786  0.0  0.0  1356  432 tty6     S    09:32   0:00
/sbin/mingetty tty6
root       787  0.0  0.1  6176 1240 ?        S    09:32   0:00
/usr/bin/gdm -nodaemon
root       797  0.0  0.0  2368  732 ?        S    09:32   0:00
/app/apache-1.3.22/bin/httpd
nobody     798  0.0  0.0  2512  812 ?        S    09:32   0:00
/app/apache-1.3.22/bin/httpd
root       799  0.0  0.1  6728 1596 ?        S    09:32   0:00
/usr/bin/gdm -nodaemon
root       800  3.3  6.8 152472 70112 ?      S    09:32  10:08
/etc/X11/X :0 -auth /var/gdm/:0.Xauth
war        807  0.0  0.3  7704 3580 ?        S    09:32   0:01
/usr/bin/gnome-session
war        890  0.0  0.2  6736 2632 ?        S    09:32   0:16
gnome-smproxy --sm-config-prefix /.gnome-smproxy-Irpxfd/ --sm-client-id
11c0a8a80c000100362409800000113970000
war        902  0.4  0.9 12052 9832 ?        S    09:32   1:25 sawfish
--sm-client-id 11c0a8a80c000100576373900000208040033 --sm-prefix
9wihhev86g
war        918  0.1  0.6  9652 6340 ?        S    09:32   0:34 panel
--sm-config-prefix /panel.d/default-rn9WW3/ --sm-client-id
11c0a8a80c000100362409900000113970008
war        920  0.0  1.2 23348 12896 ?       S    09:32   0:14 nautilus
--sm-config-prefix /nautilus-L42LK3/ --sm-client-id
11c0a8a80c000100362409900000113970009 --no-default-window
war        924  0.0  0.1  3180 1256 ?        S    09:32   0:00
gnome-name-service
war        930  0.0  0.4  8096 4216 ?        S    09:32   0:00
gnomecc-single-shell --sm-config-prefix /gnomecc-single-shell-w9C3I3/
--sm-client-id 11c0a8a80c000100576229400000208040000
war        933  0.0  0.2  3992 2368 ?        S    09:32   0:01 oafd
--ac-activate --ior-output-fd=10
war        938  0.0  0.1  3308 1696 ?        S    09:32   0:00 gconfd-1
--oaf-activate-iid=OAFIID:gconfd:19991118 --oaf-ior-fd=10
war        943  0.1  0.4  8428 4852 ?        S    09:32   0:31
tasklist_applet --activate-goad-server tasklist_applet --goad-fd 10
war        946  0.1  0.4  7920 4312 ?        S    09:32   0:36
deskguide_applet --activate-goad-server deskguide_applet --goad-fd 10
war        948  0.0  0.3  7408 3560 ?        S    09:32   0:00
diskusage_applet --activate-goad-server diskusage_applet --goad-fd 10
war        952  0.0  1.2 23348 12896 ?       S    09:32   0:00 nautilus
--sm-config-prefix /nautilus-L42LK3/ --sm-client-id
11c0a8a80c000100362409900000113970009 --no-default-window
war        953  0.0  1.2 23348 12896 ?       S    09:32   0:00 nautilus
--sm-config-prefix /nautilus-L42LK3/ --sm-client-id
11c0a8a80c000100362409900000113970009 --no-default-window
war        954  0.0  1.2 23348 12896 ?       S    09:32   0:00 nautilus
--sm-config-prefix /nautilus-L42LK3/ --sm-client-id
11c0a8a80c000100362409900000113970009 --no-default-window
war        955  0.0  1.2 23348 12896 ?       S    09:32   0:00 nautilus
--sm-config-prefix /nautilus-L42LK3/ --sm-client-id
11c0a8a80c000100362409900000113970009 --no-default-window
war        959  0.0  0.2  7332 2464 ?        S    09:33   0:00 xterm
-geom 161x24+0+0 -cc 33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg
black -fg white -sl 4096 +sb -e /app/mystuff/bin/log1
war        960  0.0  0.2  7332 2464 ?        S    09:33   0:00 xterm
-geom 161x24+0+348 -cc 33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg
black -fg white -sl 4096 +sb -e /app/mystuff/bin/log2
war        962  0.0  0.2  6024 2468 ?        S    09:33   0:00 xterm
-geom 80x24+496+696 -cc 33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg
black -fg white -sl 4096 +sb -e /app/mystuff/bin/log6
war        963  0.0  0.2  6024 2460 ?        S    09:33   0:00 xterm
-geom 80x24+992+696 -cc 33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg
black -fg white -sl 4096 +sb -e /app/mystuff/bin/log7
war        964  0.0  0.2  6052 2512 ?        S    09:33   0:00 xterm
-geom 80x24+982+0 -cc 33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg
black -fg white -sl 4096 +sb -e /app/mystuff/bin/log5
war        965  0.0  0.2  6024 2448 ?        S    09:33   0:00 xterm
-geom 80x24+982+348 -cc 33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg
black -fg white -sl 4096 +sb -e /app/mystuff/bin/log5
war        973  0.0  0.1  2504 1316 pts/4    S    09:33   0:00
/usr/bin/expect -- /app/mystuff/bin/log2
war        975  0.0  0.1  2504 1316 pts/0    S    09:33   0:00
/usr/bin/expect -- /app/mystuff/bin/log1
war        976  0.0  0.1  2504 1316 pts/1    S    09:33   0:00
/usr/bin/expect -- /app/mystuff/bin/log6
war        977  0.0  0.1  2504 1316 pts/6    S    09:33   0:00
/usr/bin/expect -- /app/mystuff/bin/log5
war        978  0.0  0.1  2504 1316 pts/5    S    09:33   0:00
/usr/bin/expect -- /app/mystuff/bin/log7
war        979  0.0  0.1  2504 1316 pts/3    S    09:33   0:00
/usr/bin/expect -- /app/mystuff/bin/log5
war        980  0.0  0.1  2928 1624 pts/7    S    09:33   0:00
/vapp/bin/ssh -l war 192.168.168.254
war        981  0.0  0.1  2928 1624 pts/8    S    09:33   0:00
/vapp/bin/ssh -l war 192.168.168.254
war        982  0.0  0.1  2928 1624 pts/9    S    09:33   0:00
/vapp/bin/ssh -l war 192.168.168.254
war        983  0.0  0.1  2928 1624 pts/10   S    09:33   0:00
/vapp/bin/ssh -l war 192.168.168.254
war        984  0.0  0.0  1812  812 pts/11   S    09:33   0:00 telnet
war        985  0.0  0.0  1812  812 pts/12   S    09:33   0:00 telnet
war       1012  0.0  0.2  6036 2724 ?        S    09:33   0:00 xterm
-geom 80x24+0+0 -cc 33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black
-fg white -sl 4096 +sb
war       1013  0.0  0.2  6048 3064 ?        S    09:33   0:00 xterm
-geom 80x24+496+0 -cc 33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg
black -fg white -sl 4096 +sb
war       1014  0.0  0.2  6048 2564 ?        S    09:33   0:01 xterm
-geom 80x24+992+0 -cc 33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg
black -fg white -sl 4096 +sb
war       1015  0.0  0.2  6048 2812 ?        S    09:33   0:00 xterm
-geom 80x24+0+348 -cc 33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg
black -fg white -sl 4096 +sb
war       1016  0.0  0.2  6048 2752 ?        S    09:33   0:01 xterm
-geom 80x24+496+348 -cc 33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg
black -fg white -sl 4096 +sb
war       1017  0.0  0.2  6048 2752 ?        S    09:33   0:01 xterm
-geom 80x24+992+348+0 -cc 33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg
black -fg white -sl 4096 +sb
war       1021  0.0  0.2  3864 2700 pts/16   S    09:33   0:00 bash
war       1024  0.0  0.2  3852 2688 pts/14   S    09:33   0:00 bash
war       1027  0.0  0.2  3864 2700 pts/15   S    09:33   0:00 bash
war       1035  0.0  0.2  6048 2436 ?        S    09:33   0:00 xterm
-geom 80x24+0+696 -cc 33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg
black -fg white -sl 4096 +sb
war       1036  0.0  0.2  6036 2360 ?        S    09:33   0:00 xterm
-geom 80x24+496+696 -cc 33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg
black -fg white -sl 4096 +sb
war       1037  0.0  0.2  6048 2572 ?        S    09:33   0:00 xterm
-geom 80x24+992+696 -cc 33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg
black -fg white -sl 4096 +sb
war       1078  0.0  0.2  3864 2700 pts/17   S    09:33   0:00 bash
war       1081  0.0  0.2  3852 2688 pts/18   S    09:33   0:00 bash
war       1098  0.0  0.2  3904 2752 pts/19   S    09:33   0:00 bash
war       1166  0.0  0.2  3864 2692 pts/20   S    09:33   0:00 bash
war       1174  0.0  0.2  3852 2656 pts/21   S    09:33   0:00 bash
war       1177  0.0  0.2  3852 2688 pts/22   S    09:33   0:00 bash
war       1284  0.0  0.0  2196  972 ?        S    09:33   0:00 /bin/sh
/vapp/bin/xchat-dalnet
war       1285  0.0  0.6 10472 6220 ?        S    09:33   0:04
/vapp/bin/xchat -d /home/war/.xchat-dalnet
war       1290  0.0  0.0  2196  972 ?        S    09:33   0:00 /bin/sh
/vapp/bin/xchat-openprojects
war       1291  0.0  0.6 10980 6724 ?        S    09:33   0:07
/vapp/bin/xchat -d /home/war/.xchat-openprojects
war       1295  0.0  0.0  2196  972 ?        S    09:33   0:00 /bin/sh
/vapp/bin/xchat-efnet
war       1296  0.3  0.9 13748 9340 ?        S    09:33   1:09
/vapp/bin/xchat -d /home/war/.xchat
war       1303  0.0  0.3  9260 4088 ?        S    09:33   0:03
/vapp/bin/gaim
war       1304  0.0  0.3 10592 3740 ?        S    09:33   0:15 aspell -a

war       1373  0.0  0.2  6036 2488 ?        S    09:33   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war       1375  0.0  0.2  3852 2688 pts/25   S    09:33   0:00 bash
war       1405  0.0  0.2  6048 2224 ?        S    09:33   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war       1407  0.0  0.2  3860 2676 pts/26   S    09:33   0:00 bash
war       1439  0.0  0.2  6036 2076 ?        S    09:33   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war       1443  0.0  0.2  3852 2648 pts/27   S    09:33   0:00 bash
war       1473  0.0  0.2  6036 2448 ?        S    09:33   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war       1475  0.0  0.2  3852 2680 pts/28   S    09:33   0:00 bash
war       1511  0.0  0.1  2512 1324 pts/22   S    09:34   0:00
/usr/bin/expect -- /vapp/bin/leon
war       1512  0.0  0.1  3024 1640 pts/30   S    09:34   0:00
/vapp/bin/ssh -v -l war x-ceed.net
war       1515  0.0  0.1  2520 1328 pts/18   S    09:34   0:00
/usr/bin/expect -- /vapp/bin/leon
war       1516  0.0  0.1  3112 1296 pts/31   S    09:34   0:00
/vapp/bin/ssh -v -l war x-ceed.net
war       1540  0.0  0.0  2204  992 ?        S    09:34   0:00 /bin/sh
-c killall -9 netscape ; rm -rf ~/.netscape/lock && netscape -mail
war       1543  0.3  2.8 47736 29660 ?       S    09:34   1:05 netscape
-mail
war       1544  0.0  0.1 17268 1328 ?        S    09:34   0:00 (dns
helper)
war       1919  0.0  0.1  2512 1324 pts/21   S    09:38   0:00
/usr/bin/expect -- /vapp/bin/leon
war       1920  0.0  0.1  3024 1248 pts/29   S    09:38   0:00
/vapp/bin/ssh -v -l war x-ceed.net
war       2149  0.0  0.6 13240 6528 ?        S    09:40   0:07
/vapp/bin/pan
war       2152  0.0  0.6 13240 6528 ?        S    09:40   0:00
/vapp/bin/pan
war       2153  0.0  0.6 13240 6528 ?        S    09:40   0:00
/vapp/bin/pan
war       4445  0.0  0.2  6036 2452 ?        S    10:15   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war       4449  0.0  0.2  3856 2692 pts/2    S    10:15   0:00 bash
war       4477  0.0  0.1  2504 1316 pts/2    S    10:15   0:00
/usr/bin/expect -- /vapp/bin/sc2
war       4478  0.0  0.0  1812  760 pts/13   S    10:15   0:00 telnet
war      12672  0.0  0.2  6048 2684 ?        S    12:25   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      12674  0.0  0.2  3876 2728 pts/32   S    12:25   0:00 bash
war      15932  0.0  0.2  6036 2532 ?        S    13:37   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      15936  0.0  0.2  6036 2468 ?        S    13:37   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      15937  0.0  0.2  3888 2732 pts/23   S    13:37   0:00 bash
war      15944  0.0  0.2  3888 2732 pts/24   S    13:37   0:00 bash
root     18173  0.0  0.1  2348 1040 pts/32   S    14:14   0:00 su
root     18178  0.0  0.2  3824 2664 pts/32   S    14:14   0:00 bash
war      18249  0.0  0.2  6036 2452 ?        S    14:15   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      18251  0.0  0.2  3888 2732 pts/33   S    14:15   0:00 bash
war      18289  0.3  5.2 178232 54372 pts/33 S    14:15   0:05
/appc/staroffice-6.0/program/soffice.bin
war      18318  0.0  5.2 178232 54372 pts/33 S    14:15   0:00
/appc/staroffice-6.0/program/soffice.bin
war      18319  0.0  5.2 178232 54372 pts/33 S    14:15   0:00
/appc/staroffice-6.0/program/soffice.bin
war      18320  0.0  5.2 178232 54372 pts/33 S    14:15   0:00
/appc/staroffice-6.0/program/soffice.bin
war      18325  0.0  5.2 178232 54372 pts/33 S    14:15   0:00
/appc/staroffice-6.0/program/soffice.bin
war      18329  0.0  5.2 178232 54372 pts/33 S    14:15   0:00
/appc/staroffice-6.0/program/soffice.bin
war      18336  0.0  0.2  6036 2456 ?        S    14:15   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      18338  0.0  0.2  3888 2732 pts/34   S    14:15   0:00 bash
war      18373  0.0  0.1  2264 1072 pts/34   S    14:15   0:00 /bin/sh
/appc/mozilla-0.9.5/run-mozilla.sh ./mozilla-bin
war      18378  0.4  2.5 37112 26028 pts/34  S    14:15   0:05
./mozilla-bin
war      18379  0.0  2.5 37112 26028 pts/34  S    14:15   0:00
./mozilla-bin
war      18380  0.0  2.5 37112 26028 pts/34  S    14:15   0:00
./mozilla-bin
war      18381  0.0  2.5 37112 26028 pts/34  S    14:15   0:00
./mozilla-bin
war      18395  0.0  0.2  6036 2600 ?        S    14:15   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      18397  0.0  0.2  3880 2724 pts/35   S    14:15   0:00 bash
war      18449  0.0  0.7 10712 7636 pts/35   S    14:15   0:01 gimp
war      18452  0.0  0.2  6384 2992 pts/35   S    14:15   0:00
/app/gimp-1.2.2/lib/gimp/1.2/plug-ins/script-fu -gimp 11 10 -run 1
war      18459  0.0  1.2 18036 12884 pts/35  S    14:16   0:00 display
war      18464  0.0  0.2  4440 2324 pts/35   S    14:16   0:00 xv
war      18477  0.0  0.7 14900 7828 pts/35   S    14:16   0:00
/app/acrobat-4.05/Reader/intellinux/bin/acroread
war      18500  0.0  1.1 30808 11612 pts/35  S    14:16   0:00 xmms
war      18501  0.0  1.1 30808 11612 pts/35  S    14:16   0:00 xmms
war      18502  0.0  1.1 30808 11612 pts/35  S    14:16   0:00 xmms
war      18503  0.0  1.1 30808 11612 pts/35  S    14:16   0:00 xmms
war      18508  0.0  0.2  6036 2460 ?        S    14:16   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      18510  0.0  0.2  3880 2724 pts/36   S    14:16   0:00 bash
war      18538  0.0  1.1 30808 11612 pts/35  S    14:16   0:00 xmms
root     18539  0.0  0.1  2348 1040 pts/36   S    14:16   0:00 su
root     18542  0.0  0.2  3824 2664 pts/36   S    14:16   0:00 bash
root     18570  0.0  0.4 16776 5076 pts/36   S    14:16   0:00 xmms
root     18571  0.0  0.4 16776 5076 pts/36   S    14:16   0:00 xmms
root     18572  0.0  0.4 16776 5076 pts/36   S    14:16   0:00 xmms
root     18573  0.0  0.4 16776 5076 pts/36   S    14:16   0:00 xmms
war      18640  0.0  0.2  3920 2212 ?        S    14:17   0:00 gv
war      18655  0.0  0.0  2204  988 ?        S    14:17   0:00 /bin/sh
/usr/bin/gftp
war      18656  0.0  0.3  5304 3272 ?        S    14:17   0:00
/usr/bin/gftp-gtk
war      18677  0.0  0.3  7732 3532 ?        S    14:18   0:00 gnomeicu
--activate-goad-server=gnomeicu
war      18691  0.0  0.4  8184 4296 ?        S    14:18   0:00
/usr/bin/gnome-terminal -x lynx
war      18696  0.0  0.0  1420  564 ?        S    14:18   0:00
gnome-pty-helper
war      18697  0.0  0.2  4432 2256 pts/37   S    14:18   0:00 lynx
war      18706  0.0  0.3  7112 3348 ?        S    14:18   0:00 gq
war      18748  0.0  0.2  6036 2512 ?        S    14:18   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      18754  0.0  0.2  3880 2728 pts/38   S    14:18   0:00 bash
war      18785  0.0  0.2  5296 2812 pts/38   S    14:18   0:00 vlc
war      18788  0.1  1.1 86288 11912 pts/38  S    14:18   0:01 aviplay
war      18802  0.0  0.4  7924 4260 pts/38   S    14:18   0:00 fidelio
war      18805  0.0  0.2  5356 2664 pts/38   S    14:18   0:00 gtkhx
war      18808  0.0  0.2  4740 2564 pts/38   S    14:19   0:00 hdbench
war      18809  0.0  0.7 21040 7308 pts/38   S    14:19   0:00 xmovie
war      18810  0.0  0.7 21040 7308 pts/38   S    14:19   0:00 xmovie
war      18811  0.0  0.7 21040 7308 pts/38   S    14:19   0:00 xmovie
war      18812  0.0  0.7 21040 7308 pts/38   S    14:19   0:00 xmovie
war      18813  0.0  0.7 21040 7308 pts/38   S    14:19   0:00 xmovie
war      18846  0.0  0.2  5324 2880 pts/38   S    14:19   0:00 blackbook

war      18867  0.0  0.2  5288 2912 pts/38   S    14:19   0:00 ripperX
root     18883  0.0  0.1  2348 1040 pts/17   S    14:20   0:00 su
root     18890  0.0  0.2  3820 2660 pts/17   S    14:20   0:00 bash
root     18918  0.0  0.2 14772 2568 pts/17   S    14:20   0:00 ntop
root     18919  0.0  0.2 14772 2568 pts/17   S    14:20   0:00 ntop
root     18920  0.0  0.2 14772 2568 pts/17   S    14:20   0:00 ntop
root     18921  0.0  0.2 14772 2568 pts/17   S    14:20   0:00 ntop
root     18922  0.0  0.2 14772 2568 pts/17   S    14:20   0:00 ntop
root     18923  0.0  0.2 14772 2568 pts/17   S    14:20   0:00 ntop
root     18924  0.0  0.2 14772 2568 pts/17   S    14:20   0:00 ntop
root     18927  0.0  0.1  2348 1040 pts/20   S    14:20   0:00 su
root     18930  0.0  0.2  3820 2660 pts/20   S    14:20   0:00 bash
root     18960  0.0  0.0  1816  852 pts/20   S    14:20   0:00 iptraf
root     18963  0.0  0.1  2348 1040 pts/19   S    14:20   0:00 su
root     18966  0.0  0.2  3820 2660 pts/19   S    14:20   0:00 bash
root     18994  0.0  0.3  4108 3224 pts/19   S    14:20   0:00 netwatch
root     18995  0.0  0.0  1636  692 pts/19   S    14:20   0:00 netresolv

root     19014  0.0  0.1  2348 1040 pts/16   S    14:20   0:00 su
root     19019  0.0  0.2  3824 2664 pts/16   S    14:20   0:00 bash
root     19053  0.0  0.3  6052 3748 pts/16   S    14:20   0:00 gqview
root     19056  0.0  0.3  5572 3276 pts/16   S    14:20   0:00 gkrellm
war      19059  0.0  0.3  6276 3924 pts/15   S    14:20   0:00 gkrellm
war      19066  0.0  0.5  9116 5480 pts/15   S    14:20   0:00 irssi
war      19082  0.0  0.2  6036 2452 ?        S    14:21   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      19084  0.0  0.2  3880 2724 pts/39   S    14:21   0:00 bash
root     19116  2.8  0.1  2360 1340 pts/36   R    14:21   0:28 top
war      19135  0.0  0.3  6788 3616 ?        S    14:21   0:00 grecord
war      19138  0.0  0.3  8304 3756 ?        S    14:21   0:00 extace
war      19156  0.0  0.3  6792 3588 ?        S    14:21   0:00 gmix
war      19159  0.4  0.3  7552 3988 ?        S    14:21   0:04 gtcd
war      19160  0.0  0.3  5848 3192 ?        S    14:21   0:00
/usr/bin/grip
war      19163  0.0  0.3  6280 3712 ?        S    14:21   0:00
/usr/bin/gphoto
war      19169  0.0  0.0  1712  492 ?        S    14:21   0:00 esd
-terminate -nobeeps -as 2 -spawnfd 7
war      19176  0.0  0.3  8304 3756 ?        S    14:21   0:00 extace
war      19178  0.0  0.2  4984 2608 ?        S    14:21   0:00
/usr/X11R6/bin/aumix-X11
war      19193  0.0  0.2  6036 2452 ?        S    14:21   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      19195  0.0  0.2  3880 2724 pts/40   S    14:21   0:00 bash
war      19223  0.0  0.5 11464 5696 pts/40   S    14:21   0:00 opera
-nowin
war      19268  0.0  0.2  4664 2408 ?        S    14:22   0:00 gdmconfig

root     19269  0.0  0.1  2736 1088 ?        S    14:22   0:00
/usr/sbin/userhelper -d 7,6,2 -w gdmconfig
war      19272  0.0  0.2  4652 2384 ?        S    14:22   0:00
gnorpm-auth
root     19274  0.0  0.1  2736 1048 ?        S    14:22   0:00
/usr/sbin/userhelper -d 7,6,2 -w gnorpm-auth
war      19278  9.7  0.4  7740 4832 ?        R    14:22   1:29 gtop
war      19281  0.0  0.3  7240 3824 ?        S    14:22   0:00 guname
war      19285  0.0  0.4  8192 4360 ?        S    14:22   0:00
gnome-terminal --use-factory --start-factory-server
war      19287  0.0  0.0  1420  564 ?        S    14:22   0:00
gnome-pty-helper
war      19288  0.0  0.2  3884 2724 pts/41   S    14:22   0:00 bash
war      19310  0.0  0.3  7908 3648 ?        S    14:22   0:00
/usr/sbin/gkadmin
war      19321  0.0  0.2  4652 2400 ?        S    14:22   0:00
locale_config
root     19322  0.0  0.1  2736 1048 ?        S    14:22   0:00
/usr/sbin/userhelper -d 7,6,2 -w locale_config
war      19327  0.0  0.2  4628 2276 ?        S    14:22   0:00
switchdesk-gnome
war      19335  0.0  0.2  4680 2376 ?        S    14:22   0:00 userinfo
war      19343  0.0  0.2  4652 2380 ?        S    14:22   0:00
/usr/bin/redhat-config-users
root     19346  0.0  0.1  2736 1048 ?        S    14:22   0:00
/usr/sbin/userhelper -d 7,6,2 -w redhat-config-users
war      19356  0.0  0.2  4652 2392 ?        S    14:22   0:00
/usr/bin/up2date-config
root     19357  0.0  0.0  2532 1024 ?        S    14:22   0:00
/usr/sbin/userhelper -d 7,6,2 -w up2date-config
root     19366  0.0  0.7 12780 7828 ?        S    14:22   0:00
/usr/bin/python -u /usr/sbin/up2date-config
root     19376  0.0  0.0  2188  960 ?        S    14:22   0:00 /bin/sh
/usr/share/redhat-config-users/redhat-config-users
root     19377  0.0  0.7 11012 7420 ?        S    14:22   0:00
/usr/bin/python /usr/share/redhat-config-users/redhat-config-users.py
root     19388  0.2  0.4  9184 4656 ?        S    14:22   0:01
gnorpm-auth
root     19393  0.1  1.3 49812 13744 ?       S    14:22   0:01
locale_config
root     19398  0.0  0.4  8328 5136 ?        S    14:22   0:00 gdmconfig

war      19433  0.0  0.1  3356 1036 pts/26   S    14:23   0:00 links
war      19440  0.0  0.2  4772 2660 pts/25   S    14:23   0:00 lynx
www.cnn.com
war      19446  0.1  0.2  6048 2868 ?        S    14:23   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      19448  0.0  0.2  3880 2724 pts/42   S    14:23   0:00 bash
root     19518  0.0  0.0  2104  916 pts/16   S    14:24   0:00 bc
war      19533  0.0  0.3  6140 3848 ?        S    14:24   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      19535  0.0  0.2  3884 2732 pts/43   S    14:24   0:00 bash
war      19600  0.0  0.2  6000 2424 pts/43   S    14:24   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb -e ncftp
war      19602  0.0  0.0  1860  888 pts/44   S    14:24   0:00 ncftp
war      19605  0.0  0.2  6000 2420 pts/43   S    14:25   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb -e lftp
war      19607  0.0  0.1  3432 1460 pts/45   S    14:25   0:00 lftp
war      19620  0.0  0.2  6000 2440 pts/43   S    14:25   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb -e xine
war      19624  0.0  1.9 30332 19884 pts/46  S    14:25   0:00 xine
war      19625  0.0  1.9 30332 19884 pts/46  S    14:25   0:00 xine
war      19626  0.0  1.9 30332 19884 pts/46  S    14:25   0:00 xine
war      19627  0.0  1.9 30332 19884 pts/46  S    14:25   0:00 xine
war      19628  0.0  1.9 30332 19884 pts/46  S    14:25   0:00 xine
war      19629  0.0  1.9 30332 19884 pts/46  S    14:25   0:00 xine
war      19638  0.0  0.2  6000 2436 pts/43   S    14:25   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb -e nano
war      19640  0.0  0.0  1988  900 pts/47   S    14:25   0:00 nano
war      19665  0.0  0.2  6000 2432 pts/43   S    14:25   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb -e si
war      19667  0.0  0.2  3992 2964 pts/48   S    14:25   0:00 si
war      19668  0.0  0.0  1988  812 pts/48   S    14:25   0:00 less
war      19695  0.0  0.2  6000 2436 pts/43   S    14:25   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb -e sntop
war      19697  0.0  0.0  2188  948 pts/49   S    14:25   0:00 /bin/sh
/vapp/bin/sntop
war      19698  0.0  0.0  1656  704 pts/49   S    14:25   0:00
/app/sntop-1.4.2/bin/sntop-1.4.2 -f /app/sntop-1.4.2/etc/sntoprc
war      19725  0.0  0.2  6000 2388 pts/43   S    14:25   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb -e nt
war      19727  0.0  0.3 10180 3648 pts/50   S    14:25   0:00 nt
war      19728  0.0  0.3 10180 3648 pts/50   S    14:25   0:00 nt
war      19729  0.0  0.3 10180 3648 pts/50   S    14:25   0:00 nt
war      19730  0.0  0.3 10180 3648 pts/50   S    14:25   0:00 nt
war      19737  0.0  0.2  6000 2432 pts/43   S    14:26   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb -e pine -i
war      19739  0.0  0.1  5640 1720 pts/51   S    14:26   0:00 pine -i
war      19744  0.0  0.2  6000 2388 pts/43   S    14:26   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb -e gps
war      19750  0.0  0.3  5868 3448 pts/52   SN   14:26   0:00 gps
root     19849  0.0  0.1  2348 1040 pts/35   S    14:26   0:00 su
root     19852  0.0  0.2  3832 2676 pts/35   S    14:26   0:00 bash
root     19947  0.0  0.4  8160 4236 pts/35   S    14:27   0:00
gnome-terminal
root     19948  0.0  0.0  1420  564 pts/35   S    14:27   0:00
gnome-pty-helper
root     19949  0.0  0.2  3824 2660 pts/53   S    14:27   0:00 bash
root     19979  0.0  0.4  8172 4300 pts/35   S    14:27   0:00
gnome-terminal
root     19980  0.0  0.0  1420  564 pts/35   S    14:27   0:00
gnome-pty-helper
root     19981  0.0  0.2  3824 2664 pts/54   S    14:27   0:00 bash
root     20009  0.0  0.4  8172 4264 pts/35   S    14:27   0:00
gnome-terminal
root     20010  0.0  0.0  1420  564 pts/35   S    14:27   0:00
gnome-pty-helper
root     20011  0.0  0.2  3824 2660 pts/55   S    14:27   0:00 bash
root     20047  0.0  0.4  8172 4304 pts/35   S    14:27   0:00
gnome-terminal
root     20048  0.0  0.0  1420  564 pts/35   S    14:27   0:00
gnome-pty-helper
root     20049  0.0  0.2  3828 2672 pts/56   S    14:27   0:00 bash
root     20079  0.0  0.4  8172 4304 pts/35   S    14:27   0:00
gnome-terminal
root     20080  0.0  0.0  1420  564 pts/35   S    14:27   0:00
gnome-pty-helper
root     20081  0.0  0.2  3824 2660 pts/57   S    14:27   0:00 bash
root     20144  0.2  0.7 12920 8008 pts/54   S    14:27   0:01 xemacs
war      20163  0.0  0.1  2888 1332 ?        S    14:28   0:00 xosview
war      20171  0.0  0.4  8200 4232 ?        S    14:28   0:00 gvim
war      20172  0.1  0.1  2940 1448 ?        S    14:28   0:00 rxvt
war      20175  0.0  0.1  3348 1596 ?        S    14:28   0:00 xmailbox
war      20182  0.0  0.3  7932 3928 ?        S    14:28   0:00
/usr/bin/krb5
war      20183  0.0  0.2  3880 2720 ttyp1    S    14:28   0:00 bash
war      20187  0.0  0.3  7016 3744 ?        S    14:28   0:00
gsearchtool
war      20217  0.0  0.3  7532 3616 ?        S    14:28   0:00 gless
--nostdin
war      20220  0.0  0.3  7080 3784 ?        S    14:28   0:00 gfontsel
war      20229  0.0  0.3  7700 3856 ?        S    14:28   0:00 gfloppy
war      20236  0.0  0.3  7024 3764 ?        S    14:28   0:00 gcharmap
war      20239  0.0  0.5  9168 5648 ?        S    14:28   0:00 bug-buddy

war      20355  0.1  0.4  8152 5016 ?        S    14:29   0:00 gnomecal
war      20361  0.0  0.5  9428 5684 ?        S    14:29   0:00 dia
war      20364  0.0  0.4  7672 4380 ?        S    14:29   0:00 gnomecard

war      20367  0.0  0.4  8360 4484 ?        S    14:29   0:00 gedit
war      20380  0.0  0.3  7644 3896 ?        S    14:29   0:00 gtt
war      20387  0.1  0.7 15180 8204 ?        S    14:29   0:00 guppi
war      20396  0.1  0.7 11768 7292 ?        S    14:29   0:00 gnumeric
war      20455  0.0  0.3  7072 3876 ?        S    14:29   0:00 freecell
war      20458  0.0  0.1  5756 1408 ?        S    14:29   0:00 freecell
war      20459  0.0  0.3  6904 3660 ?        S    14:29   0:00 gnibbles
war      20460  0.0  0.1  5740 1364 ?        S    14:29   0:00 gnibbles
war      20463  0.0  0.4  7692 4144 ?        S    14:29   0:00 gataxx
war      20464  0.0  0.1  6256 1564 ?        S    14:29   0:00 gataxx
war      20469  0.0  0.5  8540 5352 ?        S    14:29   0:00
gnome-stones
war      20472  0.0  0.1  5716 1372 ?        S    14:29   0:00
gnome-stones
war      20475  0.0  0.3  7012 3784 ?        S    14:29   0:00 glines
war      20476  0.0  0.1  5692 1356 ?        S    14:29   0:00 glines
war      20481  0.0  0.3  7096 3860 ?        S    14:29   0:00 gnobots2
war      20482  0.0  0.1  5768 1372 ?        S    14:29   0:00 gnobots2
war      20485  0.0  0.3  6844 3652 ?        S    14:29   0:00 gnotravex

war      20488  0.0  0.1  5696 1364 ?        S    14:29   0:00 gnotravex

war      20493  0.0  0.3  6804 3644 ?        S    14:29   0:00 gnomine
war      20494  0.0  0.1  5736 1368 ?        S    14:29   0:00 gnomine
war      20505  0.0  0.5  8740 5528 ?        S    14:29   0:00 sol
war      20506  0.0  0.3  6836 3592 ?        S    14:29   0:00 gnotski
war      20507  0.0  0.1  5688 1360 ?        S    14:29   0:00 gnotski
war      20508  0.0  0.1  6224 1520 ?        S    14:29   0:00 sol
war      20523  1.9  0.0  2536  844 ?        S    14:29   0:08 xsnow
war      20642  0.0  0.5  9288 5384 ?        S    14:31   0:00
screensaver-properties-capplet
war      20646  0.0  0.3  8372 4008 ?        S    14:31   0:00
theme-selector-capplet
war      20649  0.0  0.3  8024 3388 ?        S    14:31   0:00
theme-selector-capplet
war      20652  0.0  0.3  7992 3884 ?        S    14:31   0:00
wm-properties-capplet --sync
war      20662  0.0  0.4  7648 4228 ?        S    14:31   0:00
gnome-panel-properties-capplet
war      20671  0.0  0.3  7268 3680 ?        S    14:31   0:00
xalf-capplet
war      20685  0.0  0.3  7432 4080 ?        S    14:31   0:00
sound-properties
war      20691  0.0  0.4  7960 4156 ?        S    14:31   0:00
cd-capplet
war      20697  0.0  0.3  7268 3716 ?        S    14:31   0:00
keyboard-properties
war      20703  0.0  0.3  7252 3644 ?        S    14:31   0:00
mouse-properties-capplet
war      20715  0.0  0.3  7068 3488 ?        S    14:31   0:00
gnome-edit-properties-capplet
war      20725  0.0  0.3  7292 3788 ?        S    14:31   0:00
url-properties
war      20745  0.0  0.4 10232 5008 ?        S    14:31   0:00
gtkhtml-properties-capplet
war      20751  0.0  0.3  6836 3316 ?        S    14:31   0:00
gdmphotosetup
war      20756  0.0  0.3  7256 3624 ?        S    14:31   0:00
ui-properties --cap-id=0
war      20766  0.2  0.6  9460 6680 ?        S    14:31   0:00 gmenu
war      20789  0.4  0.5  9828 6032 ?        S    14:31   0:01
file-types-capplet
root     20849  0.0  0.1  2348 1040 pts/42   S    14:32   0:00 su
root     20856  0.0  0.2  3824 2664 pts/42   S    14:32   0:00 bash
war      21245  0.0  0.2  6036 2520 ?        S    14:33   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21268  0.0  0.2  3892 2748 pts/58   S    14:33   0:00 bash
war      21380  0.0  0.2  6036 2456 ?        S    14:33   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21394  0.0  0.2  3880 2724 pts/59   S    14:33   0:00 bash
war      21554  0.0  0.2  6012 2420 pts/58   S    14:33   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21556  0.0  0.2  3880 2720 pts/60   S    14:33   0:00 bash
war      21586  0.0  0.2  6012 2432 pts/58   S    14:33   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21588  0.0  0.2  3880 2724 pts/61   S    14:33   0:00 bash
war      21663  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21664  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21665  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21666  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21667  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21669  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21670  0.0  0.2  3880 2720 pts/62   S    14:34   0:00 bash
war      21673  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21677  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21680  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21703  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21704  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21705  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21706  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21707  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21709  0.0  0.2  3880 2720 pts/63   S    14:34   0:00 bash
war      21711  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21716  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21719  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21737  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21745  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21746  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21748  0.0  0.2  3880 2720 pts/64   S    14:34   0:00 bash
war      21751  0.0  0.2  3880 2720 pts/65   S    14:34   0:00 bash
war      21753  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21759  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21765  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21783  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21809  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21810  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21811  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21812  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21813  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21814  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21815  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21816  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21818  0.0  0.2  3880 2720 pts/66   S    14:34   0:00 bash
war      21820  0.1  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21825  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21826  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21846  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21850  0.1  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21851  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21852  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21853  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21854  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21855  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21857  0.0  0.2  3880 2720 pts/68   S    14:34   0:00 bash
war      21861  0.1  0.2  3880 2720 pts/70   S    14:34   0:00 bash
war      21863  0.0  0.2  3880 2720 pts/67   S    14:34   0:00 bash
war      21866  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21873  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21874  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21916  0.1  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21920  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21921  0.0  0.2  6012 2428 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21926  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21930  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21931  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21954  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21955  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21957  0.0  0.2  3880 2720 pts/69   S    14:34   0:00 bash
war      21960  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21964  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21967  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21987  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21991  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21992  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21995  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21996  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21997  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21998  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      21999  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      22000  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      22001  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      22002  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      22003  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      22004  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      22005  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      22006  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      22008  0.0  0.2  3880 2720 pts/72   S    14:34   0:00 bash
war      22012  0.0  0.2  3880 2720 pts/73   S    14:34   0:00 bash
war      22015  0.0  0.2  3880 2720 pts/71   S    14:34   0:00 bash
war      22017  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      22029  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      22079  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      22084  0.0  0.2  3880 2720 pts/75   S    14:34   0:00 bash
war      22105  0.0  0.2  6012 2420 pts/58   S    14:34   0:00 xterm -cc
33:48,36-37:48,43:48,45-46:48,47:48,126:48 -bg black -fg white -sl 4096
+sb
war      22127  0.0  0.2  3880 2720 pts/80   S    14:34   0:00 bash
war      22130  0.0  0.2  3880 2720 pts/79   S    14:34   0:00 bash
war      22133  0.1  0.2  3880 2720 pts/76   S    14:34   0:00 bash
war      22136  0.0  0.2  3880 2720 pts/77   S    14:34   0:00 bash
war      22140  0.0  0.2  3880 2720 pts/78   S    14:34   0:00 bash
war      22177  0.0  0.2  3880 2720 pts/86   S    14:34   0:00 bash
war      22179  0.1  0.2  3880 2720 pts/87   S    14:34   0:00 bash
war      22181  0.0  0.2  3880 2720 pts/88   S    14:34   0:00 bash
war      22185  0.1  0.2  3880 2720 pts/89   S    14:34   0:00 bash
war      22187  0.0  0.2  3880 2720 pts/85   S    14:34   0:00 bash
war      22190  0.0  0.2  3880 2720 pts/81   S    14:34   0:00 bash
war      22192  0.1  0.2  3880 2720 pts/82   S    14:34   0:00 bash
war      22195  0.0  0.2  3880 2720 pts/84   S    14:34   0:00 bash
war      22533  0.0  0.2  3880 2720 pts/83   S    14:34   0:00 bash
war      22569  0.0  0.2  3880 2720 pts/90   S    14:34   0:00 bash
war      22572  0.1  0.2  3880 2720 pts/101  S    14:34   0:00 bash
war      22575  0.0  0.2  3880 2720 pts/102  S    14:34   0:00 bash
war      22578  0.2  0.2  3880 2720 pts/103  S    14:34   0:00 bash
war      22580  0.0  0.2  3880 2720 pts/99   S    14:34   0:00 bash
war      22583  0.1  0.2  3880 2720 pts/100  S    14:34   0:00 bash
war      22585  0.0  0.2  3880 2720 pts/97   S    14:34   0:00 bash
war      22588  0.0  0.2  3880 2720 pts/96   S    14:34   0:00 bash
war      22591  0.1  0.2  3880 2720 pts/91   S    14:34   0:00 bash
war      22594  0.0  0.2  3880 2720 pts/93   S    14:34   0:00 bash
war      22602  0.1  0.2  3880 2720 pts/109  S    14:34   0:00 bash
war      22605  0.0  0.2  3880 2720 pts/110  S    14:34   0:00 bash
war      22608  0.1  0.2  3880 2720 pts/74   S    14:34   0:00 bash
war      22681  0.0  0.2  3880 2720 pts/106  S    14:34   0:00 bash
war      22683  0.0  0.2  3880 2720 pts/111  S    14:34   0:00 bash
war      22685  0.0  0.2  3880 2720 pts/113  S    14:34   0:00 bash
war      22686  0.0  0.2  3880 2720 pts/116  S    14:34   0:00 bash
war      22688  0.0  0.2  3880 2720 pts/115  S    14:34   0:00 bash
war      22689  0.0  0.2  3880 2720 pts/114  S    14:34   0:00 bash
war      22690  0.0  0.2  3880 2720 pts/118  S    14:34   0:00 bash
war      22692  0.1  0.2  3880 2720 pts/119  S    14:34   0:00 bash
war      22721  0.1  0.2  3880 2720 pts/98   S    14:34   0:00 bash
war      22723  0.0  0.2  3880 2720 pts/107  S    14:34   0:00 bash
war      22726  0.1  0.2  3880 2720 pts/108  S    14:34   0:00 bash
war      22728  0.0  0.2  3880 2720 pts/120  S    14:34   0:00 bash
war      22730  0.0  0.2  3880 2720 pts/94   S    14:34   0:00 bash
war      22732  0.0  0.2  3880 2720 pts/132  S    14:34   0:00 bash
war      22734  0.0  0.2  3880 2720 pts/129  S    14:34   0:00 bash
war      22736  0.0  0.2  3880 2720 pts/128  S    14:34   0:00 bash
war      22738  0.0  0.2  3880 2720 pts/127  S    14:34   0:00 bash
war      22741  0.0  0.2  3880 2720 pts/126  S    14:34   0:00 bash
war      22743  0.2  0.2  3880 2720 pts/122  S    14:34   0:00 bash
war      22745  0.0  0.2  3880 2720 pts/124  S    14:34   0:00 bash
war      22748  0.2  0.2  3880 2720 pts/125  S    14:34   0:00 bash
war      22794  0.2  0.2  3880 2720 pts/112  S    14:34   0:00 bash
war      22899  0.1  0.2  3880 2720 pts/134  S    14:34   0:00 bash
war      22902  0.1  0.2  3880 2720 pts/133  S    14:34   0:00 bash
war      23159  0.1  0.2  3880 2720 pts/105  S    14:34   0:00 bash
war      23393  0.0  0.2  3880 2720 pts/130  S    14:34   0:00 bash
war      23396  0.0  0.2  3880 2720 pts/104  S    14:34   0:00 bash
war      23399  0.0  0.2  3880 2720 pts/131  S    14:34   0:00 bash
war      23402  0.0  0.2  3880 2720 pts/121  S    14:34   0:00 bash
war      23405  0.1  0.2  3880 2720 pts/117  S    14:34   0:00 bash
war      23629  0.0  0.2  3880 2720 pts/92   S    14:34   0:00 bash
war      23630  0.0  0.2  3880 2720 pts/95   S    14:34   0:00 bash
war      23895  0.0  0.2  3880 2720 pts/136  S    14:35   0:00 bash
war      23918  0.0  0.2  3880 2720 pts/123  S    14:35   0:00 bash
war      23948  0.0  0.2  3880 2720 pts/135  S    14:35   0:00 bash
war      24230  0.0  0.1  3400 1464 pts/61   R    14:37   0:00 ps auxww


