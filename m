Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751484AbWFJK7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484AbWFJK7M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 06:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbWFJK7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 06:59:12 -0400
Received: from lucidpixels.com ([66.45.37.187]:51655 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1751484AbWFJK7L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 06:59:11 -0400
Date: Sat, 10 Jun 2006 06:59:07 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: smartmontools-support@lists.sourceforge.net,
       Remy Card <Remy.Card@linux.org>, "Theodore Ts'o" <tytso@alum.mit.edu>,
       David Beattie <dbeattie@softhome.net>, linux-kernel@vger.kernel.org,
       apiszcz@solarrain.com
Subject: Re: The Death and Diagnosis of a Dying Hard Drive - Is S.M.A.R.T.
 useful?
In-Reply-To: <20060610105141.GE30775@lug-owl.de>
Message-ID: <Pine.LNX.4.64.0606100658130.26702@p34.internal.lan>
References: <Pine.LNX.4.64.0606100615500.15475@p34.internal.lan>
 <20060610105141.GE30775@lug-owl.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463747160-552632523-1149937147=:26702"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463747160-552632523-1149937147=:26702
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

# smartctl -d ata -H /dev/sdc
smartctl version 5.36 [i686-pc-linux-gnu] Copyright (C) 2002-6 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=3D=3D=3D START OF READ SMART DATA SECTION =3D=3D=3D
SMART overall-health self-assessment test result: PASSED

#

The --all output below:

smartctl version 5.36 [i686-pc-linux-gnu] Copyright (C) 2002-6 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=3D=3D=3D START OF INFORMATION SECTION =3D=3D=3D
Model Family:     Maxtor DiamondMax 10 family
Device Model:     Maxtor 6B250S0
Serial Number:    /* commented out */
Firmware Version: BANC1B70
User Capacity:    251,000,193,024 bytes
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   7
ATA Standard is:  ATA/ATAPI-7 T13 1532D revision 0
Local Time is:    Sat Jun 10 06:58:29 2006 EDT
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=3D=3D=3D START OF READ SMART DATA SECTION =3D=3D=3D
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x82)=09Offline data collection activity
 =09=09=09=09=09was completed without error.
 =09=09=09=09=09Auto Offline Data Collection: Enabled.
Self-test execution status:      (   0)=09The previous self-test routine co=
mpleted
 =09=09=09=09=09without error or no self-test has ever
 =09=09=09=09=09been run.
Total time to complete Offline=20
data collection: =09=09 (2283) seconds.
Offline data collection
capabilities: =09=09=09 (0x5b) SMART execute Offline immediate.
 =09=09=09=09=09Auto Offline data collection on/off support.
 =09=09=09=09=09Suspend Offline collection upon new
 =09=09=09=09=09command.
 =09=09=09=09=09Offline surface scan supported.
 =09=09=09=09=09Self-test supported.
 =09=09=09=09=09No Conveyance Self-test supported.
 =09=09=09=09=09Selective Self-test supported.
SMART capabilities:            (0x0003)=09Saves SMART data before entering
 =09=09=09=09=09power-saving mode.
 =09=09=09=09=09Supports SMART auto save timer.
Error logging capability:        (0x01)=09Error logging supported.
 =09=09=09=09=09General Purpose Logging supported.
Short self-test routine=20
recommended polling time: =09 (   2) minutes.
Extended self-test routine
recommended polling time: =09 ( 109) minutes.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  =
WHEN_FAILED RAW_VALUE
   3 Spin_Up_Time            0x0027   184   182   063    Pre-fail  Always  =
     -       25693
   4 Start_Stop_Count        0x0032   253   253   000    Old_age   Always  =
     -       91
   5 Reallocated_Sector_Ct   0x0033   253   253   063    Pre-fail  Always  =
     -       0
   6 Read_Channel_Margin     0x0001   253   253   100    Pre-fail  Offline =
     -       0
   7 Seek_Error_Rate         0x000a   253   252   000    Old_age   Always  =
     -       0
   8 Seek_Time_Performance   0x0027   252   237   187    Pre-fail  Always  =
     -       56515
   9 Power_On_Minutes        0x0032   218   218   000    Old_age   Always  =
     -       103h+42m
  10 Spin_Retry_Count        0x002b   249   248   157    Pre-fail  Always  =
     -       4
  11 Calibration_Retry_Count 0x002b   253   252   223    Pre-fail  Always  =
     -       0
  12 Power_Cycle_Count       0x0032   253   253   000    Old_age   Always  =
     -       191
192 Power-Off_Retract_Count 0x0032   253   253   000    Old_age   Always   =
    -       0
193 Load_Cycle_Count        0x0032   253   253   000    Old_age   Always   =
    -       0
194 Temperature_Celsius     0x0032   038   253   000    Old_age   Always   =
    -       32
195 Hardware_ECC_Recovered  0x000a   253   252   000    Old_age   Always   =
    -       312
196 Reallocated_Event_Count 0x0008   253   253   000    Old_age   Offline  =
    -       0
197 Current_Pending_Sector  0x0008   253   253   000    Old_age   Offline  =
    -       0
198 Offline_Uncorrectable   0x0008   253   253   000    Old_age   Offline  =
    -       0
199 UDMA_CRC_Error_Count    0x0008   199   199   000    Old_age   Offline  =
    -       0
200 Multi_Zone_Error_Rate   0x000a   253   252   000    Old_age   Always   =
    -       0
201 Soft_Read_Error_Rate    0x000a   253   252   000    Old_age   Always   =
    -       2
202 TA_Increase_Count       0x000a   253   252   000    Old_age   Always   =
    -       0
203 Run_Out_Cancel          0x000b   253   252   180    Pre-fail  Always   =
    -       0
204 Shock_Count_Write_Opern 0x000a   253   252   000    Old_age   Always   =
    -       0
205 Shock_Rate_Write_Opern  0x000a   253   252   000    Old_age   Always   =
    -       0
207 Spin_High_Current       0x002a   249   248   000    Old_age   Always   =
    -       4
208 Spin_Buzz               0x002a   253   252   000    Old_age   Always   =
    -       0
209 Offline_Seek_Performnce 0x0024   241   241   000    Old_age   Offline  =
    -       152
210 Unknown_Attribute       0x0032   253   252   000    Old_age   Always   =
    -       0
211 Unknown_Attribute       0x0032   253   252   000    Old_age   Always   =
    -       0
212 Unknown_Attribute       0x0032   253   253   000    Old_age   Always   =
    -       0

SMART Error Log Version: 1
ATA Error Count: 252 (device log contains only the most recent five errors)
 =09CR =3D Command Register [HEX]
 =09FR =3D Features Register [HEX]
 =09SC =3D Sector Count Register [HEX]
 =09SN =3D Sector Number Register [HEX]
 =09CL =3D Cylinder Low Register [HEX]
 =09CH =3D Cylinder High Register [HEX]
 =09DH =3D Device/Head Register [HEX]
 =09DC =3D Device Command Register [HEX]
 =09ER =3D Error register [HEX]
 =09ST =3D Status register [HEX]
Powered_Up_Time is measured from power on, and printed as
DDd+hh:mm:SS.sss where DD=3Ddays, hh=3Dhours, mm=3Dminutes,
SS=3Dsec, and sss=3Dmillisec. It "wraps" after 49.710 days.

Error 252 occurred at disk power-on lifetime: 11354 hours (473 days + 2 hou=
rs)
   When the command that caused the error occurred, the device was in an un=
known state.

   After command completion occurred, registers were:
   ER ST SC SN CL CH DH
   -- -- -- -- -- -- --
   78 00 08 b0 19 eb e0

   Commands leading to the command that caused the error were:
   CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
   -- -- -- -- -- -- -- --  ----------------  --------------------
   00 00 08 b0 19 eb e0 00      01:39:12.107  NOP [Abort queued commands]
   00 00 08 b0 19 eb e0 00      01:39:10.649  NOP [Abort queued commands]
   00 00 08 b0 19 eb e0 00      01:39:09.191  NOP [Abort queued commands]
   00 00 08 b0 19 eb e0 00      01:39:07.716  NOP [Abort queued commands]
   00 00 08 b0 19 eb e0 00      01:39:06.258  NOP [Abort queued commands]

Error 251 occurred at disk power-on lifetime: 11354 hours (473 days + 2 hou=
rs)
   When the command that caused the error occurred, the device was in an un=
known state.

   After command completion occurred, registers were:
   ER ST SC SN CL CH DH
   -- -- -- -- -- -- --
   78 00 08 b0 19 eb e0

   Commands leading to the command that caused the error were:
   CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
   -- -- -- -- -- -- -- --  ----------------  --------------------
   00 00 08 b0 19 eb e0 00      01:39:10.649  NOP [Abort queued commands]
   00 00 08 b0 19 eb e0 00      01:39:09.191  NOP [Abort queued commands]
   00 00 08 b0 19 eb e0 00      01:39:07.716  NOP [Abort queued commands]
   00 00 08 b0 19 eb e0 00      01:39:06.258  NOP [Abort queued commands]
   00 00 08 b0 19 eb e0 00      01:39:04.791  NOP [Abort queued commands]

SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining  LifeTime(hours)=
  LBA_of_first_error
# 1  Extended offline    Completed without error       00%     12117       =
  -
# 2  Short offline       Completed without error       00%     12116       =
  -
# 3  Extended offline    Completed without error       00%     12099       =
  -
# 4  Short offline       Completed without error       00%     12097       =
  -
# 5  Short offline       Completed without error       00%     12090       =
  -
# 6  Short offline       Completed without error       00%     12044       =
  -
# 7  Short offline       Completed without error       00%     12020       =
  -
# 8  Short offline       Completed without error       00%     11996       =
  -
# 9  Short offline       Completed without error       00%     11972       =
  -
#10  Short offline       Completed without error       00%     11949       =
  -
#11  Short offline       Completed without error       00%     11924       =
  -
#12  Short offline       Completed without error       00%     11900       =
  -
#13  Short offline       Completed without error       00%     11877       =
  -
#14  Short offline       Completed without error       00%     11853       =
  -
#15  Short offline       Completed without error       00%     11829       =
  -
#16  Short offline       Completed without error       00%     11806       =
  -
#17  Short offline       Completed without error       00%     11782       =
  -
#18  Short offline       Completed without error       00%     11758       =
  -
#19  Short offline       Completed without error       00%     11734       =
  -
#20  Short offline       Completed without error       00%     11711       =
  -
#21  Short offline       Completed without error       00%     11687       =
  -

SMART Selective self-test log data structure revision number 1
  SPAN  MIN_LBA  MAX_LBA  CURRENT_TEST_STATUS
     1        0        0  Not_testing
     2        0        0  Not_testing
     3        0        0  Not_testing
     4        0        0  Not_testing
     5        0        0  Not_testing
Selective self-test flags (0x0):
   After scanning selected spans, do NOT read-scan remainder of disk.
If Selective self-test is pending on power-up, resume after 0 minute delay.


On Sat, 10 Jun 2006, Jan-Benedict Glaw wrote:

> On Sat, 2006-06-10 06:23:32 -0400, Justin Piszcz <jpiszcz@lucidpixels.com=
> wrote:
>> SUMMARY:
>> I pose the following question in the subject, as over the years running
>> smartd and having failed disks, I have always first been alerted of bad
>> sectors and such through dmesg or logcheck.  Even with a bad disk I
>> currently have, smartd does not pickup any errors, except those with the
>> kernel writes to syslog.
>
> What do
>
> =09smartctl -H
> =09smartctl --all
>
> tell you?
>
> MfG, JBG
>
> --=20
> Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481           =
  _ O _
> "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg=
  _ _ O
> f=C3=BCr einen Freien Staat voll Freier B=C3=BCrger"  | im Internet! |   =
im Irak!   O O O
> ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCP=
A));
>
---1463747160-552632523-1149937147=:26702--
