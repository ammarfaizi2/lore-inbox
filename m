Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130689AbRATXkV>; Sat, 20 Jan 2001 18:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131441AbRATXkL>; Sat, 20 Jan 2001 18:40:11 -0500
Received: from femail2.rdc1.on.home.com ([24.2.9.89]:8880 "EHLO
	femail2.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S130689AbRATXkI>; Sat, 20 Jan 2001 18:40:08 -0500
Message-ID: <3A6A21B3.E8F0457B@Home.net>
Date: Sat, 20 Jan 2001 18:39:31 -0500
From: Shawn Starr <Shawn.Starr@Home.net>
Organization: Visualnet
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre9 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.4.x & 2.4.1-preX Latency results
Content-Type: multipart/mixed;
 boundary="------------52E59F0EB6457D01823F20D1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------52E59F0EB6457D01823F20D1
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

I've included the TPT latency timings.

Do these look normal?

These tests occured in X with netscape and gnomeicu.

It should be noted that /dev/tty12 is being used for syslog info for
console.

Shawn.



--------------52E59F0EB6457D01823F20D1
Content-Type: text/plain; charset=iso-8859-15;
 name="tpt.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tpt.log"

                                   Destination  Count      Min       Max  Average       Total

do_IRQ.in:0 ->
                                     irq.c:437  2281      2.59      7.79     4.64   10,602.21
                                  do_IRQ.out:0  9        13.39     18.85    17.23      155.14
                                  softirq.c:71  5839     10.19     29.96    14.81   86,487.67

softirq.c:174 ->
                                 softirq.c:177  5848       .72      1.10      .74    4,350.14

timer.c:657 ->
                                   timer.c:664  5848      1.03      7.30     1.95   11,429.92

timer.c:290 ->
                                   timer.c:314  2965      1.04     10.20     1.72    5,122.29
                                   timer.c:323  2883       .90      8.64     1.31    3,786.21

softirq.c:129 ->
                                 softirq.c:132  22         .73       .85      .75       16.69

console.c:2020 ->
                                console.c:2044  20        2.50  2,189.42   113.99    2,279.94

softirq.c:83 ->
                                   sched.c:661  60        4.86      8.08     5.43      325.98
                                   sched.c:591  483       3.15     10.00     5.57    2,692.64
                                  do_IRQ.out:0  5990       .70      1.75      .90    5,441.94
                                  softirq.c:71  83         .78       .89      .82       68.23

sched.c:702 ->
                                   sched.c:737  11998      .77      6.92     2.35   28,281.37

page_alloc.c:105 ->
                              page_alloc.c:137  10981      .93      3.93     1.68   18,486.39

slab.c:1298 ->
                                   slab.c:1322  219754     .83      4.22     1.11  245,026.41
                                   slab.c:1329  21         .85      1.50     1.07       22.67

slab.c:1107 ->
                                   slab.c:1118  21        1.11      1.70     1.29       27.21

page_alloc.c:181 ->
                              page_alloc.c:198  11257     1.28      7.78     2.59   29,256.21

slab.c:1149 ->
                                   slab.c:1159  21         .83      1.11      .88       18.65

softirq.c:60 ->
                                  softirq.c:71  27         .81      1.40      .99       26.95

fork.c:688 ->
                                    fork.c:696  3         3.68      4.00     3.88       11.66

sched.c:336 ->
                                   sched.c:343  2096       .87      4.20     1.88    3,949.99

slab.c:1582 ->
                                   slab.c:1586  218942    1.07      6.92     1.60  350,699.01

fork.c:51 ->
                                     fork.c:54  38         .83      1.10      .89       33.91

sched.c:666 ->
                                   sched.c:591  272       1.21      1.77     1.31      357.98

fork.c:61 ->
                                     fork.c:63  80150      .75      3.86      .90   72,482.23

sched.c:784 ->
                                   sched.c:661  40        2.82      5.13     3.20      128.27
                                   sched.c:591  1182      2.39      9.84     3.24    3,831.06

signal.c:1053 ->
                                 signal.c:1056  13         .87      2.20     1.24       16.13

fork.c:41 ->
                                     fork.c:44  80112      .78      2.67     1.04   83,981.73

timer.c:180 ->
                                   timer.c:184  9557       .83      3.07     1.60   15,293.84

timer.c:316 ->
                                   timer.c:314  1513       .80      3.24     1.32    1,998.37
                                   timer.c:323  2965       .82      1.81     1.08    3,224.91

timer.c:218 ->
                                   timer.c:221  9395       .76      1.83     1.02    9,588.75

time.c:262 ->
                                    time.c:271  420717     .86      3.42     1.18  498,929.85

pc_keyb.c:485 ->
                                 pc_keyb.c:487  19       12.84     33.29    22.62      429.84

irq.c:446 ->
                                   sched.c:591  4         7.50      9.29     8.70       34.80
                                  do_IRQ.out:0  2130      1.80      5.25     3.03    6,462.64
                                  softirq.c:71  151       2.40      4.38     3.40      514.36

irq.c:476 ->
                                     irq.c:481  1         2.32      2.32     2.32        2.32

irq.c:523 ->
                                     irq.c:542  1         2.10      2.10     2.10        2.10

ide.c:1536 ->
                                    ide.c:1604  196       2.55      7.75     4.70      921.63

ide.c:538 ->
                                     ide.c:547  196       2.31      4.52     3.21      629.29

ide.c:1359 ->
                               ll_rw_blk.c:385  59         .93      1.13      .94       55.96
                                    ide.c:1625  137        .94      1.59     1.11      152.09

sched.c:536 ->
                                   sched.c:661  172       1.16      2.54     2.01      347.38
                                   sched.c:591  15729      .90      5.15     2.01   31,658.35

sched.c:786 ->
                                   sched.c:786  1222       .86      1.34     1.04    1,272.31

ll_rw_blk.c:161 ->
                               ll_rw_blk.c:163  637        .97      3.23     1.29      826.09

ll_rw_blk.c:772 ->
                               ll_rw_blk.c:840  1        27.32     27.32    27.32       27.32
                               ll_rw_blk.c:869  637       2.36     47.10     5.80    3,698.34

softirq.c:297 ->
                                 softirq.c:300  1827       .77      1.51      .88    1,618.10

ll_rw_blk.c:383 ->
                               ll_rw_blk.c:385  1          .80       .80      .80         .80
                                    ide.c:1357  59        2.55      9.76     5.51      325.17

/usr/src/linux/include/linux/tqueue.h:86 ->
      /usr/src/linux/include/linux/tqueue.h:88  1685       .76      1.52      .89    1,513.41

timer.c:205 ->
                                   timer.c:209  239        .88      3.83     1.82      435.64

skbuff.c:136 ->
                                  skbuff.c:138  7266       .78      1.45      .90    6,539.92

slab.c:1563 ->
                                   slab.c:1565  1635      1.07      3.77     1.36    2,229.26

n_tty.c:132 ->
                                   n_tty.c:134  6          .90      1.31     1.03        6.19

n_tty.c:810 ->
                                   n_tty.c:846  3         3.28      4.54     3.97       11.91

fcntl.c:454 ->
                                   fcntl.c:478  3          .81      4.35     2.25        6.75

tty_ioctl.c:104 ->
                               tty_ioctl.c:114  7         2.25     11.46     7.08       49.58

console.c:2299 ->
                                console.c:2301  20         .80      2.62      .93       18.74

console.c:1862 ->
                                console.c:1980  10        1.34     98.74    16.40      164.01

signal.c:839 ->
                                  signal.c:859  30597      .83      4.24     1.13   34,729.71

signal.c:865 ->
                                  signal.c:867  14143      .75      1.58      .83   11,750.34

skbuff.c:121 ->
                                  skbuff.c:123  7245       .89      2.41     1.37    9,961.90

/usr/src/linux/include/linux/skbuff.h:527 ->
     /usr/src/linux/include/linux/skbuff.h:529  17104      .77      2.17     1.04   17,820.40

signal.c:116 ->
                                  signal.c:124  3         3.93      4.67     4.22       12.67

exit.c:384 ->
                                    exit.c:418  3         8.02     16.81    11.24       33.74

/usr/src/linux/include/linux/sched.h:851 ->
      /usr/src/linux/include/linux/sched.h:856  3         2.27      2.81     2.56        7.68

signal.c:604 ->
                                  signal.c:606  3404      3.39     12.38     5.49   18,720.25

signal.c:571 ->
                                  signal.c:575  3404       .89      1.46      .98    3,360.16

signal.c:265 ->
                                  signal.c:268  3386       .78      1.59      .93    3,171.32

dev.c:1127 ->
                                    dev.c:1139  113       1.08      2.75     1.77      200.93

dev.c:1326 ->
                                    dev.c:1328  226        .73      1.31      .90      204.20

dev.c:1426 ->
                                    dev.c:1434  113        .83       .96      .89      100.76

signal.c:528 ->
                                  signal.c:546  3930      1.28     14.86     6.21   24,427.82

/usr/src/linux/include/linux/skbuff.h:479 ->
     /usr/src/linux/include/linux/skbuff.h:481  7003       .78      1.84      .95    6,657.46

/usr/src/linux/include/linux/interrupt.h:163 ->
  /usr/src/linux/include/linux/interrupt.h:167  1         1.07      1.07     1.07        1.07

tty_io.c:1892 ->
                                 tty_io.c:1898  848        .85      1.58     1.05      893.72

n_tty.c:105 ->
                                   n_tty.c:107  4          .87      1.45     1.14        4.58

tty_io.c:1884 ->
                                 tty_io.c:1898  847        .94      2.35     1.31    1,111.29

n_tty.c:165 ->
                                   n_tty.c:173  2463      1.00      2.21     1.17    2,892.53

n_tty.c:917 ->
                                   n_tty.c:919  3300       .80      1.51      .91    3,013.56

n_tty.c:924 ->
                                   n_tty.c:927  1650       .78      1.43      .87    1,437.68

serial.c:1203 ->
                                 serial.c:1441  1        68.33     68.33    68.33       68.33

serial.c:2760 ->
                                 serial.c:2796  1         3.64      3.64     3.64        3.64

serial.c:1939 ->
                                 serial.c:1941  1          .76       .76      .76         .76

signal.c:107 ->
                                  signal.c:111  25         .92      1.52     1.21       30.42

3c59x.c:1835 ->
                                  3c59x.c:1855  118       3.41      5.40     4.26      502.75

/usr/src/linux/include/linux/netdevice.h:533 ->
  /usr/src/linux/include/linux/netdevice.h:537  118        .76      1.25      .95      112.90

dev.c:1226 ->
                                    dev.c:1229  118        .79       .89      .83       98.79

ide.c:1606 ->
                                    ide.c:1625  59        2.07      5.44     3.22      190.08
                                    ide.c:1357  137       1.71      6.27     3.20      439.65

ide.c:513 ->
                                     ide.c:522  637       1.40     21.50     4.74    3,025.48

serial.c:1770 ->
                                 serial.c:1790  2         9.48     10.14     9.81       19.62

serial.c:1469 ->
                                 serial.c:1565  1        32.78     32.78    32.78       32.78

n_tty.c:727 ->
                                   n_tty.c:741  1700      1.17      4.52     2.25    3,834.61

/usr/src/linux/include/linux/skbuff.h:432 ->
     /usr/src/linux/include/linux/skbuff.h:434  2823       .77      1.37      .82    2,320.72

slab.c:1735 ->
                                   slab.c:1817  2         8.20     10.30     9.25       18.51
                                   slab.c:1783  47         .98      3.39     1.57       74.02

serial.c:1073 ->
                                 serial.c:1091  5         7.75     11.27     9.87       49.39

slab.c:1794 ->
                                   slab.c:1817  1         1.55      1.55     1.55        1.55

slab.c:1819 ->
                                   slab.c:1821  3          .79       .81      .80        2.42
                                   slab.c:1817  26         .82       .94      .83       21.73

ll_rw_blk.c:503 ->
                               ll_rw_blk.c:505  2          .96      1.29     1.12        2.25

slab.c:905 ->
                                    slab.c:928  2         1.18      1.24     1.21        2.42

vt.c:836 ->
                                      vt.c:838  1       645.09    645.09   645.09      645.09

--------------52E59F0EB6457D01823F20D1--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
