Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261800AbRFGQYQ>; Thu, 7 Jun 2001 12:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261866AbRFGQYH>; Thu, 7 Jun 2001 12:24:07 -0400
Received: from penguins-world.pcsystems.de ([212.63.44.200]:19950 "HELO
	schottelius.org") by vger.kernel.org with SMTP id <S261800AbRFGQXu>;
	Thu, 7 Jun 2001 12:23:50 -0400
Message-ID: <3B1FAA63.130E556A@pcsystems.de>
Date: Thu, 07 Jun 2001 18:22:59 +0200
From: Nico Schottelius <nicos@pcsystems.de>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: scsi disk defect or kernel driver defect ?
Content-Type: multipart/mixed;
 boundary="------------969AA4B5704452246C7132D9"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------969AA4B5704452246C7132D9
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello guys!

Currently my scsi disc is only reporting errors!
In the adaptect scsi bios I tried the verify media
option and it worked fine. The output from the Linux
kernel is more than worse!

Can you tell me what's wrong in my system ?

I will monitor the mailing list the next hours, if
the hard disk allows that.

Please help me, this is the second scsi disc
reporting such failures!

Regards,

Nico

--------------969AA4B5704452246C7132D9
Content-Type: text/plain; charset=us-ascii;
 name="SYSTEM_CONFIG"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="SYSTEM_CONFIG"

 Scsiinfo version 1.7(eowmob)

Inquiry command
---------------
Relative Address                   0
Wide bus 32                        0
Wide bus 16                        1
Synchronous neg.                   1
Linked Commands                    1
Command Queueing                   1
SftRe                              0
Device Type                        0
Peripheral Qualifier               0
Removable?                         0
Device Type Modifier               0
ISO Version                        0
ECMA Version                       0
ANSI Version                       3
AENC                               0
TrmIOP                             0
Response Data Format               2
Vendor:                    IBM     
Product:                   DNES-309170W    
Revision level:            SA30AJGE0980

Serial Number '        AJGE0980'
Data from Rigid Disk Drive Geometry Page
----------------------------------------
Number of cylinders                11474
Number of heads                    5
Starting write precomp             0
Starting reduced current           0
Drive step rate                    0
Landing Zone Cylinder              0
RPL                                0
Rotational Offset                  0
Rotational Rate                    7200

Data from Caching Page
----------------------
Write Cache                        1
Read Cache                         1
Prefetch units                     0
Demand Read Retention Priority     0
Demand Write Retention Priority    0
Disable Pre-fetch Transfer Length  65535
Minimum Pre-fetch                  0
Maximum Pre-fetch                  65535
Maximum Pre-fetch Ceiling          65535

Data from Format Device Page
----------------------------
Removable Medium                   0
Supports Hard Sectoring            1
Supports Soft Sectoring            0
Addresses assigned by surface      0
Tracks per Zone                    5215
Alternate sectors per zone         0
Alternate tracks per zone          0
Alternate tracks per lun           0
Sectors per track                  320
Bytes per sector                   512
Interleave                         1
Track skew factor                  11
Cylinder skew factor               20

Data from Error Recovery Page
-----------------------------
AWRE                               1
ARRE                               1
TB                                 0
RC                                 0
EER                                0
PER                                0
DTE                                0
DCR                                0
Read Retry Count                   1
Correction Span                    0
Head Offset Count                  0
Data Strobe Offset Count           0
Write Retry Count                  1
Recovery Time Limit                0

Data from Control Page
----------------------
RLEC                               0
QErr                               0
DQue                               0
EECA                               0
RAENP                              0
UUAENP                             0
EAENP                              0
Queue Algorithm Modifier           0
Ready AEN Holdoff Period           0

Data from Disconnect-Reconnect Page
-----------------------------------
Buffer full ratio                  0
Buffer empty ratio                 0
Bus Inactivity Limit               0
Disconnect Time Limit              0
Connect Time Limit                 0
Maximum Burst Size                 0
DTDC                               0x0

Data from Defect Lists
----------------------
151 entries in manufacturer table.
Format is: bytes from index [Cyl:Head:Off]
Offset -1 marks whole track as bad.

     137:3:70656     138:3:70656     139:3:70656     140:3:70656     141:3:70656
    186:1:182272     367:4:92672    382:0:122880    382:0:123392     434:4:47104
     454:4:47104     458:4:47104     459:4:47104     460:4:47104     461:4:47104
     462:4:47104    558:1:109056    559:1:109056    560:1:109056    561:1:109056
     733:1:40960      1086:2:512    1110:1:83456    1110:1:83968     1139:1:9216
    1251:4:68608   1733:1:115712   1854:0:148480    1926:Unable to read Peripheral Device Page 09h
1:19968    1940:4:82944
    1974:1:11264    2156:1:40448    2440:1:48640    2497:1:78848   3416:0:146432
   3669:1:110592   3669:1:111104   3669:1:111616   3669:1:112128   3669:1:112640
   3669:1:113152   3669:1:113664   3669:1:114176   3669:1:114688   3669:1:115200
   3669:1:115712   3669:1:116224   3669:1:116736   3669:1:117248    4125:4:27136
   4142:4:126464   4222:1:145920    4371:2:86528   4437:3:144384        4510:2:0
      4510:2:512     4510:2:1024     4510:2:1536     4510:2:2048     4510:2:2560
     4510:2:3072     4510:2:3584   4510:2:163840   4510:2:164352   4510:2:164864
   4510:2:165376   4510:2:165888    4666:4:79360    5386:1:29696   5509:0:147968
   5604:3:126464   5605:3:126464   5606:3:126464   5607:3:126464   5898:1:128000
   6081:0:137728   6493:3:121856    6549:2:14848     6683:1:4096    6711:2:28672
    6712:2:28672    6713:2:28672    6714:2:28672    6715:2:28672    7757:4:19968
    7931:0:30720   8024:1:107520   8083:2:103424    8303:2:45056    8303:2:45568
    8303:2:46080    8303:2:46592    8304:2:45056    8304:2:45568    8304:2:46080
    8304:2:46592    8304:2:47104    8304:2:47616    8304:2:48128    8304:2:48640
    8304:2:49152    8304:2:49664    8304:2:50176    8304:2:50688    8304:2:51200
    8304:2:51712    8304:2:52224    8305:2:45056    8305:2:45568    8305:2:46080
    8305:2:46592    8305:2:47104    8305:2:47616    8305:2:48128    8305:2:48640
    8305:2:49152    8305:2:49664    8305:2:50176    8305:2:50688    8306:2:45056
    8306:2:45568    8306:2:46080    8306:2:46592    8315:2:87040    8546:1:53248
    8811:2:29696    8928:0:82432    9149:1:88576    9546:0:81408    9581:2:99840
    9757:1:10752    9757:1:11264    9757:1:11776    9757:1:12288    9757:1:12800
    9757:1:13312    9757:1:13824    9757:1:14336    9757:1:14848    9757:1:15360
    9757:1:15872    9757:1:16384    9757:1:16896    9757:1:17408   9827:0:101888
   10189:1:88576  10527:4:118784   10972:1:65024   11054:4:78848  11094:4:119808
  11130:1:115712

0 entries in grown table.
Format is: bytes from index [Cyl:Head:Off]
Offset -1 marks whole track as bad.

Data from Notch Parameters Page
-------------------------------
Notched Drive                      1
Logical or Physical Notch          0
Max # of notches                   11
Active Notch                       0
Starting Boundary                  0x0
Ending Boundary                    0x2cd104
Pages Notched                      00000000 0000100c

Data from Verify Error Recovery Page
------------------------------------
EER                                0
PER                                0
DTE                                0
DCR                                0
Verify Retry Count                 1
Verify Correction Span (bits)      0
Verify Recovery Time Limit (ms)    0

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 5
model name	: Pentium II (Deschutes)
stepping	: 3
cpu MHz		: 399.325
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips	: 796.26

 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
 I/O error: dev 08:01, sector 127304
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
[valid=0] Info fld=0x0, Current sd08:01: sns = 70  b
ASC=47 ASCQ= 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x18 0x00 0x00 0x00 0x00 0x47 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
 I/O error: dev 08:01, sector 127312
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
[valid=0] Info fld=0x0, Current sd08:01: sns = 70  b
ASC=47 ASCQ= 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x18 0x00 0x00 0x00 0x00 0x47 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
 I/O error: dev 08:01, sector 127320
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
[valid=0] Info fld=0x0, Current sd08:01: sns = 70  b
ASC=47 ASCQ= 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x18 0x00 0x00 0x00 0x00 0x47 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
 I/O error: dev 08:01, sector 127328
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
[valid=0] Info fld=0x0, Current sd08:01: sns = 70  b
ASC=47 ASCQ= 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x18 0x00 0x00 0x00 0x00 0x47 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
 I/O error: dev 08:01, sector 127336
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
[valid=0] Info fld=0x0, Current sd08:01: sns = 70  b
ASC=47 ASCQ= 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x18 0x00 0x00 0x00 0x00 0x47 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
 I/O error: dev 08:01, sector 127344
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
[valid=0] Info fld=0x0, Current sd08:01: sns = 70  b
ASC=47 ASCQ= 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x18 0x00 0x00 0x00 0x00 0x47 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
 I/O error: dev 08:01, sector 127352
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
[valid=0] Info fld=0x0, Current sd08:01: sns = 70  b
ASC=47 ASCQ= 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x18 0x00 0x00 0x00 0x00 0x47 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
 I/O error: dev 08:01, sector 127360
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
[valid=0] Info fld=0x0, Current sd08:01: sns = 70  b
ASC=47 ASCQ= 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x18 0x00 0x00 0x00 0x00 0x47 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
 I/O error: dev 08:01, sector 127368
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
[valid=0] Info fld=0x0, Current sd08:01: sns = 70  b
ASC=47 ASCQ= 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x18 0x00 0x00 0x00 0x00 0x47 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
 I/O error: dev 08:01, sector 127376
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
[valid=0] Info fld=0x0, Current sd08:01: sns = 70  b
ASC=47 ASCQ= 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x18 0x00 0x00 0x00 0x00 0x47 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
 I/O error: dev 08:01, sector 127384
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
[valid=0] Info fld=0x0, Current sd08:01: sns = 70  b
ASC=47 ASCQ= 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x18 0x00 0x00 0x00 0x00 0x47 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
 I/O error: dev 08:01, sector 127392
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
[valid=0] Info fld=0x0, Current sd08:01: sns = 70  b
ASC=47 ASCQ= 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x18 0x00 0x00 0x00 0x00 0x47 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
 I/O error: dev 08:01, sector 127400
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
[valid=0] Info fld=0x0, Current sd08:01: sns = 70  b
ASC=47 ASCQ= 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x18 0x00 0x00 0x00 0x00 0x47 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
 I/O error: dev 08:01, sector 127408
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
[valid=0] Info fld=0x0, Current sd08:01: sns = 70  b
ASC=47 ASCQ= 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x18 0x00 0x00 0x00 0x00 0x47 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
 I/O error: dev 08:01, sector 127416
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
[valid=0] Info fld=0x0, Current sd08:01: sns = 70  b
ASC=47 ASCQ= 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x18 0x00 0x00 0x00 0x00 0x47 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
 I/O error: dev 08:01, sector 127424
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
[valid=0] Info fld=0x0, Current sd08:01: sns = 70  b
ASC=47 ASCQ= 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x18 0x00 0x00 0x00 0x00 0x47 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
 I/O error: dev 08:01, sector 127432
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
[valid=0] Info fld=0x0, Current sd08:01: sns = 70  b
ASC=47 ASCQ= 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x18 0x00 0x00 0x00 0x00 0x47 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
 I/O error: dev 08:01, sector 127440
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
[valid=0] Info fld=0x0, Current sd08:01: sns = 70  b
ASC=47 ASCQ= 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x18 0x00 0x00 0x00 0x00 0x47 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
 I/O error: dev 08:01, sector 127448
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
[valid=0] Info fld=0x0, Current sd08:01: sns = 70  b
ASC=47 ASCQ= 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x18 0x00 0x00 0x00 0x00 0x47 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
 I/O error: dev 08:01, sector 127456
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
[valid=0] Info fld=0x0, Current sd08:01: sns = 70  b
ASC=47 ASCQ= 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x18 0x00 0x00 0x00 0x00 0x47 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
 I/O error: dev 08:01, sector 61640
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
[valid=0] Info fld=0x0, Current sd08:01: sns = 70  b
ASC=47 ASCQ= 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x18 0x00 0x00 0x00 0x00 0x47 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
 I/O error: dev 08:01, sector 61648
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
[valid=0] Info fld=0x0, Current sd08:01: sns = 70  b
ASC=47 ASCQ= 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x18 0x00 0x00 0x00 0x00 0x47 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
 I/O error: dev 08:01, sector 61656
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
[valid=0] Info fld=0x0, Current sd08:01: sns = 70  b
ASC=47 ASCQ= 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x18 0x00 0x00 0x00 0x00 0x47 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
 I/O error: dev 08:01, sector 61664
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
[valid=0] Info fld=0x0, Current sd08:01: sns = 70  b
ASC=47 ASCQ= 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x18 0x00 0x00 0x00 0x00 0x47 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
 I/O error: dev 08:01, sector 61672
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
[valid=0] Info fld=0x0, Current sd08:01: sns = 70  b
ASC=47 ASCQ= 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x18 0x00 0x00 0x00 0x00 0x47 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
 I/O error: dev 08:01, sector 61680
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
[valid=0] Info fld=0x0, Current sd08:01: sns = 70  b
ASC=47 ASCQ= 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x18 0x00 0x00 0x00 0x00 0x47 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
 I/O error: dev 08:01, sector 61688
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
[valid=0] Info fld=0x0, Current sd08:01: sns = 70  b
ASC=47 ASCQ= 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x18 0x00 0x00 0x00 0x00 0x47 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
 I/O error: dev 08:01, sector 61696
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
[valid=0] Info fld=0x0, Current sd08:01: sns = 70  b
ASC=47 ASCQ= 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x18 0x00 0x00 0x00 0x00 0x47 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
 I/O error: dev 08:01, sector 61704
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
[valid=0] Info fld=0x0, Current sd08:01: sns = 70  b
ASC=47 ASCQ= 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x18 0x00 0x00 0x00 0x00 0x47 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
 I/O error: dev 08:01, sector 1404096
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
[valid=0] Info fld=0x0, Current sd08:01: sns = 70  b
ASC=47 ASCQ= 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x18 0x00 0x00 0x00 0x00 0x47 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
 I/O error: dev 08:01, sector 812576
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
[valid=0] Info fld=0x0, Current sd08:01: sns = 70  b
ASC=47 ASCQ= 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x18 0x00 0x00 0x00 0x00 0x47 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
 I/O error: dev 08:01, sector 4493984
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
[valid=0] Info fld=0x0, Current sd08:01: sns = 70  b
ASC=47 ASCQ= 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x18 0x00 0x00 0x00 0x00 0x47 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
 I/O error: dev 08:01, sector 812584
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
[valid=0] Info fld=0x0, Current sd08:01: sns = 70  b
ASC=47 ASCQ= 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x18 0x00 0x00 0x00 0x00 0x47 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
 I/O error: dev 08:01, sector 812592
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
[valid=0] Info fld=0x0, Current sd08:01: sns = 70  b
ASC=47 ASCQ= 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x18 0x00 0x00 0x00 0x00 0x47 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
 I/O error: dev 08:01, sector 812600
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
[valid=0] Info fld=0x0, Current sd08:01: sns = 70  b
ASC=47 ASCQ= 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x18 0x00 0x00 0x00 0x00 0x47 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
 I/O error: dev 08:01, sector 812608
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
[valid=0] Info fld=0x0, Current sd08:01: sns = 70  b
ASC=47 ASCQ= 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x18 0x00 0x00 0x00 0x00 0x47 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
 I/O error: dev 08:01, sector 812616
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
[valid=0] Info fld=0x0, Current sd08:03: sns = 70  b
ASC=47 ASCQ= 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x18 0x00 0x00 0x00 0x00 0x47 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
 I/O error: dev 08:03, sector 2097176
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
[valid=0] Info fld=0x0, Current sd08:03: sns = 70  b
ASC=47 ASCQ= 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x18 0x00 0x00 0x00 0x00 0x47 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
 I/O error: dev 08:03, sector 2097184
(scsi0:A:0): 6.600MB/s transfers (16bit)
(scsi0:A:0): 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
(scsi0:A:0): 6.600MB/s transfers (16bit)
(scsi0:A:0): 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
[valid=0] Info fld=0x0, Current sd08:01: sns = 70  b
ASC=47 ASCQ= 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x18 0x00 0x00 0x00 0x00 0x47 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
 I/O error: dev 08:01, sector 1572896
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
[valid=0] Info fld=0x0, Current sd08:03: sns = 70  b
ASC=47 ASCQ= 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x18 0x00 0x00 0x00 0x00 0x47 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
 I/O error: dev 08:03, sector 2097168
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
[valid=0] Info fld=0x0, Current sd08:03: sns = 70  b
ASC=47 ASCQ= 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x18 0x00 0x00 0x00 0x00 0x47 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
 I/O error: dev 08:03, sector 2107464
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
[valid=0] Info fld=0x0, Current sd08:03: sns = 70  b
ASC=47 ASCQ= 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x18 0x00 0x00 0x00 0x00 0x47 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
 I/O error: dev 08:03, sector 2097176
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
[valid=0] Info fld=0x0, Current sd08:03: sns = 70  b
ASC=47 ASCQ= 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x18 0x00 0x00 0x00 0x00 0x47 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
 I/O error: dev 08:03, sector 2097184
Detected scsi tape st0 at scsi0, channel 0, id 4, lun 0
st: bufsize 32768, wrt 30720, max init. buffers 4, s/g segs 16.
(scsi0:A:0): 6.600MB/s transfers (16bit)
(scsi0:A:0): 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
(scsi0:A:0): 6.600MB/s transfers (16bit)
(scsi0:A:0): 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
(scsi0:A:0): 6.600MB/s transfers (16bit)
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 02)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: e4000000-e5ffffff
	Prefetchable memory behind bridge: e6000000-e6ffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at f000 [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at d000 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

00:09.0 Multimedia audio controller: ESS Technology ES1969 Solo-1 Audiodrive
	Subsystem: ESS Technology Solo-1 Audio Adapter
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at d400 [size=16]
	Region 1: I/O ports at d800 [size=16]
	Region 2: I/O ports at dc00 [size=16]
	Region 3: I/O ports at e000 [size=4]
	Region 4: I/O ports at e400 [size=4]
	Capabilities: [c0] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Ethernet controller: 3Com Corporation 3c905 100BaseTX [Boomerang]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (750ns min, 2000ns max)
	Interrupt: pin A routed to IRQ 12
	Region 0: I/O ports at e800 [size=64]
	Expansion ROM at e7000000 [disabled] [size=64K]

00:0c.0 SCSI storage controller: Adaptec AIC-7880U
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min, 2000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at ec00 [disabled] [size=256]
	Region 1: Memory at e9000000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at e8000000 [disabled] [size=64K]

01:00.0 VGA compatible controller: NVidia / SGS Thomson (Joint Venture) Riva128 (rev 22) (prog-if 00 [VGA])
	Subsystem: Asustek Computer, Inc.: Unknown device 0100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 0
	Region 0: Memory at e4000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at e6000000 (32-bit, prefetchable) [size=16M]
	Expansion ROM at <unassigned> [disabled] [size=4M]
	Capabilities: [44] AGP version 1.0
		Status: RQ=4 SBA- 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

Adaptec AIC7xxx driver version: 6.1.5
aic7880: Wide Channel A, SCSI Id=7, 16/255 SCBs
Channel A Target 0 Negotiation Settings
	User: 40.000MB/s transfers (20.000MHz, offset 255, 16bit)
	Goal: 6.600MB/s transfers (16bit)
	Curr: 6.600MB/s transfers (16bit)
	Channel A Target 0 Lun 0 Settings
		Commands Queued 39957
		Commands Active 0
		Command Openings 64
		Max Tagged Openings 64
		Device Queue Frozen Count 0
Channel A Target 1 Negotiation Settings
	User: 40.000MB/s transfers (20.000MHz, offset 255, 16bit)
Channel A Target 2 Negotiation Settings
	User: 40.000MB/s transfers (20.000MHz, offset 255, 16bit)
Channel A Target 3 Negotiation Settings
	User: 40.000MB/s transfers (20.000MHz, offset 255, 16bit)
Channel A Target 4 Negotiation Settings
	User: 40.000MB/s transfers (20.000MHz, offset 255, 16bit)
	Goal: 20.000MB/s transfers (20.000MHz, offset 15)
	Curr: 5.000MB/s transfers (5.000MHz, offset 8)
	Channel A Target 4 Lun 0 Settings
		Commands Queued 7
		Commands Active 0
		Command Openings 1
		Max Tagged Openings 0
		Device Queue Frozen Count 0
Channel A Target 5 Negotiation Settings
	User: 40.000MB/s transfers (20.000MHz, offset 255, 16bit)
Channel A Target 6 Negotiation Settings
	User: 40.000MB/s transfers (20.000MHz, offset 255, 16bit)
Channel A Target 7 Negotiation Settings
	User: 40.000MB/s transfers (20.000MHz, offset 255, 16bit)
Channel A Target 8 Negotiation Settings
	User: 40.000MB/s transfers (20.000MHz, offset 255, 16bit)
Channel A Target 9 Negotiation Settings
	User: 40.000MB/s transfers (20.000MHz, offset 255, 16bit)
Channel A Target 10 Negotiation Settings
	User: 40.000MB/s transfers (20.000MHz, offset 255, 16bit)
Channel A Target 11 Negotiation Settings
	User: 40.000MB/s transfers (20.000MHz, offset 255, 16bit)
Channel A Target 12 Negotiation Settings
	User: 40.000MB/s transfers (20.000MHz, offset 255, 16bit)
Channel A Target 13 Negotiation Settings
	User: 40.000MB/s transfers (20.000MHz, offset 255, 16bit)
Channel A Target 14 Negotiation Settings
	User: 40.000MB/s transfers (20.000MHz, offset 255, 16bit)
Channel A Target 15 Negotiation Settings
	User: 40.000MB/s transfers (20.000MHz, offset 255, 16bit)
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DNES-309170W     Rev: SA30
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: HP       Model: HP35480A         Rev: T503
  Type:   Sequential-Access                ANSI SCSI revision: 02
sg0 scsi0 ch0 ID0 Lun0 ansi3 Direct-Access(0) IBM DNES-309170W SA30
    $_aspi = "sg0:Direct-Access:0" (or "0/0/0/0:Direct-Access:0")
sg1 scsi0 ch0 ID4 Lun0 ansi2 Sequential-Access(1) HP HP35480A T503
    $_aspi = "sg1:Sequential-Access:4" (or "0/0/4/0:Sequential-Access:4")
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux eiche 2.4.4 #2 Sun May 27 17:00:22 CEST 2001 i686 unknown
 
Gnu C                  2.95.2
Gnu make               3.79.1
binutils               2.9.5.0.24
util-linux             2.10m
mount                  2.10m
modutils               2.3.16
e2fsprogs              1.18
Linux C Library        x   1 root     root      4070406 Oct 19  2000 /lib/libc.so.6
Dynamic linker (ldd)   2.1.3
Procps                 2.0.6
Net-tools              1.56
Kbd                    0.99
Sh-utils               2.0
Modules Loaded         st sg serial 3c59x unix
Linux version 2.4.4 (root@eiche) (gcc version 2.95.2 19991024 (release)) #2 Sun May 27 17:00:22 CEST 2001

--------------969AA4B5704452246C7132D9--

