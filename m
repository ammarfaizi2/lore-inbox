Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261538AbVGVJu4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbVGVJu4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 05:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbVGVJu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 05:50:56 -0400
Received: from mrqout1.tiscali.it ([195.130.225.11]:38341 "EHLO
	mrqout1.tiscali.it") by vger.kernel.org with ESMTP id S261538AbVGVJux convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 05:50:53 -0400
Date: Fri, 22 Jul 2005 11:50:48 +0200
Message-ID: <42D7AA0C0001489D@mail-8.mail.tiscali.sys>
In-Reply-To: <Pine.LNX.4.61.0507221133180.11709@yvahk01.tjqt.qr>
From: sampei02@tiscali.it
Subject: Re: DriveStatusError BadCRC
To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I run this command and I obtained:

smartctl version 5.33 [i386-redhat-linux-gnu] Copyright (C) 2002-4 Bruce
Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF INFORMATION SECTION ===
Device Model:     Maxtor 6Y080L0
Serial Number:    Y23TZR2C
Firmware Version: YAR41BW0
User Capacity:    81,964,302,336 bytes
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   7
ATA Standard is:  ATA/ATAPI-7 T13 1532D revision 0
Local Time is:    Fri Jul 22 11:46:20 2005 CEST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x80)	Offline data collection activity
					was never started.
					Auto Offline Data Collection: Enabled.
Self-test execution status:      (   0)	The previous self-test routine completed
					without error or no self-test has ever 
					been run.
Total time to complete Offline 
data collection: 		 ( 241) seconds.
Offline data collection
capabilities: 			 (0x5b) SMART execute Offline immediate.
					Auto Offline data collection on/off support.
					Suspend Offline collection upon new
					command.
					Offline surface scan supported.
					Self-test supported.
					No Conveyance Self-test supported.
					Selective Self-test supported.
SMART capabilities:            (0x0003)	Saves SMART data before entering
					power-saving mode.
					Supports SMART auto save timer.
Error logging capability:        (0x01)	Error logging supported.
					No General Purpose Logging support.
Short self-test routine 
recommended polling time: 	 (   2) minutes.
Extended self-test routine
recommended polling time: 	 (  37) minutes.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED
 WHEN_FAILED RAW_VALUE
  3 Spin_Up_Time            0x0027   252   252   063    Pre-fail  Always
      -       323
  4 Start_Stop_Count        0x0032   253   253   000    Old_age   Always
      -       3
  5 Reallocated_Sector_Ct   0x0033   253   253   063    Pre-fail  Always
      -       1
  6 Read_Channel_Margin     0x0001   253   253   100    Pre-fail  Offline
     -       0
  7 Seek_Error_Rate         0x000a   253   252   000    Old_age   Always
      -       0
  8 Seek_Time_Performance   0x0027   251   245   187    Pre-fail  Always
      -       37971
  9 Power_On_Minutes        0x0032   253   253   000    Old_age   Always
      -       95h+25m
 10 Spin_Retry_Count        0x002b   252   252   157    Pre-fail  Always
      -       0
 11 Calibration_Retry_Count 0x002b   252   252   223    Pre-fail  Always
      -       0
 12 Power_Cycle_Count       0x0032   253   253   000    Old_age   Always
      -       9
192 Power-Off_Retract_Count 0x0032   253   253   000    Old_age   Always
      -       0
193 Load_Cycle_Count        0x0032   253   253   000    Old_age   Always
      -       0
194 Temperature_Celsius     0x0032   253   253   000    Old_age   Always
      -       38
195 Hardware_ECC_Recovered  0x000a   253   252   000    Old_age   Always
      -       949
196 Reallocated_Event_Count 0x0008   253   253   000    Old_age   Offline
     -       0
197 Current_Pending_Sector  0x0008   253   253   000    Old_age   Offline
     -       0
198 Offline_Uncorrectable   0x0008   253   253   000    Old_age   Offline
     -       0
199 UDMA_CRC_Error_Count    0x0008   183   174   000    Old_age   Offline
     -       30
200 Multi_Zone_Error_Rate   0x000a   253   252   000    Old_age   Always
      -       0
201 Soft_Read_Error_Rate    0x000a   253   233   000    Old_age   Always
      -       75
202 TA_Increase_Count       0x000a   253   252   000    Old_age   Always
      -       0
203 Run_Out_Cancel          0x000b   253   252   180    Pre-fail  Always
      -       0
204 Shock_Count_Write_Opern 0x000a   253   252   000    Old_age   Always
      -       0
205 Shock_Rate_Write_Opern  0x000a   253   252   000    Old_age   Always
      -       0
207 Spin_High_Current       0x002a   252   252   000    Old_age   Always
      -       0
208 Spin_Buzz               0x002a   252   252   000    Old_age   Always
      -       0
209 Offline_Seek_Performnce 0x0024   196   196   000    Old_age   Offline
     -       0
 99 Unknown_Attribute       0x0004   253   253   000    Old_age   Offline
     -       0
100 Unknown_Attribute       0x0004   253   253   000    Old_age   Offline
     -       0
101 Unknown_Attribute       0x0004   253   253   000    Old_age   Offline
     -       0

SMART Error Log Version: 1
Warning: ATA error count 46 inconsistent with error log pointer 5

ATA Error Count: 46 (device log contains only the most recent five errors)
	CR = Command Register [HEX]
	FR = Features Register [HEX]
	SC = Sector Count Register [HEX]
	SN = Sector Number Register [HEX]
	CL = Cylinder Low Register [HEX]
	CH = Cylinder High Register [HEX]
	DH = Device/Head Register [HEX]
	DC = Device Command Register [HEX]
	ER = Error register [HEX]
	ST = Status register [HEX]
Powered_Up_Time is measured from power on, and printed as
DDd+hh:mm:SS.sss where DD=days, hh=hours, mm=minutes,
SS=sec, and sss=millisec. It "wraps" after 49.710 days.

Error 46 occurred at disk power-on lifetime: 89 hours (3 days + 17 hours)
  When the command that caused the error occurred, the device was in an unknown
state.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  84 51 c1 80 c9 2c e3  Error: ICRC, ABRT at LBA = 0x032cc980 = 53266816

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  ca 00 00 41 c9 2c e3 08      00:37:40.848  WRITE DMA
  ca 00 00 41 c8 2c e3 08      00:37:40.832  WRITE DMA
  ca 00 08 29 39 43 e3 08      00:37:40.832  WRITE DMA
  ca 00 08 d9 33 43 e3 08      00:37:40.832  WRITE DMA
  ca 00 08 c9 33 43 e3 08      00:37:40.832  WRITE DMA

Error 45 occurred at disk power-on lifetime: 89 hours (3 days + 17 hours)
  When the command that caused the error occurred, the device was in an unknown
state.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  84 51 00 39 8d 2c e3  Error: ICRC, ABRT at LBA = 0x032c8d39 = 53251385

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  ca 00 00 39 8d 2c e3 08      00:33:07.648  WRITE DMA
  ca 00 00 39 8c 2c e3 08      00:33:07.648  WRITE DMA
  c8 00 80 80 30 c9 e6 08      00:33:07.632  READ DMA
  ca 00 18 89 bf 40 e3 08      00:33:07.632  WRITE DMA
  ca 00 60 21 bf 40 e3 08      00:33:07.632  WRITE DMA

Error 44 occurred at disk power-on lifetime: 87 hours (3 days + 15 hours)
  When the command that caused the error occurred, the device was in an unknown
state.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  84 51 78 79 b9 2c e3  Error: ICRC, ABRT at LBA = 0x032cb979 = 53262713

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  ca 00 b8 39 b9 2c e3 08   2d+06:26:20.352  WRITE DMA
  ca 00 b8 39 b9 2c e3 08   2d+06:26:20.288  WRITE DMA
  10 00 ff 00 00 00 e0 08   2d+06:26:20.272  RECALIBRATE [OBS-4]
  ca 00 b8 39 b9 2c e3 08   2d+06:26:20.208  WRITE DMA
  ca 00 b8 39 b9 2c e3 08   2d+06:26:19.952  WRITE DMA

Error 43 occurred at disk power-on lifetime: 87 hours (3 days + 15 hours)
  When the command that caused the error occurred, the device was in an unknown
state.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  84 51 78 79 b9 2c e3  Error: ICRC, ABRT at LBA = 0x032cb979 = 53262713

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  ca 00 b8 39 b9 2c e3 08   2d+06:26:20.288  WRITE DMA
  10 00 ff 00 00 00 e0 08   2d+06:26:20.272  RECALIBRATE [OBS-4]
  ca 00 b8 39 b9 2c e3 08   2d+06:26:20.208  WRITE DMA
  ca 00 b8 39 b9 2c e3 08   2d+06:26:19.952  WRITE DMA
  ca 00 10 81 a6 31 e3 08   2d+06:26:19.952  WRITE DMA

Error 42 occurred at disk power-on lifetime: 87 hours (3 days + 15 hours)
  When the command that caused the error occurred, the device was in an unknown
state.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  84 51 78 79 b9 2c e3  Error: ICRC, ABRT at LBA = 0x032cb979 = 53262713

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  ca 00 b8 39 b9 2c e3 08   2d+06:26:20.208  WRITE DMA
  ca 00 b8 39 b9 2c e3 08   2d+06:26:19.952  WRITE DMA
  ca 00 10 81 a6 31 e3 08   2d+06:26:19.952  WRITE DMA
  ca 00 08 91 a5 31 e3 08   2d+06:26:19.952  WRITE DMA
  ca 00 10 b1 a3 31 e3 08   2d+06:26:19.952  WRITE DMA

SMART Self-test log structure revision number 1
No self-tests have been logged.  [To run self-tests, use: smartctl -t]


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


thanks


>-- Messaggio Originale --
>Date:	Fri, 22 Jul 2005 11:34:55 +0200 (MEST)
>From:	Jan Engelhardt <jengelh@linux01.gwdg.de>
>To:	sampei02@tiscali.it
>cc:	linux-kernel@vger.kernel.org
>Subject: Re: DriveStatusError BadCRC
>
>
>>I bought new Maxtor HD 80 GB but somthing Fedora Core 3 crashes giving
this
>>message:
>>hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
>>hda: dma_intr: Error=0x84 { DriveStatusError BadCRC }
>>ide: failed opcode was: unknown
>>hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
>>hda: dma_intr: Error=0x84 { DriveStatusError BadCRC }
>>ide: failed opcode was: unknown
>
>Does this happen on boot?
>
>Check your harddrive... smartctl -data -a /dev/hda and look for 
>199 UDMA_CRC_Error_Count    0x0008   198   193   000    Old_age   Offline
>     -
>and
>  Commands leading to the command that caused the error were:
>  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
>  -- -- -- -- -- -- -- --  ----------------  --------------------
>  c8 00 38 2f 8f 07 e4 08  43d+13:12:02.304  READ DMA
>
>
>
>Jan Engelhardt
>-- 
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/


__________________________________________________________________
TISCALI ADSL 1.25 MEGA
Solo con Tiscali Adsl navighi senza limiti e telefoni senza canone Telecom
a partire da  19,95 Euro/mese.
Attivala entro il 28 luglio, il primo MESE è GRATIS! CLICCA QUI.
http://abbonati.tiscali.it/adsl/sa/1e25flat_tc/



