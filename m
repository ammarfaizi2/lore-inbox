Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129620AbRBVPew>; Thu, 22 Feb 2001 10:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129300AbRBVPeo>; Thu, 22 Feb 2001 10:34:44 -0500
Received: from hera.cwi.nl ([192.16.191.8]:13027 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S130046AbRBVPe1>;
	Thu, 22 Feb 2001 10:34:27 -0500
Date: Thu, 22 Feb 2001 16:34:25 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200102221534.QAA243062.aeb@vlet.cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: filesystem statistics
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that people are discussing the right hash function to use,
and the amount of space taken by filenames in various schemes,
I wondered how these things are on a random machine.
Here some statistics.

Andries

--------------------------------------------------------------

Statistics on a filesystem with 63 GB worth of files.

2797212 files

average file size: 22600 bytes
average depth: 8
average pathname length: 59 bytes
average filename length: 10 bytes

max file size: 678035456 bytes
max depth: 17
max pathname length: 159 bytes
max filename length: 99 bytes

longest path name (also with largest depth):
159 bytes: /b2/g1a/linux/nist/NIST-PCTS/STD/DIF/data/dif.d/ln_gt_100_test/ln_gt_100_test/ln_gt_100_test/ln_gt_100_test/ln_gt_100_test/ln_gt_100_test/ln_gt_100_test/tar_19

longest file name:
99 bytes: CL_Streamed_RawSample_Session_CL_Streamed_RawSample_Session_CL_InputSource_SoundFormatintbool_.html

distribution of depths:
 0: 1
 1: 50
 2: 3212
 3: 19951
 4: 57534
 5: 159917
 6: 347124
 7: 705958
 8: 569661
 9: 657689
10: 176777
11: 63221
12: 24646
13: 9765
14: 1364
15: 259
16: 80
17: 3

distribution of pathname lengths:
        0       1       2       3       4       5       6       7       8       9
0:      0       1       0       14      14      10      13      66      203     646
10:     1133    649     1521    3367    2664    2398    2969    3657    4822    3010
20:     3360    3951    3824    4182    5702    5043    6352    7660    9027    11948
30:     11877   25050   17943   26597   24599   23174   25292   31789   31897   31319
40:     33225   36892   36911   42668   42106   46898   46666   49673   54825   61980
50:     64753   62859   72410   75021   79526   73447   75175   72326   70532   70574
60:     71446   71227   68235   67907   62067   56403   54213   49642   44474   39715
70:     35215   31877   31270   22486   20232   16859   14218   12767   13826   12855
80:     8269    139474  13866   13182   5858    5158    268605  4077    3633    3152
90:     2627    2201    1691    1680    1486    1538    1327    1163    1025    1390
100:    818     891     775     935     1503    1450    438     368     296     1198
110:    1102    169     174     139     101     963     925     74      51      44
120:    31      22      20      20      20      6       12      17      12      18
130:    13      7       10      8       9       7       3       6       1       0
140:    2       0       0       0       0       0       0       0       1       0
150:    0       1       2       0       0       1       0       0       1       2
160:    0       0       0       0       0       0       0       0       0       0

distribution of filename lengths:
        0       1       2       3       4       5       6       7       8       9
0:      1       2341    16946   36630   66883   115118  189020  224596  289985  682943
10:     237134  213677  199863  114987  81873   60902   52485   38200   29354   24779
20:     21153   15792   13279   14638   11973   9366    7586    4674    3832    2975
30:     2645    1938    1643    1244    1076    909     660     642     544     508
40:     379     222     186     217     229     126     124     107     103     71
50:     52      52      48      54      56      41      38      40      11      18
60:     19      11      8       20      21      8       9       8       21      13
70:     10      9       10      8       9       11      4       9       5       4
80:     3       3       3       1       1       0       1       3       2       2
90:     1       0       1       1       1       1       2       0       0       1
100:    0       0       0       0       0       0       0       0       0       0

