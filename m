Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266091AbTATPzC>; Mon, 20 Jan 2003 10:55:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266069AbTATPzB>; Mon, 20 Jan 2003 10:55:01 -0500
Received: from smtp.kolej.mff.cuni.cz ([195.113.25.225]:14596 "EHLO
	smtp.kolej.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S266116AbTATPyl>; Mon, 20 Jan 2003 10:54:41 -0500
X-Envelope-From: roubm9am@barbora.ms.mff.cuni.cz
Message-ID: <186801c2c09d$7430d130$551b71c3@krlis>
From: "Milan Roubal" <roubm9am@barbora.ms.mff.cuni.cz>
To: <linux-kernel@vger.kernel.org>
Cc: "Joseph D. Wagner" <wagnerjd@prodigy.net>
References: <000801c2a598$99eccc00$35251c43@joe>
Subject: Again: big load
Date: Mon, 20 Jan 2003 17:03:15 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2720.3000
X-Mimeole: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Big Load:
What could be wrong? It happend one month ago, and today too :((((
     Thanx
     Milan Roubal

# /usr/local/samba/bin/smbd -V
Version 2.2.6

System is 2.4.18-3 from SuSE,
SuSE 8.1 distribution.
Filesystem XFS on 1TB RAID5 array

# vmstat
   procs                      memory    swap          io     system
cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy
id
 0 30  0      0  22016   3484 398716   0   0    70    12  326   114   2  23
76

#top
 4:46pm  up 16:08,  2 users,  load average: 30.03, 29.84, 26.01
94 processes: 92 sleeping, 1 running, 1 zombie, 0 stopped
CPU0 states:  0.0% user,  0.0% system,  0.0% nice, 100.0% idle
CPU1 states:  0.0% user,  0.1% system,  0.0% nice, 99.4% idle
Mem:  1032224K av, 1019264K used,   12960K free,       0K shrd,    5292K
buff
Swap:       0K av,       0K used,       0K free                  405988K
cached

# ps axfl
  F   UID   PID  PPID PRI  NI   VSZ  RSS WCHAN  STAT TTY        TIME COMMAND
004     0     1     0  20   0   448  236 do_sel S    ?          0:09 init
002     0     2     1  20   0     0    0 contex SW   ?          0:00
[keventd]
002     0     3     1  20  19     0    0 ksofti SWN  ?          0:02
[ksoftirqd_CPU0]
002     0     4     1  20  19     0    0 ksofti SWN  ?          0:00
[ksoftirqd_CPU1]
022     0     5     1  20   0     0    0 kswapd SW   ?         10:16
[kswapd]
002     0     6     1   7   0     0    0 bdflus SW   ?         66:25
[bdflush]
002     0     7     1  20   0     0    0 kupdat SW   ?         41:09
[kupdated]
002     0     8     1  19   0     0    0 kinode SW   ?          0:00
[kinoded]
002     0    11     1  18 -20     0    0 md_thr SW<  ?          0:00
[mdrecoveryd]
002     0    14     1  20   0     0    0 reiser SW   ?          0:03
[kreiserfsd]
004   508   206     1  20   0  1304  360 do_sel S    ?          0:00
qmail-send
004   504   211   206  20   0  1268  424 pipe_w S    ?          0:00  \_
splogger qmail
000     0   212   206  20   0  1260  308 do_sel S    ?          0:00  \_
qmail-lspawn ./Maildir/
004   507   213   206  20   0  1256  296 do_sel S    ?          0:00  \_
qmail-rspawn
004   506   214   206  20   0  1252  312 pipe_w S    ?          0:00  \_
qmail-clean
000     0   207     1  20   0  1284  308 nanosl S    ?          0:06
/usr/local/bin/svscan /service
003     0 17839   207  20   0     0    0 do_exi Z    ?          0:00  \_
[svscan <defunct>]
002     0   220     1  20   0  1772  572 do_sel S    ?          0:00
/usr/lib/courier-imap/libexec/authlib/authdaemond.plain s
006     0   221   220  20   0  1772  624 do_sel S    ?          0:00  \_
/usr/lib/courier-imap/libexec/authlib/authdaemond.pla
006     0   222   220  20   0  1772  624 do_sel S    ?          0:00  \_
/usr/lib/courier-imap/libexec/authlib/authdaemond.pla
006     0   223   220  20   0  1772  624 do_sel S    ?          0:00  \_
/usr/lib/courier-imap/libexec/authlib/authdaemond.pla
006     0   225   220  20   0  1772  624 do_sel S    ?          0:00  \_
/usr/lib/courier-imap/libexec/authlib/authdaemond.pla
006     0   226   220  20   0  1772  624 do_sel S    ?          0:00  \_
/usr/lib/courier-imap/libexec/authlib/authdaemond.pla
006     0   230     1  20   0  1360  516 do_sel S    ?          0:00
/usr/lib/courier-imap/libexec/couriertcpd -address=0 -std
004    89  5009   230  20   0  2784 1524 do_sel S    ?          0:01  \_
/usr/lib/courier-imap/bin/imapd Maildir
000     0   237     1  20   0  1260  428 pipe_w S    ?          0:01
/usr/lib/courier-imap/libexec/courierlogger imapd
022     0   274     1  20   0     0    0 end    SW   ?          0:08
[pagebuf_daemon]
006     0   418     1  20   0  1360  604 do_sel S    ?          0:03
/sbin/syslogd -a /var/lib/dhcp/dev/log
006     0   421     1  20   0  1312  544 do_sys S    ?          0:00
/sbin/klogd -c 1 -2
002     0   457     1  20   0     0    0 end    SW   ?          0:00 [khubd]
006     1   596     1  20   0  1300  404 do_pol S    ?          0:00
/sbin/portmap
002    25   654     1  20   0  1400  328 nanosl S    ?          0:00
/usr/sbin/atd
006     0   659     1  20   0  4156 1056 do_sel S    ?          0:00
/usr/sbin/sshd
006     0 17562   659  20   0  7316 2288 do_sel S    ?          0:00  \_
/usr/sbin/sshd
004     0 17565 17562  20   0  2572 1608 wait4  S    pts/0      0:00
     \_ -bash
004     0 17840 17565  20   0  2968 1960 -      R    pts/0      0:00
\_ ps axfl
002     0   829     1  20   0 11748  648 do_pol S    ?          0:00
/usr/sbin/nscd
002     0   830   829  20   0 11748  648 do_pol S    ?          0:00  \_
/usr/sbin/nscd
002     0   831   830  20   0 11748  648 do_pol S    ?          0:00      \_
/usr/sbin/nscd
002     0   832   830  20   0 11748  648 do_pol S    ?          0:00      \_
/usr/sbin/nscd
002     0   833   830  20   0 11748  648 do_pol S    ?          0:00      \_
/usr/sbin/nscd
002     0   834   830  19   0 11748  648 wait_f S    ?          0:00      \_
/usr/sbin/nscd
002     0   835   830  20   0 11748  648 do_pol S    ?          0:00      \_
/usr/sbin/nscd
002     0   850     1  20   0  1420  560 nanosl S    ?          0:00
/usr/sbin/cron
004     0   863     1  20   0  1264  496 read_c S    tty1       0:00
/sbin/mingetty --noclear tty1
004     0   864     1  20   0  2016 1064 wait4  S    tty2       0:00
login -- root
004     0   882   864  20   0  2580 1620 read_c S    tty2       0:00
 \_ -bash
004     0   865     1  19   0  1264  496 read_c S    tty3       0:00
/sbin/mingetty tty3
004     0   866     1  20   0  1264  496 read_c S    tty4       0:00
/sbin/mingetty tty4
004     0   867     1  20   0  1272  500 read_c S    tty5       0:00
/sbin/mingetty tty5
004     0   868     1  20   0  1264  496 read_c S    tty6       0:00
/sbin/mingetty tty6
004     0   869     1  20   0  2248 1108 wait4  S    ?          0:00 /bin/sh
/command/svscanboot
000     0   871   869  20   0  1288  312 nanosl S    ?          0:02  \_
svscan /service
000     0   872   871  20   0  1252  284 do_pol S    ?          0:00  |   \_
supervise smtpd
004   503   874   872  20   0  1320  468 wait_f S    ?          0:00  |
\_ /usr/local/bin/tcpserver -v -R -1 -O -x /etc/
000     0   873   869  20   0  1244  240 pipe_w S    ?          0:00  \_
readproctitle service errors: ...: 0/20?tcpserver: st
002     0   971     1  20 -20     0    0 md_thr SW<  ?         84:13
[raid5d]
002     0   972     1   0  19     0    0 md_thr SWN  ?         13:24
[raid5syncd]
006 65534  7059     1  20   0  2304 1000 do_sel S    ?          0:00
proftpd: (accepting connections)
006     0  8260     1  20   0  2496 1112 do_sel S    ?          0:02
/usr/local/samba/bin/nmbd
006     0  8263     1  20   0  3464 1132 do_sel S    ?          0:00
/usr/local/samba/bin/smbd
406 65534  8268  8263   5   0  9944 8092 down   D    ?         60:14  \_
/usr/local/samba/bin/smbd
006     0 14058  8263  20   0  4872 2900 do_sel S    ?          8:35  \_
/usr/local/samba/bin/smbd
006 65534 16338  8263   0   0  4232 2360 end    D    ?          0:13  \_
/usr/local/samba/bin/smbd
006 65534 16603  8263  20   0  3916 1644 end    D    ?          0:00  \_
/usr/local/samba/bin/smbd
006 65534 16617  8263  19   0  3916 1632 end    D    ?          0:00  \_
/usr/local/samba/bin/smbd
006 65534 16632  8263  20   0  3920 1644 end    D    ?          0:00  \_
/usr/local/samba/bin/smbd
006 65534 16647  8263  20   0  3928 1840 end    D    ?          0:00  \_
/usr/local/samba/bin/smbd
006 65534 16909  8263  20   0  3928 1660 end    D    ?          0:00  \_
/usr/local/samba/bin/smbd
006 65534 16924  8263  20   0  3924 1636 end    D    ?          0:00  \_
/usr/local/samba/bin/smbd
006 65534 16939  8263  20   0  3924 1636 end    D    ?          0:00  \_
/usr/local/samba/bin/smbd
006 65534 16953  8263  20   0  3924 1732 end    D    ?          0:00  \_
/usr/local/samba/bin/smbd
006 65534 17018  8263  20   0  3932 1648 end    D    ?          0:00  \_
/usr/local/samba/bin/smbd
006 65534 17032  8263  19   0  3932 1636 end    D    ?          0:00  \_
/usr/local/samba/bin/smbd
006 65534 17047  8263  20   0  3932 1640 end    D    ?          0:00  \_
/usr/local/samba/bin/smbd
006 65534 17132  8263  20   0  3932 1724 end    D    ?          0:00  \_
/usr/local/samba/bin/smbd
006 65534 17162  8263  20   0  3932 1640 end    D    ?          0:00  \_
/usr/local/samba/bin/smbd
006 65534 17177  8263  20   0  3932 1652 end    D    ?          0:00  \_
/usr/local/samba/bin/smbd
006 65534 17192  8263  20   0  3932 1632 end    D    ?          0:00  \_
/usr/local/samba/bin/smbd
006 65534 17207  8263  20   0  3940 1728 end    D    ?          0:00  \_
/usr/local/samba/bin/smbd
006 65534 17243  8263  20   0  3940 1656 end    D    ?          0:00  \_
/usr/local/samba/bin/smbd
006 65534 17269  8263  20   0  3940 1640 end    D    ?          0:00  \_
/usr/local/samba/bin/smbd
006 65534 17285  8263  20   0  3940 1640 end    D    ?          0:00  \_
/usr/local/samba/bin/smbd
006 65534 17304  8263  20   0  3940 1732 end    D    ?          0:00  \_
/usr/local/samba/bin/smbd
006 65534 17333  8263  20   0  3940 1648 end    D    ?          0:00  \_
/usr/local/samba/bin/smbd
006 65534 17348  8263  20   0  3952 1660 end    D    ?          0:00  \_
/usr/local/samba/bin/smbd
006 65534 17362  8263  20   0  3948 1648 end    D    ?          0:00  \_
/usr/local/samba/bin/smbd
006     0 17377  8263  20   0  3980 2024 do_sel S    ?          0:01  \_
/usr/local/samba/bin/smbd
006 65534 17404  8263  20   0  3948 1676 end    D    ?          0:00  \_
/usr/local/samba/bin/smbd
006 65534 17429  8263  19   0  4040 2052 end    D    ?          0:00  \_
/usr/local/samba/bin/smbd
006 65534 17478  8263  20   0  3952 1644 end    D    ?          0:00  \_
/usr/local/samba/bin/smbd
006 65534 17526  8263  20   0  3956 1644 end    D    ?          0:00  \_
/usr/local/samba/bin/smbd
006 65534 17539  8263  19   0  3956 1644 end    D    ?          0:00  \_
/usr/local/samba/bin/smbd
006 65534 17552  8263   4   0  4216 2012 end    D    ?          0:04  \_
/usr/local/samba/bin/smbd

I am not sure, but it could cohere

hdr: dma_intr: status=0x61 { DriveReady DeviceFault Error }
hdr: dma_intr: error=0x04 { DriveStatusError }
hdr: DMA disabled
PDC202XX: Primary channel reset.
ide8: reset: master: error (0x7f?)
hdr: irq timeout: status=0xd0 { Busy }
PDC202XX: Primary channel reset.
ide8: reset: master: error (0x7f?)
end_request: I/O error, dev 5a:41 (hdr), sector 117462784
raid5: Disk failure on hdr1, disabling device. Operation continuing on 9
devices
end_request: I/O error, dev 5a:41 (hdr), sector 117462785
end_request: I/O error, dev 5a:41 (hdr), sector 117462786
end_request: I/O error, dev 5a:41 (hdr), sector 117462787
end_request: I/O error, dev 5a:41 (hdr), sector 117462788
end_request: I/O error, dev 5a:41 (hdr), sector 117462789
end_request: I/O error, dev 5a:41 (hdr), sector 117462790
end_request: I/O error, dev 5a:41 (hdr), sector 117462791
end_request: I/O error, dev 5a:41 (hdr), sector 117462792
end_request: I/O error, dev 5a:41 (hdr), sector 117462793
end_request: I/O error, dev 5a:41 (hdr), sector 117462794
end_request: I/O error, dev 5a:41 (hdr), sector 117462795
end_request: I/O error, dev 5a:41 (hdr), sector 117462796
end_request: I/O error, dev 5a:41 (hdr), sector 117462797
end_request: I/O error, dev 5a:41 (hdr), sector 117462798
end_request: I/O error, dev 5a:41 (hdr), sector 117462799
end_request: I/O error, dev 5a:41 (hdr), sector 117462800
end_request: I/O error, dev 5a:41 (hdr), sector 117462801
end_request: I/O error, dev 5a:41 (hdr), sector 117462802
end_request: I/O error, dev 5a:41 (hdr), sector 117462803
end_request: I/O error, dev 5a:41 (hdr), sector 117462804

# cat /proc/interrupts
           CPU0       CPU1
  0:    5840643          0    IO-APIC-edge  timer
  1:       1721          0    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:          2          0    IO-APIC-edge  rtc
 14:     135327          1    IO-APIC-edge  ide0
 16:          0          0   IO-APIC-level  usb-uhci
 18:          0          0   IO-APIC-level  usb-uhci
 19:          0          0   IO-APIC-level  usb-uhci
 28:   13877554          0   IO-APIC-level  eth0
 29:  137447983          0   IO-APIC-level  eth1
 48:   10514213          0   IO-APIC-level  ide2, ide3
 72:   10356963          0   IO-APIC-level  idea, ideb
 96:   10611024          0   IO-APIC-level  ide4, ide5
100:   10260137          0   IO-APIC-level  ide6, ide7
104:   10629337          0   IO-APIC-level  ide8, ide9
NMI:          0          0
LOC:    5840930    5841325
ERR:          0
MIS:          0

cat /proc/locks
1: POSIX  ADVISORY  READ  17859 03:06:142741 4 4 d6074d94 c033c094 d60749a4
00000000 d6074da0
2: POSIX  ADVISORY  READ  17859 03:06:142740 4 4 d60749a0 d6074d98 d60746c4
00000000 d60749ac
3: POSIX  ADVISORY  READ  17859 03:06:142739 4 4 d60746c0 d60749a4 d607460c
00000000 d60746cc
4: POSIX  ADVISORY  READ  17859 03:06:142738 4 4 d6074608 d60746c4 d6074ab8
00000000 d6074614
5: POSIX  ADVISORY  READ  17859 03:06:142737 4 4 d6074ab4 d607460c f128377c
00000000 d6074ac0
6: POSIX  ADVISORY  READ  17859 03:06:142736 4 4 f1283778 d6074ab8 d60745b0
00000000 f1283784
7: POSIX  ADVISORY  READ  17859 03:06:142735 4 4 d60745ac f128377c f1283104
00000000 d60745b8
8: POSIX  ADVISORY  READ  17859 03:06:116763 4 4 f1283100 d60745b0 f1283ce0
00000000 f128310c
9: POSIX  ADVISORY  READ  17859 03:06:142110 4 4 f1283cdc f1283104 f12838ec
00000000 f1283ce8
10: POSIX  ADVISORY  READ  17859 03:06:142734 4 4 f12838e8 f1283ce0 f1283274
00000000 f12838f4
11: POSIX  ADVISORY  READ  17844 03:06:142741 4 4 f1283270 f12838ec f1283bcc
d6074d94 f128327c
12: POSIX  ADVISORY  READ  17844 03:06:142740 4 4 f1283bc8 f1283274 f1283ab8
d60749a0 f1283bd4
13: POSIX  ADVISORY  READ  17844 03:06:142739 4 4 f1283ab4 f1283bcc f1283a00
d60746c0 f1283ac0
14: POSIX  ADVISORY  READ  17844 03:06:142738 4 4 f12839fc f1283ab8 f1283834
d6074608 f1283a08
15: POSIX  ADVISORY  READ  17844 03:06:142737 4 4 f1283830 f1283a00 f1283668
d6074ab4 f128383c
16: POSIX  ADVISORY  READ  17844 03:06:142736 4 4 f1283664 f1283834 f1283eac
f1283778 f1283670
17: POSIX  ADVISORY  READ  17844 03:06:142735 4 4 f1283ea8 f1283668 f1283948
d60745ac f1283eb4
18: POSIX  ADVISORY  READ  17844 03:06:116763 4 4 f1283944 f1283eac f1283d3c
f1283100 f1283950
19: POSIX  ADVISORY  READ  17844 03:06:142110 4 4 f1283d38 f1283948 f1283d98
f1283cdc f1283d44
20: POSIX  ADVISORY  READ  17844 03:06:142734 4 4 f1283d94 f1283d3c c89f0274
f12838e8 f1283da0
21: POSIX  ADVISORY  READ  17552 03:06:142741 4 4 c89f0270 f1283d98 f5b557d8
f1283270 c89f027c
22: POSIX  ADVISORY  READ  17552 03:06:142740 4 4 f5b557d4 c89f0274 d6074218
f1283bc8 f5b557e0
23: POSIX  ADVISORY  READ  17552 03:06:142739 4 4 d6074214 f5b557d8 d60748ec
f1283ab4 d6074220
24: POSIX  ADVISORY  READ  17552 03:06:142738 4 4 d60748e8 d6074218 c89f0f08
f12839fc d60748f4
25: POSIX  ADVISORY  READ  17552 03:06:142737 4 4 c89f0f04 d60748ec ce02e60c
f1283830 c89f0f10
26: POSIX  ADVISORY  READ  17552 03:06:142736 4 4 ce02e608 c89f0f08 d6074834
f1283664 ce02e614
27: POSIX  ADVISORY  READ  17552 03:06:142735 4 4 d6074830 ce02e60c f1283c84
f1283ea8 d607483c
28: POSIX  ADVISORY  READ  17552 03:06:116763 4 4 f1283c80 d6074834 ce02e388
f1283944 f1283c8c
29: POSIX  ADVISORY  READ  17552 03:06:142110 4 4 ce02e384 f1283c84 ce02e6c4
f1283d38 ce02e390
30: POSIX  ADVISORY  READ  17552 03:06:142734 4 4 ce02e6c0 ce02e388 c89f0668
f1283d94 ce02e6cc
31: POSIX  ADVISORY  READ  17539 03:06:142741 4 4 c89f0664 ce02e6c4 c89f06c4
c89f0270 c89f0670
32: POSIX  ADVISORY  READ  17539 03:06:142740 4 4 c89f06c0 c89f0668 c89f07d8
f5b557d4 c89f06cc
33: POSIX  ADVISORY  READ  17539 03:06:142739 4 4 c89f07d4 c89f06c4 c89f0b70
d6074214 c89f07e0
34: POSIX  ADVISORY  READ  17539 03:06:142738 4 4 c89f0b6c c89f07d8 c89f0890
d60748e8 c89f0b78
35: POSIX  ADVISORY  READ  17539 03:06:142737 4 4 c89f088c c89f0b70 c89f0c28
c89f0f04 c89f0898
36: POSIX  ADVISORY  READ  17539 03:06:142736 4 4 c89f0c24 c89f0890 c89f0720
ce02e608 c89f0c30
37: POSIX  ADVISORY  READ  17539 03:06:142735 4 4 c89f071c c89f0c28 f5b55218
d6074830 c89f0728
38: POSIX  ADVISORY  READ  17539 03:06:116763 4 4 f5b55214 c89f0720 c89f0e50
f1283c80 f5b55220
39: POSIX  ADVISORY  READ  17539 03:06:142110 4 4 c89f0e4c f5b55218 c89f0218
ce02e384 c89f0e58
40: POSIX  ADVISORY  READ  17539 03:06:142734 4 4 c89f0214 c89f0e50 d607449c
ce02e6c0 c89f0220
41: POSIX  ADVISORY  READ  17526 03:06:142741 4 4 d6074498 c89f0218 d6074440
c89f0664 d60744a4
42: POSIX  ADVISORY  READ  17526 03:06:142740 4 4 d607443c d607449c d6074388
c89f06c0 d6074448
43: POSIX  ADVISORY  READ  17526 03:06:142739 4 4 d6074384 d6074440 d60743e4
c89f07d4 d6074390
44: POSIX  ADVISORY  READ  17526 03:06:142738 4 4 d60743e0 d6074388 d607432c
c89f0b6c d60743ec
45: POSIX  ADVISORY  READ  17526 03:06:142737 4 4 d6074328 d60743e4 d6074274
c89f088c d6074334
46: POSIX  ADVISORY  READ  17526 03:06:142736 4 4 d6074270 d607432c d60742d0
c89f0c24 d607427c
47: POSIX  ADVISORY  READ  17526 03:06:142735 4 4 d60742cc d6074274 d6074104
c89f071c d60742d8
48: POSIX  ADVISORY  READ  17526 03:06:116763 4 4 d6074100 d60742d0 d6074160
f5b55214 d607410c
49: POSIX  ADVISORY  READ  17526 03:06:142110 4 4 d607415c d6074104 d60741bc
c89f0e4c d6074168
50: POSIX  ADVISORY  READ  17526 03:06:142734 4 4 d60741b8 d6074160 c89f08ec
c89f0214 d60741c4
51: POSIX  ADVISORY  READ  17478 03:06:142741 4 4 c89f08e8 d60741bc c89f0948
d6074498 c89f08f4
52: POSIX  ADVISORY  READ  17478 03:06:142740 4 4 c89f0944 c89f08ec c89f0a00
d607443c c89f0950
53: POSIX  ADVISORY  READ  17478 03:06:142739 4 4 c89f09fc c89f0948 c89f09a4
d6074384 c89f0a08
54: POSIX  ADVISORY  READ  17478 03:06:142738 4 4 c89f09a0 c89f0a00 c89f0a5c
d60743e0 c89f09ac
55: POSIX  ADVISORY  READ  17478 03:06:142737 4 4 c89f0a58 c89f09a4 c89f0d3c
d6074328 c89f0a64
56: POSIX  ADVISORY  READ  17478 03:06:142736 4 4 c89f0d38 c89f0a5c c89f0bcc
d6074270 c89f0d44
57: POSIX  ADVISORY  READ  17478 03:06:142735 4 4 c89f0bc8 c89f0d3c f5b55ce0
d60742cc c89f0bd4
58: POSIX  ADVISORY  READ  17478 03:06:116763 4 4 f5b55cdc c89f0bcc c89f0ab8
d6074100 f5b55ce8
59: POSIX  ADVISORY  READ  17478 03:06:142110 4 4 c89f0ab4 f5b55ce0 f5b55b14
d607415c c89f0ac0
60: POSIX  ADVISORY  READ  17478 03:06:142734 4 4 f5b55b10 c89f0ab8 f5b55f08
d60741b8 f5b55b1c
61: POSIX  ADVISORY  READ  17429 03:06:142741 4 4 f5b55f04 f5b55b14 f5b55e50
c89f08e8 f5b55f10
62: POSIX  ADVISORY  READ  17429 03:06:142740 4 4 f5b55e4c f5b55f08 c25fd6c4
c89f0944 f5b55e58
63: POSIX  ADVISORY  READ  17429 03:06:142739 4 4 c25fd6c0 f5b55e50 c25fd32c
c89f09fc c25fd6cc
64: POSIX  ADVISORY  READ  17429 03:06:142738 4 4 c25fd328 c25fd6c4 c25fd388
c89f09a0 c25fd334
65: POSIX  ADVISORY  READ  17429 03:06:142737 4 4 c25fd384 c25fd32c d432ace0
c89f0a58 c25fd390
66: POSIX  ADVISORY  READ  17429 03:06:142736 4 4 d432acdc c25fd388 c25fd948
c89f0d38 d432ace8
67: POSIX  ADVISORY  READ  17429 03:06:142735 4 4 c25fd944 d432ace0 c25fdab8
c89f0bc8 c25fd950
68: POSIX  ADVISORY  READ  17429 03:06:116763 4 4 c25fdab4 c25fd948 c25fd77c
f5b55cdc c25fdac0
69: POSIX  ADVISORY  READ  17429 03:06:142110 4 4 c25fd778 c25fdab8 c25fdbcc
c89f0ab4 c25fd784
70: POSIX  ADVISORY  READ  17429 03:06:142734 4 4 c25fdbc8 c25fd77c c25fdf08
f5b55b10 c25fdbd4
71: POSIX  ADVISORY  READ  17404 03:06:142741 4 4 c25fdf04 c25fdbcc c25fd104
f5b55f04 c25fdf10
72: POSIX  ADVISORY  READ  17404 03:06:142740 4 4 c25fd100 c25fdf08 c25fda5c
f5b55e4c c25fd10c
73: POSIX  ADVISORY  READ  17404 03:06:142739 4 4 c25fda58 c25fd104 c25fd218
c25fd6c0 c25fda64
74: POSIX  ADVISORY  READ  17404 03:06:142738 4 4 c25fd214 c25fda5c c25fd440
c25fd328 c25fd220
75: POSIX  ADVISORY  READ  17404 03:06:142737 4 4 c25fd43c c25fd218 d432ab14
c25fd384 c25fd448
76: POSIX  ADVISORY  READ  17404 03:06:142736 4 4 d432ab10 c25fd440 dad3b554
d432acdc d432ab1c
77: POSIX  ADVISORY  READ  17404 03:06:142735 4 4 dad3b550 d432ab14 c466fdf4
c25fd944 dad3b55c
78: POSIX  ADVISORY  READ  17404 03:06:116763 4 4 c466fdf0 dad3b554 c466fc28
c25fdab4 c466fdfc
79: POSIX  ADVISORY  READ  17404 03:06:142110 4 4 c466fc24 c466fdf4 c466fce0
c25fd778 c466fc30
80: POSIX  ADVISORY  READ  17404 03:06:142734 4 4 c466fcdc c466fc28 d6074b70
c25fdbc8 c466fce8
81: POSIX  ADVISORY  READ  17377 03:06:142741 4 4 d6074b6c c466fce0 d6074bcc
c25fdf04 d6074b78
82: POSIX  ADVISORY  READ  17377 03:06:142740 4 4 d6074bc8 d6074b70 d6074c84
c25fd100 d6074bd4
83: POSIX  ADVISORY  READ  17377 03:06:142739 4 4 d6074c80 d6074bcc d6074c28
c25fda58 d6074c8c
84: POSIX  ADVISORY  READ  17377 03:06:142738 4 4 d6074c24 d6074c84 d6074ce0
c25fd214 d6074c30
85: POSIX  ADVISORY  READ  17377 03:06:142737 4 4 d6074cdc d6074c28 d6074df4
c25fd43c d6074ce8
86: POSIX  ADVISORY  READ  17377 03:06:142736 4 4 d6074df0 d6074ce0 d6074d3c
d432ab10 d6074dfc
87: POSIX  ADVISORY  READ  17377 03:06:142735 4 4 d6074d38 d6074df4 d6074f08
dad3b550 d6074d44
88: POSIX  ADVISORY  READ  17377 03:06:116763 4 4 d6074f04 d6074d3c d6074eac
c466fdf0 d6074f10
89: POSIX  ADVISORY  READ  17377 03:06:142110 4 4 d6074ea8 d6074f08 d6074e50
c466fc24 d6074eb4
90: POSIX  ADVISORY  READ  17377 03:06:142734 4 4 d6074e4c d6074eac f18cf554
c466fcdc d6074e58
91: POSIX  ADVISORY  READ  17362 03:06:142741 4 4 f18cf550 d6074e50 f18cf5b0
d6074b6c f18cf55c
92: POSIX  ADVISORY  READ  17362 03:06:142740 4 4 f18cf5ac f18cf554 f18cf668
d6074bc8 f18cf5b8
93: POSIX  ADVISORY  READ  17362 03:06:142739 4 4 f18cf664 f18cf5b0 f18cf60c
d6074c80 f18cf670
94: POSIX  ADVISORY  READ  17362 03:06:142738 4 4 f18cf608 f18cf668 f18cf6c4
d6074c24 f18cf614
95: POSIX  ADVISORY  READ  17362 03:06:142737 4 4 f18cf6c0 f18cf60c f18cf890
d6074cdc f18cf6cc
96: POSIX  ADVISORY  READ  17362 03:06:142736 4 4 f18cf88c f18cf6c4 f18cf720
d6074df0 f18cf898
97: POSIX  ADVISORY  READ  17362 03:06:142735 4 4 f18cf71c f18cf890 f18cf77c
d6074d38 f18cf728
98: POSIX  ADVISORY  READ  17362 03:06:116763 4 4 f18cf778 f18cf720 f18cf948
d6074f04 f18cf784
99: POSIX  ADVISORY  READ  17362 03:06:142110 4 4 f18cf944 f18cf77c f18cf7d8
d6074ea8 f18cf950
100: POSIX  ADVISORY  READ  17362 03:06:142734 4 4 f18cf7d4 f18cf948
f18cfce0 d6074e4c f18cf7e0
101: POSIX  ADVISORY  READ  17348 03:06:142741 4 4 f18cfcdc f18cf7d8
c6e5a77c f18cf550 f18cfce8
102: POSIX  ADVISORY  READ  17348 03:06:142740 4 4 c6e5a778 f18cfce0
f18cfb70 f18cf5ac c6e5a784
103: POSIX  ADVISORY  READ  17348 03:06:142739 4 4 f18cfb6c c6e5a77c
f18cfc28 f18cf664 f18cfb78
104: POSIX  ADVISORY  READ  17348 03:06:142738 4 4 f18cfc24 f18cfb70
f18cfab8 f18cf608 f18cfc30
105: POSIX  ADVISORY  READ  17348 03:06:142737 4 4 f18cfab4 f18cfc28
f5b55834 f18cf6c0 f18cfac0
106: POSIX  ADVISORY  READ  17348 03:06:142736 4 4 f5b55830 f18cfab8
c25fd8ec f18cf88c f5b5583c
107: POSIX  ADVISORY  READ  17348 03:06:142735 4 4 c25fd8e8 f5b55834
f2e428ec f18cf71c c25fd8f4
108: POSIX  ADVISORY  READ  17348 03:06:116763 4 4 f2e428e8 c25fd8ec
f2e42a00 f18cf778 f2e428f4
109: POSIX  ADVISORY  READ  17348 03:06:142110 4 4 f2e429fc f2e428ec
f5b5532c f18cf944 f2e42a08
110: POSIX  ADVISORY  READ  17348 03:06:142734 4 4 f5b55328 f2e42a00
f5b55668 f18cf7d4 f5b55334
111: POSIX  ADVISORY  READ  17333 03:06:142741 4 4 f5b55664 f5b5532c
f5b55c28 f18cfcdc f5b55670
112: POSIX  ADVISORY  READ  17333 03:06:142740 4 4 f5b55c24 f5b55668
f5b5560c c6e5a778 f5b55c30
113: POSIX  ADVISORY  READ  17333 03:06:142739 4 4 f5b55608 f5b55c28
f5b555b0 f18cfb6c f5b55614
114: POSIX  ADVISORY  READ  17333 03:06:142738 4 4 f5b555ac f5b5560c
f5b5577c f18cfc24 f5b555b8
115: POSIX  ADVISORY  READ  17333 03:06:142737 4 4 f5b55778 f5b555b0
f5b55104 f18cfab4 f5b55784
116: POSIX  ADVISORY  READ  17333 03:06:142736 4 4 f5b55100 f5b5577c
f5b55ab8 f5b55830 f5b5510c
117: POSIX  ADVISORY  READ  17333 03:06:142735 4 4 f5b55ab4 f5b55104
f5b55bcc c25fd8e8 f5b55ac0
118: POSIX  ADVISORY  READ  17333 03:06:116763 4 4 f5b55bc8 f5b55ab8
f5b55274 f2e428e8 f5b55bd4
119: POSIX  ADVISORY  READ  17333 03:06:142110 4 4 f5b55270 f5b55bcc
f5b55a00 f2e429fc f5b5527c
120: POSIX  ADVISORY  READ  17333 03:06:142734 4 4 f5b559fc f5b55274
c6e5ad98 f5b55328 f5b55a08
121: POSIX  ADVISORY  READ  17304 03:06:142741 4 4 c6e5ad94 f5b55a00
c25fda00 f5b55664 c6e5ada0
122: POSIX  ADVISORY  READ  17304 03:06:142740 4 4 c25fd9fc c6e5ad98
f2e42b14 f5b55c24 c25fda08
123: POSIX  ADVISORY  READ  17304 03:06:142739 4 4 f2e42b10 c25fda00
c25fdb70 f5b55608 f2e42b1c
124: POSIX  ADVISORY  READ  17304 03:06:142738 4 4 c25fdb6c f2e42b14
c25fd668 f5b555ac c25fdb78
125: POSIX  ADVISORY  READ  17304 03:06:142737 4 4 c25fd664 c25fdb70
c6e5ae50 f5b55778 c25fd670
126: POSIX  ADVISORY  READ  17304 03:06:142736 4 4 c6e5ae4c c25fd668
f2e42668 f5b55100 c6e5ae58
127: POSIX  ADVISORY  READ  17304 03:06:142735 4 4 f2e42664 c6e5ae50
c6e5aab8 f5b55ab4 f2e42670
128: POSIX  ADVISORY  READ  17304 03:06:116763 4 4 c6e5aab4 f2e42668
c6e5a49c f5b55bc8 c6e5aac0
129: POSIX  ADVISORY  READ  17304 03:06:142110 4 4 c6e5a498 c6e5aab8
f5b552d0 f5b55270 c6e5a4a4
130: POSIX  ADVISORY  READ  17304 03:06:142734 4 4 f5b552cc c6e5a49c
f2e425b0 f5b559fc f5b552d8
131: POSIX  ADVISORY  READ  17285 03:06:142741 4 4 f2e425ac f5b552d0
f2e42554 c6e5ad94 f2e425b8
132: POSIX  ADVISORY  READ  17285 03:06:142740 4 4 f2e42550 f2e425b0
f2e4249c c25fd9fc f2e4255c
133: POSIX  ADVISORY  READ  17285 03:06:142739 4 4 f2e42498 f2e42554
f2e424f8 f2e42b10 f2e424a4
134: POSIX  ADVISORY  READ  17285 03:06:142738 4 4 f2e424f4 f2e4249c
f2e42440 c25fdb6c f2e42500
135: POSIX  ADVISORY  READ  17285 03:06:142737 4 4 f2e4243c f2e424f8
f2e421bc c25fd664 f2e42448
136: POSIX  ADVISORY  READ  17285 03:06:142736 4 4 f2e421b8 f2e42440
f2e42274 c6e5ae4c f2e421c4
137: POSIX  ADVISORY  READ  17285 03:06:142735 4 4 f2e42270 f2e421bc
f2e42104 f2e42664 f2e4227c
138: POSIX  ADVISORY  READ  17285 03:06:116763 4 4 f2e42100 f2e42274
f2e42160 c6e5aab4 f2e4210c
139: POSIX  ADVISORY  READ  17285 03:06:142110 4 4 f2e4215c f2e42104
dad3b8ec c6e5a498 f2e42168
140: POSIX  ADVISORY  READ  17285 03:06:142734 4 4 dad3b8e8 f2e42160
f2e4232c f5b552cc dad3b8f4
141: POSIX  ADVISORY  READ  17269 03:06:142741 4 4 f2e42328 dad3b8ec
f2e42218 f2e425ac f2e42334
142: POSIX  ADVISORY  READ  17269 03:06:142740 4 4 f2e42214 f2e4232c
c1f0ea5c f2e42550 f2e42220
143: POSIX  ADVISORY  READ  17269 03:06:142739 4 4 c1f0ea58 f2e42218
f2e42eac f2e42498 c1f0ea64
144: POSIX  ADVISORY  READ  17269 03:06:142738 4 4 f2e42ea8 c1f0ea5c
dad3bb70 f2e424f4 f2e42eb4
145: POSIX  ADVISORY  READ  17269 03:06:142737 4 4 dad3bb6c f2e42eac
dad3bce0 f2e4243c dad3bb78
146: POSIX  ADVISORY  READ  17269 03:06:142736 4 4 dad3bcdc dad3bb70
dad3b720 f2e421b8 dad3bce8
147: POSIX  ADVISORY  READ  17269 03:06:142735 4 4 dad3b71c dad3bce0
c466f440 f2e42270 dad3b728
148: POSIX  ADVISORY  READ  17269 03:06:116763 4 4 c466f43c dad3b720
dad3b32c f2e42100 c466f448
149: POSIX  ADVISORY  READ  17269 03:06:142110 4 4 dad3b328 c466f440
dad3b948 f2e4215c dad3b334
150: POSIX  ADVISORY  READ  17269 03:06:142734 4 4 dad3b944 dad3b32c
c466f8ec dad3b8e8 dad3b950
151: POSIX  ADVISORY  READ  17243 03:06:142741 4 4 c466f8e8 dad3b948
c466f6c4 f2e42328 c466f8f4
152: POSIX  ADVISORY  READ  17243 03:06:142740 4 4 c466f6c0 c466f8ec
c466fa5c f2e42214 c466f6cc
153: POSIX  ADVISORY  READ  17243 03:06:142739 4 4 c466fa58 c466f6c4
c466fb14 c1f0ea58 c466fa64
154: POSIX  ADVISORY  READ  17243 03:06:142738 4 4 c466fb10 c466fa5c
c466f32c f2e42ea8 c466fb1c
155: POSIX  ADVISORY  READ  17243 03:06:142737 4 4 c466f328 c466fb14
c466f7d8 dad3bb6c c466f334
156: POSIX  ADVISORY  READ  17243 03:06:142736 4 4 c466f7d4 c466f32c
c466fe50 dad3bcdc c466f7e0
157: POSIX  ADVISORY  READ  17243 03:06:142735 4 4 c466fe4c c466f7d8
c466f104 dad3b71c c466fe58
158: POSIX  ADVISORY  READ  17243 03:06:116763 4 4 c466f100 c466fe50
c466fbcc c466f43c c466f10c
159: POSIX  ADVISORY  READ  17243 03:06:142110 4 4 c466fbc8 c466f104
c466ff08 dad3b328 c466fbd4
160: POSIX  ADVISORY  READ  17243 03:06:142734 4 4 c466ff04 c466fbcc
c6e5a948 dad3b944 c466ff10
161: POSIX  ADVISORY  READ  17207 03:06:142741 4 4 c6e5a944 c466ff08
c6e5af08 c466f8e8 c6e5a950
162: POSIX  ADVISORY  READ  17207 03:06:142740 4 4 c6e5af04 c6e5a948
c6e5a104 c466f6c0 c6e5af10
163: POSIX  ADVISORY  READ  17207 03:06:142739 4 4 c6e5a100 c6e5af08
c6e5a388 c466fa58 c6e5a10c
164: POSIX  ADVISORY  READ  17207 03:06:142738 4 4 c6e5a384 c6e5a104
f5b5549c c466fb10 c6e5a390
165: POSIX  ADVISORY  READ  17207 03:06:142737 4 4 f5b55498 c6e5a388
dad3b3e4 c466f328 f5b554a4
166: POSIX  ADVISORY  READ  17207 03:06:142736 4 4 dad3b3e0 f5b5549c
c6e5a3e4 c466f7d4 dad3b3ec
167: POSIX  ADVISORY  READ  17207 03:06:142735 4 4 c6e5a3e0 dad3b3e4
c466f668 c466fe4c c6e5a3ec
168: POSIX  ADVISORY  READ  17207 03:06:116763 4 4 c466f664 c6e5a3e4
f2e423e4 c466f100 c466f670
169: POSIX  ADVISORY  READ  17207 03:06:142110 4 4 f2e423e0 c466f668
f2e422d0 c466fbc8 f2e423ec
170: POSIX  ADVISORY  READ  17207 03:06:142734 4 4 f2e422cc f2e423e4
c25fdc84 c466ff04 f2e422d8
171: POSIX  ADVISORY  READ  17192 03:06:142741 4 4 c25fdc80 f2e422d0
c25fdd3c c6e5a944 c25fdc8c
172: POSIX  ADVISORY  READ  17192 03:06:142740 4 4 c25fdd38 c25fdc84
c25fd274 c6e5af04 c25fdd44
173: POSIX  ADVISORY  READ  17192 03:06:142739 4 4 c25fd270 c25fdd3c
c25fd720 c6e5a100 c25fd27c
174: POSIX  ADVISORY  READ  17192 03:06:142738 4 4 c25fd71c c25fd274
c25fd49c c6e5a384 c25fd728
175: POSIX  ADVISORY  READ  17192 03:06:142737 4 4 c25fd498 c25fd720
c1f0e8ec f5b55498 c25fd4a4
176: POSIX  ADVISORY  READ  17192 03:06:142736 4 4 c1f0e8e8 c25fd49c
c25fddf4 dad3b3e0 c1f0e8f4
177: POSIX  ADVISORY  READ  17192 03:06:142735 4 4 c25fddf0 c1f0e8ec
c1f0ebcc c6e5a3e0 c25fddfc
178: POSIX  ADVISORY  READ  17192 03:06:116763 4 4 c1f0ebc8 c25fddf4
c25fd60c c466f664 c1f0ebd4
179: POSIX  ADVISORY  READ  17192 03:06:142110 4 4 c25fd608 c1f0ebcc
c1f0e104 f2e423e0 c25fd614
180: POSIX  ADVISORY  READ  17192 03:06:142734 4 4 c1f0e100 c25fd60c
c6e5a9a4 f2e422cc c1f0e10c
181: POSIX  ADVISORY  READ  17177 03:06:142741 4 4 c6e5a9a0 c1f0e104
f5b55720 c25fdc80 c6e5a9ac
182: POSIX  ADVISORY  READ  17177 03:06:142740 4 4 f5b5571c c6e5a9a4
c6e5a720 c25fdd38 f5b55728
183: POSIX  ADVISORY  READ  17177 03:06:142739 4 4 c6e5a71c f5b55720
c6e5a668 c25fd270 c6e5a728
184: POSIX  ADVISORY  READ  17177 03:06:142738 4 4 c6e5a664 c6e5a720
c6e5a890 c25fd71c c6e5a670
185: POSIX  ADVISORY  READ  17177 03:06:142737 4 4 c6e5a88c c6e5a668
c1f0e7d8 c25fd498 c6e5a898
186: POSIX  ADVISORY  READ  17177 03:06:142736 4 4 c1f0e7d4 c6e5a890
c1f0e218 c1f0e8e8 c1f0e7e0
187: POSIX  ADVISORY  READ  17177 03:06:142735 4 4 c1f0e214 c1f0e7d8
c1f0e274 c25fddf0 c1f0e220
188: POSIX  ADVISORY  READ  17177 03:06:116763 4 4 c1f0e270 c1f0e218
c1f0ec28 c1f0ebc8 c1f0e27c
189: POSIX  ADVISORY  READ  17177 03:06:142110 4 4 c1f0ec24 c1f0e274
c1f0e60c c25fd608 c1f0ec30
190: POSIX  ADVISORY  READ  17177 03:06:142734 4 4 c1f0e608 c1f0ec28
dad3b834 c1f0e100 c1f0e614
191: POSIX  ADVISORY  READ  17162 03:06:142741 4 4 dad3b830 c1f0e60c
dad3bbcc c6e5a9a0 dad3b83c
192: POSIX  ADVISORY  READ  17162 03:06:142740 4 4 dad3bbc8 dad3b834
dad3b5b0 f5b5571c dad3bbd4
193: POSIX  ADVISORY  READ  17162 03:06:142739 4 4 dad3b5ac dad3bbcc
dad3b890 c6e5a71c dad3b5b8
194: POSIX  ADVISORY  READ  17162 03:06:142738 4 4 dad3b88c dad3b5b0
dad3b104 c6e5a664 dad3b898
195: POSIX  ADVISORY  READ  17162 03:06:142737 4 4 dad3b100 dad3b890
dad3bc84 c6e5a88c dad3b10c
196: POSIX  ADVISORY  READ  17162 03:06:142736 4 4 dad3bc80 dad3b104
dad3bab8 c1f0e7d4 dad3bc8c
197: POSIX  ADVISORY  READ  17162 03:06:142735 4 4 dad3bab4 dad3bc84
dad3b77c c1f0e214 dad3bac0
198: POSIX  ADVISORY  READ  17162 03:06:116763 4 4 dad3b778 dad3bab8
dad3ba5c c1f0e270 dad3b784
199: POSIX  ADVISORY  READ  17162 03:06:142110 4 4 dad3ba58 dad3b77c
dad3ba00 c1f0ec24 dad3ba64
200: POSIX  ADVISORY  READ  17162 03:06:142734 4 4 dad3b9fc dad3ba5c
dad3b4f8 c1f0e608 dad3ba08
201: POSIX  ADVISORY  READ  17132 03:06:142741 4 4 dad3b4f4 dad3ba00
c1f0e49c dad3b830 dad3b500
202: POSIX  ADVISORY  READ  17132 03:06:142740 4 4 c1f0e498 dad3b4f8
c1f0e554 dad3bbc8 c1f0e4a4
203: POSIX  ADVISORY  READ  17132 03:06:142739 4 4 c1f0e550 c1f0e49c
c1f0e3e4 dad3b5ac c1f0e55c
204: POSIX  ADVISORY  READ  17132 03:06:142738 4 4 c1f0e3e0 c1f0e554
c1f0ee50 dad3b88c c1f0e3ec
205: POSIX  ADVISORY  READ  17132 03:06:142737 4 4 c1f0ee4c c1f0e3e4
dad3b6c4 dad3b100 c1f0ee58
206: POSIX  ADVISORY  READ  17132 03:06:142736 4 4 dad3b6c0 c1f0ee50
dad3b160 dad3bc80 dad3b6cc
207: POSIX  ADVISORY  READ  17132 03:06:142735 4 4 dad3b15c dad3b6c4
c25fd160 dad3bab4 dad3b168
208: POSIX  ADVISORY  READ  17132 03:06:116763 4 4 c25fd15c dad3b160
dad3b274 dad3b778 c25fd168
209: POSIX  ADVISORY  READ  17132 03:06:142110 4 4 dad3b270 c25fd160
dad3bc28 dad3ba58 dad3b27c
210: POSIX  ADVISORY  READ  17132 03:06:142734 4 4 dad3bc24 dad3b274
c6e5a6c4 dad3b9fc dad3bc30
211: POSIX  ADVISORY  READ  17047 03:06:142741 4 4 c6e5a6c0 dad3bc28
c6e5a4f8 dad3b4f4 c6e5a6cc
212: POSIX  ADVISORY  READ  17047 03:06:142740 4 4 c6e5a4f4 c6e5a6c4
dad3bb14 c1f0e498 c6e5a500
213: POSIX  ADVISORY  READ  17047 03:06:142739 4 4 dad3bb10 c6e5a4f8
dad3bf64 c1f0e550 dad3bb1c
214: POSIX  ADVISORY  READ  17047 03:06:142738 4 4 dad3bf60 dad3bb14
dad3b2d0 c1f0e3e0 dad3bf6c
215: POSIX  ADVISORY  READ  17047 03:06:142737 4 4 dad3b2cc dad3bf64
c6e5aa00 c1f0ee4c dad3b2d8
216: POSIX  ADVISORY  READ  17047 03:06:142736 4 4 c6e5a9fc dad3b2d0
dad3bd98 dad3b6c0 c6e5aa08
217: POSIX  ADVISORY  READ  17047 03:06:142735 4 4 dad3bd94 c6e5aa00
dad3bd3c dad3b15c dad3bda0
218: POSIX  ADVISORY  READ  17047 03:06:116763 4 4 dad3bd38 dad3bd98
c6e5a218 c25fd15c dad3bd44
219: POSIX  ADVISORY  READ  17047 03:06:142110 4 4 c6e5a214 dad3bd3c
c6e5a7d8 dad3b270 c6e5a220
220: POSIX  ADVISORY  READ  17047 03:06:142734 4 4 c6e5a7d4 c6e5a218
c6e5ace0 dad3bc24 c6e5a7e0
221: POSIX  ADVISORY  READ  17032 03:06:142741 4 4 c6e5acdc c6e5a7d8
c6e5ad3c c6e5a6c0 c6e5ace8
222: POSIX  ADVISORY  READ  17032 03:06:142740 4 4 c6e5ad38 c6e5ace0
c6e5abcc c6e5a4f4 c6e5ad44
223: POSIX  ADVISORY  READ  17032 03:06:142739 4 4 c6e5abc8 c6e5ad3c
c6e5af64 dad3bb10 c6e5abd4
224: POSIX  ADVISORY  READ  17032 03:06:142738 4 4 c6e5af60 c6e5abcc
c6e5adf4 dad3bf60 c6e5af6c
225: POSIX  ADVISORY  READ  17032 03:06:142737 4 4 c6e5adf0 c6e5af64
c6e5ab14 dad3b2cc c6e5adfc
226: POSIX  ADVISORY  READ  17032 03:06:142736 4 4 c6e5ab10 c6e5adf4
c6e5aa5c c6e5a9fc c6e5ab1c
227: POSIX  ADVISORY  READ  17032 03:06:142735 4 4 c6e5aa58 c6e5ab14
c6e5ac28 dad3bd94 c6e5aa64
228: POSIX  ADVISORY  READ  17032 03:06:116763 4 4 c6e5ac24 c6e5aa5c
c6e5ab70 dad3bd38 c6e5ac30
229: POSIX  ADVISORY  READ  17032 03:06:142110 4 4 c6e5ab6c c6e5ac28
c6e5ac84 c6e5a214 c6e5ab78
230: POSIX  ADVISORY  READ  17032 03:06:142734 4 4 c6e5ac80 c6e5ab70
f5b55440 c6e5a7d4 c6e5ac8c
231: POSIX  ADVISORY  READ  17018 03:06:142741 4 4 f5b5543c c6e5ac84
f5b55554 c6e5acdc f5b55448
232: POSIX  ADVISORY  READ  17018 03:06:142740 4 4 f5b55550 f5b55440
f5b55df4 c6e5ad38 f5b5555c
233: POSIX  ADVISORY  READ  17018 03:06:142739 4 4 f5b55df0 f5b55554
f5b55c84 c6e5abc8 f5b55dfc
234: POSIX  ADVISORY  READ  17018 03:06:142738 4 4 f5b55c80 f5b55df4
f5b55388 c6e5af60 f5b55c8c
235: POSIX  ADVISORY  READ  17018 03:06:142737 4 4 f5b55384 f5b55c84
d432a388 c6e5adf0 f5b55390
236: POSIX  ADVISORY  READ  17018 03:06:142736 4 4 d432a384 f5b55388
f5b556c4 c6e5ab10 d432a390
237: POSIX  ADVISORY  READ  17018 03:06:142735 4 4 f5b556c0 d432a388
d432ae50 c6e5aa58 f5b556cc
238: POSIX  ADVISORY  READ  17018 03:06:116763 4 4 d432ae4c f5b556c4
d432a160 c6e5ac24 d432ae58
239: POSIX  ADVISORY  READ  17018 03:06:142110 4 4 d432a15c d432ae50
d432a2d0 c6e5ab6c d432a168
240: POSIX  ADVISORY  READ  17018 03:06:142734 4 4 d432a2cc d432a160
c1f0e4f8 c6e5ac80 d432a2d8
241: POSIX  ADVISORY  READ  16953 03:06:142741 4 4 c1f0e4f4 d432a2d0
c1f0edf4 f5b5543c c1f0e500
242: POSIX  ADVISORY  READ  16953 03:06:142740 4 4 c1f0edf0 c1f0e4f8
c1f0ea00 f5b55550 c1f0edfc
243: POSIX  ADVISORY  READ  16953 03:06:142739 4 4 c1f0e9fc c1f0edf4
c1f0ef08 f5b55df0 c1f0ea08
244: POSIX  ADVISORY  READ  16953 03:06:142738 4 4 c1f0ef04 c1f0ea00
c1f0e2d0 f5b55c80 c1f0ef10
245: POSIX  ADVISORY  READ  16953 03:06:142737 4 4 c1f0e2cc c1f0ef08
c1f0e834 f5b55384 c1f0e2d8
246: POSIX  ADVISORY  READ  16953 03:06:142736 4 4 c1f0e830 c1f0e2d0
c1f0ed3c d432a384 c1f0e83c
247: POSIX  ADVISORY  READ  16953 03:06:142735 4 4 c1f0ed38 c1f0e834
c1f0ec84 f5b556c0 c1f0ed44
248: POSIX  ADVISORY  READ  16953 03:06:116763 4 4 c1f0ec80 c1f0ed3c
c1f0eab8 d432ae4c c1f0ec8c
249: POSIX  ADVISORY  READ  16953 03:06:142110 4 4 c1f0eab4 c1f0ec84
c1f0e9a4 d432a15c c1f0eac0
250: POSIX  ADVISORY  READ  16953 03:06:142734 4 4 c1f0e9a0 c1f0eab8
d432a6c4 d432a2cc c1f0e9ac
251: POSIX  ADVISORY  READ  16939 03:06:142741 4 4 d432a6c0 c1f0e9a4
d432ad3c c1f0e4f4 d432a6cc
252: POSIX  ADVISORY  READ  16939 03:06:142740 4 4 d432ad38 d432a6c4
d432a274 c1f0edf0 d432ad44
253: POSIX  ADVISORY  READ  16939 03:06:142739 4 4 d432a270 d432ad3c
d432a5b0 c1f0e9fc d432a27c
254: POSIX  ADVISORY  READ  16939 03:06:142738 4 4 d432a5ac d432a274
d432a440 c1f0ef04 d432a5b8
255: POSIX  ADVISORY  READ  16939 03:06:142737 4 4 d432a43c d432a5b0
d432aeac c1f0e2cc d432a448
256: POSIX  ADVISORY  READ  16939 03:06:142736 4 4 d432aea8 d432a440
d432a554 c1f0e830 d432aeb4
257: POSIX  ADVISORY  READ  16939 03:06:142735 4 4 d432a550 d432aeac
c25fdce0 c1f0ed38 d432a55c
258: POSIX  ADVISORY  READ  16939 03:06:116763 4 4 c25fdcdc d432a554
d432af64 c1f0ec80 c25fdce8
259: POSIX  ADVISORY  READ  16939 03:06:142110 4 4 d432af60 c25fdce0
d432ad98 c1f0eab4 d432af6c
260: POSIX  ADVISORY  READ  16939 03:06:142734 4 4 d432ad94 d432af64
c1f0e160 c1f0e9a0 d432ada0
261: POSIX  ADVISORY  READ  16924 03:06:142741 4 4 c1f0e15c d432ad98
c1f0e948 d432a6c0 c1f0e168
262: POSIX  ADVISORY  READ  16924 03:06:142740 4 4 c1f0e944 c1f0e160
c1f0e77c d432ad38 c1f0e950
263: POSIX  ADVISORY  READ  16924 03:06:142739 4 4 c1f0e778 c1f0e948
c1f0e6c4 d432a270 c1f0e784
264: POSIX  ADVISORY  READ  16924 03:06:142738 4 4 c1f0e6c0 c1f0e77c
c1f0e440 d432a5ac c1f0e6cc
265: POSIX  ADVISORY  READ  16924 03:06:142737 4 4 c1f0e43c c1f0e6c4
c1f0eb70 d432a43c c1f0e448
266: POSIX  ADVISORY  READ  16924 03:06:142736 4 4 c1f0eb6c c1f0e440
c1f0e388 d432aea8 c1f0eb78
267: POSIX  ADVISORY  READ  16924 03:06:142735 4 4 c1f0e384 c1f0eb70
c1f0e5b0 d432a550 c1f0e390
268: POSIX  ADVISORY  READ  16924 03:06:116763 4 4 c1f0e5ac c1f0e388
c1f0e720 c25fdcdc c1f0e5b8
269: POSIX  ADVISORY  READ  16924 03:06:142110 4 4 c1f0e71c c1f0e5b0
c1f0eb14 d432af60 c1f0e728
270: POSIX  ADVISORY  READ  16924 03:06:142734 4 4 c1f0eb10 c1f0e720
d432abcc d432ad94 c1f0eb1c
271: POSIX  ADVISORY  READ  16909 03:06:142741 4 4 d432abc8 c1f0eb14
d432a60c c1f0e15c d432abd4
272: POSIX  ADVISORY  READ  16909 03:06:142740 4 4 d432a608 d432abcc
d432a77c c1f0e944 d432a614
273: POSIX  ADVISORY  READ  16909 03:06:142739 4 4 d432a778 d432a60c
d432a218 c1f0e778 d432a784
274: POSIX  ADVISORY  READ  16909 03:06:142738 4 4 d432a214 d432a77c
c1f0e1bc c1f0e6c0 d432a220
275: POSIX  ADVISORY  READ  16909 03:06:142737 4 4 c1f0e1b8 d432a218
c1f0e890 c1f0e43c c1f0e1c4
276: POSIX  ADVISORY  READ  16909 03:06:142736 4 4 c1f0e88c c1f0e1bc
c1f0e32c c1f0eb6c c1f0e898
277: POSIX  ADVISORY  READ  16909 03:06:142735 4 4 c1f0e328 c1f0e890
d432a49c c1f0e384 c1f0e334
278: POSIX  ADVISORY  READ  16909 03:06:116763 4 4 d432a498 c1f0e32c
c1f0e668 c1f0e5ac d432a4a4
279: POSIX  ADVISORY  READ  16909 03:06:142110 4 4 c1f0e664 d432a49c
d432a1bc c1f0e71c c1f0e670
280: POSIX  ADVISORY  READ  16909 03:06:142734 4 4 d432a1b8 c1f0e668
c466f218 c1f0eb10 d432a1c4
281: POSIX  ADVISORY  READ  16647 03:06:142741 4 4 c466f214 d432a1bc
c466f60c d432abc8 c466f220
282: POSIX  ADVISORY  READ  16647 03:06:142740 4 4 c466f608 c466f218
c466f834 d432a608 c466f614
283: POSIX  ADVISORY  READ  16647 03:06:142739 4 4 c466f830 c466f60c
c466f388 d432a778 c466f83c
284: POSIX  ADVISORY  READ  16647 03:06:142738 4 4 c466f384 c466f834
c466fab8 d432a214 c466f390
285: POSIX  ADVISORY  READ  16647 03:06:142737 4 4 c466fab4 c466f388
c466f890 c1f0e1b8 c466fac0
286: POSIX  ADVISORY  READ  16647 03:06:142736 4 4 c466f88c c466fab8
c466f274 c1f0e88c c466f898
287: POSIX  ADVISORY  READ  16647 03:06:142735 4 4 c466f270 c466f890
c466f9a4 c1f0e328 c466f27c
288: POSIX  ADVISORY  READ  16647 03:06:116763 4 4 c466f9a0 c466f274
c466f3e4 d432a498 c466f9ac
289: POSIX  ADVISORY  READ  16647 03:06:142110 4 4 c466f3e0 c466f9a4
c466f5b0 c1f0e664 c466f3ec
290: POSIX  ADVISORY  READ  16647 03:06:142734 4 4 c466f5ac c466f3e4
d432a890 d432a1b8 c466f5b8
291: POSIX  ADVISORY  READ  16632 03:06:142741 4 4 d432a88c c466f5b0
d432ab70 c466f214 d432a898
292: POSIX  ADVISORY  READ  16632 03:06:142740 4 4 d432ab6c d432a890
d432ac84 c466f608 d432ab78
293: POSIX  ADVISORY  READ  16632 03:06:142739 4 4 d432ac80 d432ab70
d432a32c c466f830 d432ac8c
294: POSIX  ADVISORY  READ  16632 03:06:142738 4 4 d432a328 d432ac84
d432adf4 c466f384 d432a334
295: POSIX  ADVISORY  READ  16632 03:06:142737 4 4 d432adf0 d432a32c
d432aa5c c466fab4 d432adfc
296: POSIX  ADVISORY  READ  16632 03:06:142736 4 4 d432aa58 d432adf4
d432a3e4 c466f88c d432aa64
297: POSIX  ADVISORY  READ  16632 03:06:142735 4 4 d432a3e0 d432aa5c
d432a9a4 c466f270 d432a3ec
298: POSIX  ADVISORY  READ  16632 03:06:116763 4 4 d432a9a0 d432a3e4
d432a7d8 c466f9a0 d432a9ac
299: POSIX  ADVISORY  READ  16632 03:06:142110 4 4 d432a7d4 d432a9a4
d432a104 c466f3e0 d432a7e0
300: POSIX  ADVISORY  READ  16632 03:06:142734 4 4 d432a100 d432a7d8
c466fa00 c466f5ac d432a10c
301: POSIX  ADVISORY  READ  16617 03:06:142741 4 4 c466f9fc d432a104
c466f948 d432a88c c466fa08
302: POSIX  ADVISORY  READ  16617 03:06:142740 4 4 c466f944 c466fa00
c466fb70 d432ab6c c466f950
303: POSIX  ADVISORY  READ  16617 03:06:142739 4 4 c466fb6c c466f948
c466f49c d432ac80 c466fb78
304: POSIX  ADVISORY  READ  16617 03:06:142738 4 4 c466f498 c466fb70
c466f4f8 d432a328 c466f4a4
305: POSIX  ADVISORY  READ  16617 03:06:142737 4 4 c466f4f4 c466f49c
c466f720 d432adf0 c466f500
306: POSIX  ADVISORY  READ  16617 03:06:142736 4 4 c466f71c c466f4f8
c466ff64 d432aa58 c466f728
307: POSIX  ADVISORY  READ  16617 03:06:142735 4 4 c466ff60 c466f720
c466f554 d432a3e0 c466ff6c
308: POSIX  ADVISORY  READ  16617 03:06:116763 4 4 c466f550 c466ff64
c466fc84 d432a9a0 c466f55c
309: POSIX  ADVISORY  READ  16617 03:06:142110 4 4 c466fc80 c466f554
c466f2d0 d432a7d4 c466fc8c
310: POSIX  ADVISORY  READ  16617 03:06:142734 4 4 c466f2cc c466fc84
d432a8ec d432a100 c466f2d8
311: POSIX  ADVISORY  READ  16603 03:06:142741 4 4 d432a8e8 c466f2d0
d432af08 c466f9fc d432a8f4
312: POSIX  ADVISORY  READ  16603 03:06:142740 4 4 d432af04 d432a8ec
d432a720 c466f944 d432af10
313: POSIX  ADVISORY  READ  16603 03:06:142739 4 4 d432a71c d432af08
d432a4f8 c466fb6c d432a728
314: POSIX  ADVISORY  READ  16603 03:06:142738 4 4 d432a4f4 d432a720
d432a668 c466f498 d432a500
315: POSIX  ADVISORY  READ  16603 03:06:142737 4 4 d432a664 d432a4f8
dad3b1bc c466f4f4 d432a670
316: POSIX  ADVISORY  READ  16603 03:06:142736 4 4 dad3b1b8 d432a668
d432a948 c466f71c dad3b1c4
317: POSIX  ADVISORY  READ  16603 03:06:142735 4 4 d432a944 dad3b1bc
dad3b9a4 c466ff60 d432a950
318: POSIX  ADVISORY  READ  16603 03:06:116763 4 4 dad3b9a0 d432a948
dad3bf08 c466f550 dad3b9ac
319: POSIX  ADVISORY  READ  16603 03:06:142110 4 4 dad3bf04 dad3b9a4
dad3b218 c466fc80 dad3bf10
320: POSIX  ADVISORY  READ  16603 03:06:142734 4 4 dad3b214 dad3bf08
c466f160 c466f2cc dad3b220
321: POSIX  ADVISORY  READ  16338 03:06:142741 4 4 c466f15c dad3b218
c466fd98 d432a8e8 c466f168
322: POSIX  ADVISORY  READ  16338 03:06:142740 4 4 c466fd94 c466f160
c466f1bc d432af04 c466fda0
323: POSIX  ADVISORY  READ  16338 03:06:142739 4 4 c466f1b8 c466fd98
f5b55890 d432a71c c466f1c4
324: POSIX  ADVISORY  READ  16338 03:06:142738 4 4 f5b5588c c466f1bc
f5b558ec d432a4f4 f5b55898
325: POSIX  ADVISORY  READ  16338 03:06:142737 4 4 f5b558e8 f5b55890
c466feac d432a664 f5b558f4
326: POSIX  ADVISORY  READ  16338 03:06:142736 4 4 c466fea8 f5b558ec
c466fd3c dad3b1b8 c466feb4
327: POSIX  ADVISORY  READ  16338 03:06:142735 4 4 c466fd38 c466feac
f5b55b70 d432a944 c466fd44
328: POSIX  ADVISORY  READ  16338 03:06:116763 4 4 f5b55b6c c466fd3c
f5b55a5c dad3b9a0 f5b55b78
329: POSIX  ADVISORY  READ  16338 03:06:142110 4 4 f5b55a58 f5b55b70
f5b55d3c dad3bf04 f5b55a64
330: POSIX  ADVISORY  READ  16338 03:06:142734 4 4 f5b55d38 f5b55a5c
c25fd7d8 dad3b214 f5b55d44
331: POSIX  ADVISORY  READ  14058 03:06:142741 4 4 c25fd7d4 f5b55d3c
c25fd9a4 c466f15c c25fd7e0
332: POSIX  ADVISORY  READ  14058 03:06:142740 4 4 c25fd9a0 c25fd7d8
c25fd2d0 c466fd94 c25fd9ac
333: POSIX  ADVISORY  READ  14058 03:06:142739 4 4 c25fd2cc c25fd9a4
c25fd3e4 c466f1b8 c25fd2d8
334: POSIX  ADVISORY  READ  14058 03:06:142738 4 4 c25fd3e0 c25fd2d0
c25fdd98 f5b5588c c25fd3ec
335: POSIX  ADVISORY  READ  14058 03:06:142737 4 4 c25fdd94 c25fd3e4
c25fd4f8 f5b558e8 c25fdda0
336: POSIX  ADVISORY  READ  14058 03:06:142736 4 4 c25fd4f4 c25fdd98
c25fd890 c466fea8 c25fd500
337: POSIX  ADVISORY  READ  14058 03:06:142735 4 4 c25fd88c c25fd4f8
c25fd834 c466fd38 c25fd898
338: POSIX  ADVISORY  READ  14058 03:06:116763 4 4 c25fd830 c25fd890
c25fd1bc f5b55b6c c25fd83c
339: POSIX  ADVISORY  READ  14058 03:06:142110 4 4 c25fd1b8 c25fd834
c25fd5b0 f5b55a58 c25fd1c4
340: POSIX  ADVISORY  READ  14058 03:06:142734 4 4 c25fd5ac c25fd1bc
c25fdb14 f5b55d38 c25fd5b8
341: POSIX  ADVISORY  READ  8268 03:06:142741 4 4 c25fdb10 c25fd5b0 dad3b60c
c25fd7d4 c25fdb1c
342: POSIX  ADVISORY  READ  8268 03:06:142740 4 4 dad3b608 c25fdb14 dad3bdf4
c25fd9a0 dad3b614
343: POSIX  ADVISORY  READ  8268 03:06:142739 4 4 dad3bdf0 dad3b60c dad3b668
c25fd2cc dad3bdfc
344: POSIX  ADVISORY  READ  8268 03:06:142738 4 4 dad3b664 dad3bdf4 dad3beac
c25fd3e0 dad3b670
345: POSIX  ADVISORY  READ  8268 03:06:142737 4 4 dad3bea8 dad3b668 dad3b388
c25fdd94 dad3beb4
346: POSIX  ADVISORY  READ  8268 03:06:142736 4 4 dad3b384 dad3beac dad3b7d8
c25fd4f4 dad3b390
347: POSIX  ADVISORY  READ  8268 03:06:142735 4 4 dad3b7d4 dad3b388 dad3b440
c25fd88c dad3b7e0
348: POSIX  ADVISORY  READ  8268 03:06:116763 4 4 dad3b43c dad3b7d8 dad3b49c
c25fd830 dad3b448
349: POSIX  ADVISORY  READ  8268 03:06:142110 4 4 dad3b498 dad3b440 dad3be50
c25fd1b8 dad3b4a4
350: POSIX  ADVISORY  READ  8268 03:06:142734 4 4 dad3be4c dad3b49c d432aab8
c25fd5ac dad3be58
351: POSIX  ADVISORY  READ  8263 03:06:142734 4 4 d432aab4 dad3be50 c25fd554
dad3be4c d432aac0
352: POSIX  ADVISORY  READ  8263 03:06:142110 4 4 c25fd550 d432aab8 d432ac28
dad3b498 c25fd55c
353: POSIX  ADVISORY  WRITE 8263 03:06:43152 0 0 d432ac24 c25fd554 d432aa00
00000000 d432ac30
354: POSIX  ADVISORY  READ  8260 03:06:142116 4 4 d432a9fc d432ac28 d432a834
00000000 d432aa08
355: POSIX  ADVISORY  READ  8260 03:06:142110 4 4 d432a830 d432aa00 c1f0ece0
c25fd550 d432a83c
356: POSIX  ADVISORY  WRITE 8260 03:06:31204 0 0 c1f0ecdc d432a834 c1f0ed98
00000000 c1f0ece8
357: FLOCK  ADVISORY  WRITE 872 03:06:161814 0 EOF c1f0ed94 c1f0ece0
c25fdf64 00000000 c1f0eda0
358: FLOCK  ADVISORY  WRITE 849 03:06:166888 0 EOF c25fdf60 c1f0ed98
c1f0eeac 00000000 c25fdf6c
359: POSIX  ADVISORY  WRITE 654 03:06:148472 0 EOF c1f0eea8 c25fdf64
c1f0ef64 00000000 c1f0eeb4
360: POSIX  ADVISORY  WRITE 230 03:06:84826 0 EOF c1f0ef60 c1f0eeac c25fde50
00000000 c1f0ef6c
361: POSIX  ADVISORY  WRITE 220 03:06:164755 0 EOF c25fde4c c1f0ef64
c25fdeac 00000000 c25fde58
362: FLOCK  ADVISORY  WRITE 206 03:06:147482 0 EOF c25fdea8 c25fde50
c033c094 00000000 c25fdeb4

 # uname -a
Linux fileserver 2.4.18-4GB-SMP #5 SMP Tue Dec 10 15:22:29 CET 2002 i686
unknown

 # ifconfig
eth0      Link encap:Ethernet  HWaddr 00:30:48:27:11:BE
          inet addr:192.168.2.21  Bcast:192.168.2.255  Mask:255.255.255.0
          inet6 addr: fe80::230:48ff:fe27:11be/10 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:8000  Metric:1
          RX packets:7512274 errors:0 dropped:0 overruns:0 frame:0
          TX packets:7490919 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          RX bytes:3956744810 (3773.4 Mb)  TX bytes:2568239131 (2449.2 Mb)
          Interrupt:28 Base address:0x4000 Memory:fc300000-0

eth1      Link encap:Ethernet  HWaddr 00:30:48:27:11:BF
          inet addr:192.168.1.21  Bcast:192.168.1.255  Mask:255.255.255.0
          inet6 addr: fe80::230:48ff:fe27:11bf/10 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:500407595 errors:0 dropped:0 overruns:0 frame:0
          TX packets:244860175 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          RX bytes:482199336 (459.8 Mb)  TX bytes:1138338375 (1085.6 Mb)
          Interrupt:29 Base address:0x4040 Memory:fc320000-0

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:60308 errors:0 dropped:0 overruns:0 frame:0
          TX packets:60308 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:3964804 (3.7 Mb)  TX bytes:3964804 (3.7 Mb)


----- Original Message -----
From: "Joseph D. Wagner" <wagnerjd@prodigy.net>
To: "'Milan Roubal'" <roubal@jobatlas.cz>; <linux-kernel@vger.kernel.org>
Sent: Tuesday, December 17, 2002 7:50 AM
Subject: RE: big load


> I remember an error like this from a few months ago.  Are you encountering
> large I/O access?  Lots of swapping?  Lots of buffer input?  Lots of
buffer
> output?  This would show up on vmstats.
>
> Joseph Wagner
>
> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Milan Roubal
> Sent: Sunday, December 15, 2002 7:55 PM
> To: linux-kernel@vger.kernel.org
> Subject: big load
>
> Hi,
> I have got server runnig 5 days and now its doing this:
>
> 2:48am  up 5 days, 11:23,  2 users,  load average: 19.97, 15.70, 10.63
> 61 processes: 60 sleeping, 1 running, 0 zombie, 0 stopped
> CPU0 states:  0.0% user,  8.1% system,  0.0% nice, 91.4% idle
> CPU1 states:  0.0% user,  0.1% system,  0.0% nice, 99.4% idle
>
> I can't understand where I can got so big load
> processor is idle all the time, but load is going higher and higher.
>
>   2:50am  up 5 days, 11:24,  2 users,  load average: 21.45, 17.45, 11.80
> 62 processes: 61 sleeping, 1 running, 0 zombie, 0 stopped
> CPU0 states:  0.0% user,  0.0% system,  0.0% nice, 100.0% idle
> CPU1 states:  0.0% user,  0.1% system,  0.0% nice, 99.4% idle
>
> my process:
>
>
>   PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
> 13782 root      13   0   892  892   696 R     0.2  0.0   0:00 top
>     1 root      20   0    84   84    52 S     0.0  0.0   0:11 init
>     2 root      20   0     0    0     0 SW    0.0  0.0   0:00 keventd
>     3 root      20  19     0    0     0 SWN   0.0  0.0   0:03
ksoftirqd_CPU0
>     4 root      20  19     0    0     0 SWN   0.0  0.0   0:00
ksoftirqd_CPU1
>     5 root      20   0     0    0     0 SW    0.0  0.0  17:22 kswapd
>     6 root       0   0     0    0     0 SW    0.0  0.0   1:45 bdflush
>     7 root      20   0     0    0     0 SW    0.0  0.0  33:48 kupdated
>     8 root      20   0     0    0     0 SW    0.0  0.0   0:00 kinoded
>    11 root       0 -20     0    0     0 SW<   0.0  0.0   0:00 mdrecoveryd
>    14 root      20   0     0    0     0 SW    0.0  0.0   0:03 kreiserfsd
>    51 root      20 -20     0    0     0 SW<   0.0  0.0  11:20 raid5d
>   245 root      20   0     0    0     0 DW    0.0  0.0   0:09
pagebuf_daemon
>   388 root      20   0   316  316   208 S     0.0  0.0   0:00 syslogd
>   391 root      20   0   440  440   216 S     0.0  0.0   0:00 klogd
>   427 root      20   0     0    0     0 SW    0.0  0.0   0:00 khubd
>
> What could be wrong?
> In log is only this message:
>
> Dec 16 02:32:37 fileserver kernel: lease timed out
>
> # /usr/local/samba/bin/smbd -V
> Version 2.2.6
>
> System is 2.4.18-3 from SuSE,
> SuSE 8.1 distribution.
> Filesystem XFS on 1TB RAID5 array
>     Thanx
>     Milan Roubal
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

