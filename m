Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266918AbSLKAWg>; Tue, 10 Dec 2002 19:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266927AbSLKAWg>; Tue, 10 Dec 2002 19:22:36 -0500
Received: from imrelay-2.zambeel.com ([209.240.48.8]:11279 "EHLO
	imrelay-2.zambeel.com") by vger.kernel.org with ESMTP
	id <S266918AbSLKAWN>; Tue, 10 Dec 2002 19:22:13 -0500
Message-ID: <233C89823A37714D95B1A891DE3BCE5202AB1B18@xch-a.win.zambeel.com>
From: Manish Lachwani <manish@Zambeel.com>
To: "'Milan Roubal '" <roubm9am@barbora.ms.mff.cuni.cz>,
       Manish Lachwani <manish@Zambeel.com>
Cc: "'linux-kernel@vger.kernel.org '" <linux-kernel@vger.kernel.org>
Subject: RE: IDE feature request & problem
Date: Tue, 10 Dec 2002 16:29:04 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 SMART data looks clean. 

Thanks
Manish

-----Original Message-----
From: Milan Roubal
To: Manish Lachwani
Cc: linux-kernel@vger.kernel.org
Sent: 12/10/02 4:13 PM
Subject: Re: IDE feature request & problem

Hi,
here it is from one good drive. When I removed that two disks, I am sure
there was
No Errors Logged at the end of the list, I will send details tommorow
when I
connect
them back inside the computer.
    Milan
Device: WDC WD1200JB-00DUA0  Supports ATA Version 6
Drive supports S.M.A.R.T. and is enabled
Check S.M.A.R.T. Passed

General Smart Values:
Off-line data collection status: (0x82) Offline data collection activity
                                        completed without error

Self-test execution status:      (   0) The previous self-test routine
completed
                                        without error or no self-test
has
ever
                                        been run

Total time to complete off-line
data collection:                 (4668) Seconds

Offline data collection
Capabilities:                    (0x7b) SMART EXECUTE OFF-LINE IMMEDIATE
                                        Automatic timer ON/OFF support
                                        Suspend Offline Collection upon
new
                                        command
                                        Offline surface scan supported
                                        Self-test supported

Smart Capablilities:           (0x0003) Saves SMART data before entering
                                        power-saving mode
                                        Supports SMART auto save timer

Error logging capability:        (0x01) Error logging supported

Short self-test routine
recommended polling time:        (   2) Minutes

Extended self-test routine
recommended polling time:        (  61) Minutes

Vendor Specific SMART Attributes with Thresholds:
Revision Number: 16
Attribute                    Flag     Value Worst Threshold Raw Value
(  1)Raw Read Error Rate     0x000b   200   200   051       000000000000
(  3)Spin Up Time            0x0007   253   253   021       00000000161a
(  4)Start Stop Count        0x0032   100   100   040       000000000000
(  5)Reallocated Sector Ct   0x0033   200   200   140       000000000000
(  7)Seek Error Rate         0x000b   200   200   051       000000000000
(  9)Power On Hours          0x0032   099   099   000       000000000435
( 10)Spin Retry Count        0x0013   100   253   051       000000000000
( 11)Unknown Attribute       0x0013   100   253   051       000000000000
( 12)Power Cycle Count       0x0032   100   100   000       000000000000
(196)Reallocated Event Count 0x0032   200   200   000       000000000000
(197)Current Pending Sector  0x0012   200   200   000       000000000000
(198)Offline Uncorrectable   0x0012   200   200   000       000000000000
(199)UDMA CRC Error Count    0x000a   200   253   000       000000000000
(200)Unknown Attribute       0x0009   200   200   051       000000000000
SMART Error Log:
SMART Error Logging Version: 1
No Errors Logged

----- Original Message -----
From: "Manish Lachwani" <manish@Zambeel.com>
To: "'Milan Roubal'" <roubm9am@barbora.ms.mff.cuni.cz>; "Petr Sebor"
<petr@scssoft.com>; "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Sent: Tuesday, December 10, 2002 8:50 PM
Subject: RE: IDE feature request & problem


> Can you also send the SMART data of the drive using smartctl?
>
> Thanks
> Manish
>
> -----Original Message-----
> From: Milan Roubal [mailto:roubm9am@barbora.ms.mff.cuni.cz]
> Sent: Tuesday, December 10, 2002 7:08 AM
> To: Petr Sebor; Alan Cox
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: IDE feature request & problem
>
>
> Wow, GREAT!, its really working :)) Thanx a lot.
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> ide2 at 0x3020-0x3027,0x3016 on irq 48
> ide3 at 0x3018-0x301f,0x3012 on irq 48
> ide4 at 0x5040-0x5047,0x5036 on irq 96
> ide7 at 0x5050-0x5057,0x504a on irq 100
> ide8 at 0x5070-0x5077,0x5066 on irq 104
> ide9 at 0x5068-0x506f,0x5062 on irq 104
> idea at 0x6020-0x6027,0x6016 on irq 72
> ideb at 0x6018-0x601f,0x6012 on irq 72
>
> I have got another problem. In my log I have got this messages.
> My disks are WDC WD1200JB-00DUA0, ATA DISK drive
> The problem is that utility from Western Digital marks this fault
disks
> ok - so where should I look for problem? Thanx a lot. Milan
> Nov 28 17:54:04 fileserver kernel: hdn: dma_intr: status=0x11 {
SeekComplete
> Error }
> Nov 28 17:54:04 fileserver kernel: hdn: dma_intr: error=0x04 {
> DriveStatusError }
> Nov 28 17:54:04 fileserver kernel: hdn: status error: status=0x11 {
> SeekComplete Error }
> Nov 28 17:54:04 fileserver kernel: hdn: status error: error=0x04 {
> DriveStatusError }
> Nov 28 17:54:04 fileserver kernel: hdn: drive not ready for command
> Nov 28 17:54:04 fileserver kernel: hdn: status error: status=0x11 {
> SeekComplete Error }
> Nov 28 17:54:04 fileserver kernel: hdn: status error: error=0x04 {
> DriveStatusError }
> Nov 28 17:54:04 fileserver kernel: hdn: drive not ready for command
> Nov 28 17:54:04 fileserver kernel: hdn: status error: status=0x11 {
> SeekComplete Error }
> Nov 28 17:54:04 fileserver kernel: hdn: status error: error=0x04 {
> DriveStatusError }
> Nov 28 17:54:04 fileserver kernel: hdn: DMA disabled
> Nov 28 17:54:04 fileserver kernel: PDC202XX: Primary channel reset.
> Nov 28 17:54:04 fileserver kernel: hdn: drive not ready for command
> Nov 28 17:54:04 fileserver kernel: klogd 1.4.1, ---------- state
> change ----------
> Nov 28 17:54:04 fileserver kernel: Inspecting /boot/System.map
> Nov 28 17:54:04 fileserver kernel: Symbol table has incorrect version
> number.
> Nov 28 17:54:04 fileserver kernel: Cannot find map file.
> Nov 28 17:54:04 fileserver kernel: Loaded 489 symbols from 13 modules.
> Nov 28 17:54:04 fileserver kernel: ide6: reset: master: error (0x7f?)
> Nov 28 17:54:14 fileserver kernel: hdn: lost interrupt
> Nov 28 17:54:14 fileserver kernel: hdn: set_multmode: status=0x7f {
> DriveReady DeviceFault SeekComplete DataRequest CorrectedError Index
Error }
> Nov 28 17:54:14 fileserver kernel: hdn: set_multmode: error=0x7f {
> DriveStatusError UncorrectableError SectorIdNotFound TrackZeroNotFound
> AddrMarkNotFound }, LBAsect=8830595334015, high=526344, low=8355711,
> sector=196817664
> Nov 28 17:54:24 fileserver kernel: hdn: lost interrupt
> Nov 28 17:54:24 fileserver kernel: hdn: recal_intr: status=0x7f {
DriveReady
> DeviceFault SeekComplete DataRequest CorrectedError Index Error }
> Nov 28 17:54:24 fileserver kernel: hdn: recal_intr: error=0x7f {
> DriveStatusError UncorrectableError SectorIdNotFound TrackZeroNotFound
> AddrMarkNotFound }, LBAsect=8830595334015, high=526344, low=8355711,
> sector=196817664
> Nov 28 17:54:24 fileserver kernel: PDC202XX: Primary channel reset.
> Nov 28 17:54:24 fileserver kernel: ide6: reset: master: error (0x7f?)
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196817664
> Nov 28 17:54:24 fileserver kernel: raid5: Disk failure on hdn1,
disabling
> device. Operation continuing on 8 devices
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196817672
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196817680
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196817688
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196817696
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196817704
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196817712
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196817720
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196817728
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196817736
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196817744
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196817752
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196817760
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196817768
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196817776
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196817784
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196817792
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196817800
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196817808
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196817816
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196817824
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196817832
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196817840
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196817848
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196817856
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196817864
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196817872
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196817880
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196817888
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196817896
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196817904
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196817912
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196817920
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196817928
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196817936
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196817944
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196817952
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196817960
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196817968
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196817976
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196817984
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196817992
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818000
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818008
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818016
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818024
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818032
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818040
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818048
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818056
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818064
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818072
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818080
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818088
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818096
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818104
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818112
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818120
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818128
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818136
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818144
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818152
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818160
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818168
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818176
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818184
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818192
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818200
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818208
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818216
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818224
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818232
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818240
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818248
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818256
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818264
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818272
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818280
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818288
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818296
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818304
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818312
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818320
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818328
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818336
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818344
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818352
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818360
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818368
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818376
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818384
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818392
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818400
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818408
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818416
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818424
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818432
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818440
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818448
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818456
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818464
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818472
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818480
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818488
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818496
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818504
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818512
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818520
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818528
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818536
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818544
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818552
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818560
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818568
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818576
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818584
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818592
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818600
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818608
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818616
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818624
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818632
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818640
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818648
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818656
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818664
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818672
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818680
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818688
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818696
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818704
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818712
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818720
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818728
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818736
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818744
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818752
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818760
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818768
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818776
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818784
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818792
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818800
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818808
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818816
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818824
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818832
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818840
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818848
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818856
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818864
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818872
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818880
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818888
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818896
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818904
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818912
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818920
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818928
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818936
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818944
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818952
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818960
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818968
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818976
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818984
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196818992
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196819000
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196819008
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196819016
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196819024
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196819032
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196819040
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196819048
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196819056
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196819064
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196819072
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196819080
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196819088
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196819096
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196819104
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196819112
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196819120
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196819128
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196819136
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196819144
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196819152
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196819160
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196819168
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196819176
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196819184
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196819192
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196819200
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196819208
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196819216
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196819224
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196819232
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196819240
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196819248
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196819256
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196819264
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196819272
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196819280
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196819288
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196819296
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196819304
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196819312
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196819320
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196819328
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196819336
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196819344
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196819352
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196819360
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196819368
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196819376
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196819384
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196819392
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196819400
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196819408
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196819416
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196819424
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196819432
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196819440
> Nov 28 17:54:24 fileserver kernel: end_request: I/O error, dev 58:41
(hdn),
> sector 196819448
>
> Nov 29 11:01:22 fileserver kernel: hdg: dma_intr: status=0x61 {
DriveReady
> DeviceFault Error }
> Nov 29 11:01:22 fileserver kernel: hdg: dma_intr: error=0x04 {
> DriveStatusError }
> Nov 29 11:01:22 fileserver kernel: hdg: DMA disabled
> Nov 29 11:01:22 fileserver kernel: PDC202XX: Secondary channel reset.
> Nov 29 11:01:22 fileserver kernel: ide3: reset: success
> Nov 29 11:01:32 fileserver kernel: hdg: irq timeout: status=0xd0 {
Busy }
> Nov 29 11:01:32 fileserver kernel: PDC202XX: Secondary channel reset.
> Nov 29 11:01:33 fileserver kernel: ide3: reset: success
> Nov 29 11:01:48 fileserver kernel: hdg: irq timeout: status=0xd0 {
Busy }
> Nov 29 11:01:48 fileserver kernel: end_request: I/O error, dev 22:01
(hdg),
> sector 0
> Nov 29 11:01:48 fileserver kernel: raid5: Disk failure on hdg1,
disabling
> device. Operation continuing on 8 devices
> Nov 29 11:01:48 fileserver kernel: hdg: status timeout: status=0xd0 {
Busy }
> Nov 29 11:01:48 fileserver kernel: PDC202XX: Secondary channel reset.
> Nov 29 11:01:48 fileserver kernel: hdg: drive not ready for command
> Nov 29 11:01:48 fileserver kernel: md: updating md0 RAID superblock on
> device
> Nov 29 11:01:48 fileserver kernel: md: hdc1 [events:
00000036]<6>(write)
> hdc1's sb offset: 117220672
> Nov 29 11:01:48 fileserver kernel: md: (skipping faulty hdg1 )
> Nov 29 11:01:48 fileserver kernel: md: hdb1 [events:
00000036]<6>(write)
> hdb1's sb offset: 117218176
> Nov 29 11:01:48 fileserver kernel: md: hdb1 [events:
00000036]<6>(write)
> hdb1's sb offset: 117218176
> Nov 29 11:01:48 fileserver kernel: md: hdt1 [events:
00000036]<6>(write)
> hdt1's sb offset: 117218176
> Nov 29 11:01:48 fileserver kernel: md: hdr1 [events:
00000036]<6>(write)
> hdr1's sb offset: 117218176
> Nov 29 11:01:48 fileserver kernel: md: hdp1 [events:
00000036]<6>(write)
> hdp1's sb offset: 117218176
> Nov 29 11:01:48 fileserver kernel: md: (skipping faulty hdn1 )
> Nov 29 11:01:48 fileserver kernel: md: hdj1 [events:
00000036]<6>(write)
> hdj1's sb offset: 117220672
> Nov 29 11:01:48 fileserver kernel: md: hdf1 [events:
00000036]<6>(write)
> hdf1's sb offset: 117218176
> Nov 29 11:01:48 fileserver kernel: md: recovery thread got woken up
...
> Nov 29 11:01:48 fileserver kernel: md0: no spare disk to reconstruct
> array! -- continuing in degraded mode
> Nov 29 11:01:48 fileserver kernel: md: recovery thread finished ...
> Nov 29 11:01:48 fileserver kernel: ide3: reset: success
> Nov 29 11:01:58 fileserver kernel: hdg: irq timeout: status=0xd0 {
Busy }
> Nov 29 11:01:58 fileserver kernel: PDC202XX: Secondary channel reset.
> Nov 29 11:02:02 fileserver kernel: ide3: reset: success
> Nov 29 11:02:12 fileserver kernel: hdg: irq timeout: status=0xd0 {
Busy }
> Nov 29 11:02:12 fileserver kernel: end_request: I/O error, dev 22:01
(hdg),
> sector 165669889
>
> Part of dmesg:
> Uniform Multi-Platform E-IDE driver Revision: 6.31
> ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
> PIIX4: IDE controller on PCI bus 00 dev f9
> PCI: Enabling device 00:1f.1 (0005 -> 0007)
> PCI: No IRQ known for interrupt pin A of device 00:1f.1. Probably
buggy MP
> table.
> PIIX4: chipset revision 2
> PIIX4: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0x2060-0x2067, BIOS settings: hda:pio, hdb:pio
>     ide1: BM-DMA at 0x2068-0x206f, BIOS settings: hdc:pio, hdd:pio
> PDC20269: IDE controller on PCI bus 02 dev 08
> PDC20269: chipset revision 2
> PDC20269: not 100% native mode: will probe irqs later
>     ide2: BM-DMA at 0x3000-0x3007, BIOS settings: hde:pio, hdf:pio
>     ide3: BM-DMA at 0x3008-0x300f, BIOS settings: hdg:pio, hdh:pio
> PDC20269: IDE controller on PCI bus 05 dev 08
> PDC20269: chipset revision 2
> PDC20269: not 100% native mode: will probe irqs later
>     ide4: BM-DMA at 0x5000-0x5007, BIOS settings: hdi:pio, hdj:pio
>     ide5: BM-DMA at 0x5008-0x500f, BIOS settings: hdk:pio, hdl:pio
> PDC20269: IDE controller on PCI bus 05 dev 10
> PDC20269: chipset revision 2
> PDC20269: not 100% native mode: will probe irqs later
>     ide6: BM-DMA at 0x5010-0x5017, BIOS settings: hdm:pio, hdn:pio
>     ide7: BM-DMA at 0x5018-0x501f, BIOS settings: hdo:pio, hdp:pio
> PDC20269: IDE controller on PCI bus 05 dev 18
> PDC20269: chipset revision 2
> PDC20269: not 100% native mode: will probe irqs later
>     ide8: BM-DMA at 0x5020-0x5027, BIOS settings: hdq:pio, hdr:pio
>     ide9: BM-DMA at 0x5028-0x502f, BIOS settings: hds:pio, hdt:pio
> PDC20269: IDE controller on PCI bus 06 dev 08
> PDC20269: chipset revision 2
> PDC20269: not 100% native mode: will probe irqs later
>     idea: BM-DMA at 0x6000-0x6007, BIOS settings: hdu:pio, hdv:pio
>     ideb: BM-DMA at 0x6008-0x600f, BIOS settings: hdw:pio, hdx:pio
> hda: ST340016A, ATA DISK drive
> keyboard: Timeout - AT keyboard not present?(ed)
> hdc: WDC WD1200JB-75CRA0, ATA DISK drive
> keyboard: Timeout - AT keyboard not present?(f4)
> hdf: WDC WD1200JB-00DUA0, ATA DISK drive
> hdg: WDC WD1200JB-00DUA0, ATA DISK drive
> hdj: WDC WD1200JB-00DUA0, ATA DISK drive
> hdp: WDC WD1200JB-00DUA0, ATA DISK drive
> hdr: WDC WD1200JB-00DUA0, ATA DISK drive
> hdt: WDC WD1200JB-00DUA0, ATA DISK drive
> hdv: WDC WD1200JB-00DUA0, ATA DISK drive
> hdx: WDC WD1200JB-00DUA0, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> ide2 at 0x3020-0x3027,0x3016 on irq 48
> ide3 at 0x3018-0x301f,0x3012 on irq 48
> ide4 at 0x5040-0x5047,0x5036 on irq 96
> ide7 at 0x5050-0x5057,0x504a on irq 100
> ide8 at 0x5070-0x5077,0x5066 on irq 104
> ide9 at 0x5068-0x506f,0x5062 on irq 104
> idea at 0x6020-0x6027,0x6016 on irq 72
> ideb at 0x6018-0x601f,0x6012 on irq 72
>
