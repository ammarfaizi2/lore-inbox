Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266637AbTAOPpr>; Wed, 15 Jan 2003 10:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266609AbTAOPpr>; Wed, 15 Jan 2003 10:45:47 -0500
Received: from smtp.kolej.mff.cuni.cz ([195.113.25.225]:38404 "EHLO
	smtp.kolej.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S266637AbTAOPpb>; Wed, 15 Jan 2003 10:45:31 -0500
X-Envelope-From: roubm9am@barbora.ms.mff.cuni.cz
Message-ID: <00a701c2bcae$34534900$551b71c3@krlis>
From: "Milan Roubal" <roubm9am@barbora.ms.mff.cuni.cz>
To: "Petr Sebor" <petr@scssoft.com>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Ross Biro" <rossb@google.com>
Cc: <linux-kernel@vger.kernel.org>
References: <068d01c29d97$f8b92160$551b71c3@krlis> <1039312135.27904.11.camel@irongate.swansea.linux.org.uk> <20021208234102.GA8293@scssoft.com> <021401c2a05d$f1c72c80$551b71c3@krlis>
Subject: Re: IDE feature request & problem
Date: Wed, 15 Jan 2003 16:53:04 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2720.3000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
here is new kernel message from the same system:
The system is alive and i am runnig raid with hot-spare disk,
so if you want any values from this system to make this problem
clean, feel free to ask.
    Thanx
    Milan Roubal
    roubm9am@barbora.ms.mff.cuni.cz

hdc: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
blk: queue c03f1430, I/O limit 4095Mb (mask 0xffffffff)
hdc: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hdc: status timeout: status=0xd0 { Busy }
hdc: drive not ready for command
ide1: reset timed-out, status=0xd0
hdc: status timeout: status=0xd0 { Busy }
hdc: drive not ready for command
ide1: reset timed-out, status=0xd0
end_request: I/O error, dev 16:01 (hdc), sector 57693696
raid5: Disk failure on hdc1, disabling device. Operation continuing on 8
devices
end_request: I/O error, dev 16:01 (hdc), sector 57693704
end_request: I/O error, dev 16:01 (hdc), sector 57693712
end_request: I/O error, dev 16:01 (hdc), sector 57693720
end_request: I/O error, dev 16:01 (hdc), sector 57693728
end_request: I/O error, dev 16:01 (hdc), sector 57693736
end_request: I/O error, dev 16:01 (hdc), sector 57693744
end_request: I/O error, dev 16:01 (hdc), sector 57693752

# smartctl -a /dev/hdc
Device: WDC WD1200JB-75CRA0  Supports ATA Version 5
Drive supports S.M.A.R.T. and is enabled
Check S.M.A.R.T. Passed

General Smart Values:
Off-line data collection status: (0x00) Offline data collection activity was
     never started

Total time to complete off-line
data collection:     (   0) Seconds

Offline data collection
Capabilities:       (0x00)     Off-line data collection not supported

Smart Capablilities:           (0x0000) automatic saving of SMART data
is not implemented

Error logging capability:        (0x00) Error logging NOT supported

Vendor Specific SMART Attributes with Thresholds:
Revision Number: 0
Attribute                    Flag     Value Worst Threshold Raw Value
Device does not support Error Logging
Device does not support Self Test Logging

# cat /proc/ide/hdc/smart_values
429d 845f 3720 365c 5038 2e23 2249 422d
291e 1b38 3025 3124 3639 4e47 674e 706d
948e e7e1 ffea fefc f7f8 6ef9 948f 7d60
6282 817e 9371 c996 e0de fcff fffe fefc
fcff e7fe f2ef 9b7a 569f 716b 5749 6a62
8675 9282 97a4 b997 a3af a6cc bb96 93ab
afb9 b58f 8eb5 a2bb af7b 80a8 a0bc c584
7a8e 76bb b474 8679 81bb bf96 9c7d f8b7
faf7 fcff 87fe aa9f 6d54 407a 6654 4233
335e 6b43 5340 4286 965b 6d54 64a7 b380
a282 bfb0 dad8 fcff fffe fefc fcff fffe
fefc b096 63b9 7f73 4e42 395e 6445 5f41
5e87 a980 a37a a8c3 ddd0 fcff fffe fefc
fcff fffe fefc f2eb 72f5 a99c 694b 2c78
4c3f 3323 3146 684a 6d4e 7192 b49c ead9
ffee fefc fcff fffe fefc efe5 70f2 a096
6047 2f6b 5241 3e2a 2e5d 7549 5536 3c89
935d 5337 348e 8e52 5737 3891 9459 5230
288e 8a4d 542b 308f 9359 5f36 369a 9b60
5f34 369a 9e62 6c3b 47a0 a87b 7c56 4fb3
ae71 6249 3ba7 9c56 5436 3e97 975f 5734
3c87 875c 5e46 3785 774d 4a35 4e74 8265
856c 75a0 ae94 a885 e5bd f1ec fcff fffe
fefc ac8d 55b4 7e74 523b 255c 4338 2b18
1b3b 482e 3a23 2c63 784a 5634 2e87 8556
5b35 498a 986e 825f 73a2 ac99 fcff fffe
fefc e9e1 69ec 928b 664b 3475 634b 3f28
2963 7143 583a 4c88 946f 8f68 b4a7 dad3
fcff fffe fefc fcff fffe fefc c89c 93cd
c7c3 b588 79ba afa5 a87c 83b7 c4b4 bf8b
a6cd d9ce e9d9 ffef fefc e8df 62ee a68c
7349 3995 8865 6137 338b 8e5d 582d 3690

# cat /proc/ide/hdc/smart_thresholds
9875 715f 5d98 9a6c 6a5e 599c 9966 6453
5a94 986c 735a 6399 a17c 7e64 4fa4 9166
5b44 4488 8859 6d54 629d ac7c 8664 5eb6
b382 7b53 2cab 7153 4d98 946c 6a4c 5192
af6a 7f63 64c0 bd8e 7f53 50a3 9b7c 7045
358a 745f 5b31 366e 6e53 523a 4574 8159
6756 7290 a783 9783 74b2 9f8e 795e 638a
9277 7d69 6da1 a980 7e67 6fb1 c787 b29a
b5f6 eee6 a06f 27ae 765c 6043 4580 7f5c
6660 5d8e 8d6c 6654 5486 8a66 7563 7999
af8a 9b82 82bb bba1 9c76 63af 998b 825f
6e90 9889 8372 6e96 917f 7357 577e 856e
725f 668f 9378 7a66 668d 877b 7060 6084
8b6f 776d 75a0 a381 8d7e 63a8 827e 6349
4b71 7664 6251 547b 7f5e 645e 6489 906c
7165 6991 977c 7b60 5292 876f 5f3e 4a77
8164 694d 4686 876b 7458 5d99 a175 6b57
6496 987a 6f58 4c82 7762 6e5b 6a8a a279
7e6d 6ea8 a87f 866e 6da1 a384 856e 7ca7
b493 967e 79b5 b193 987d 75b5 af92 8e71
72ad b08d 896f 6ead aa84 8b74 7eb2 bb95
a084 80be ba9c 997c 75b5 af95 8f6e 6aa8
a38d 8261 5a99 927b 785a 5f91 957a 775d
5c93 9072 6e52 4e91 916c 6c53 5b90 9170
6e5b 528d 8368 6047 427a 775f 6044 4a79
7c64 624d 467b 6f54 564b 4a71 6f58 5141
436b 7054 5a44 5376 8568 6d58 4d8d 8866
664d 4d89 8a65 664e 508b 8e69 634d 5189
8568 6950 5281 8769 614a 3f7f 7758 5a42
3f76 7259 5b3e 346e 644f 4a30 2f62 6645
4431 376d 7547 5441 498e 905e 5d45 358c
7f57 5835 3681 835b 5d3b 378a 8959 4e30

 # cat /proc/ide/hdc/settings
name    value   min    max      mode
----    -----   ---    ---      ----
acoustic                0               0               254             rw
address                 0               0               2               rw
bios_cyl                232581          0               65535           rw
bios_head               16              0               255             rw
bios_sect               63              0               63              rw
breada_readahead        8               0               255             rw
bswap                   0               0               1               r
current_speed           69              0               69              rw
failures                2               0               65535           rw
file_readahead          124             0               16384           rw
ide_scsi                0               0               1               rw
init_speed              69              0               69              rw
io_32bit                0               0               3               rw
keepsettings            0               0               1               rw
lun                     0               0               7               rw
max_failures            1               0               65535           rw
max_kb_per_request      128             1               255             rw
multcount               0               0               16              rw
nice1                   1               0               1               rw
nowerr                  0               0               1               rw
number                  2               0               3               rw
pio_mode                write-only      0               255             w
slow                    0               0               1               rw
unmaskirq               0               0               1               rw
using_dma               1               0               1               rw
wcache                  0               0               1               rw

 # cat /proc/ide/ide1/config
pci bus 00 device f9 vid 8086 did 248b channel 1
86 80 8b 24 07 00 80 02 02 8a 01 01 00 00 00 00
f1 01 00 00 f5 03 00 00 71 01 00 00 75 03 00 00
61 20 00 00 00 00 00 fc 00 00 00 00 d9 15 80 34
00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00
07 a3 07 a3 00 00 00 00 05 00 01 01 00 00 00 00
00 00 00 00 55 54 00 00 00 00 00 00 00 00 00 00
08 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 47 0f 00 00 00 00 00 00

# cat /proc/ide/hdc/model
WDC WD1200JB-75CRA0


----- Original Message -----
From: "Milan Roubal" <roubm9am@barbora.ms.mff.cuni.cz>
To: "Petr Sebor" <petr@scssoft.com>; "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Sent: Tuesday, December 10, 2002 4:07 PM
Subject: Re: IDE feature request & problem


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
> The problem is that utility from Western Digital marks this fault disks
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
> Nov 28 17:54:24 fileserver kernel: raid5: Disk failure on hdn1, disabling
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
> Nov 29 11:01:22 fileserver kernel: hdg: dma_intr: status=0x61 { DriveReady
> DeviceFault Error }
> Nov 29 11:01:22 fileserver kernel: hdg: dma_intr: error=0x04 {
> DriveStatusError }
> Nov 29 11:01:22 fileserver kernel: hdg: DMA disabled
> Nov 29 11:01:22 fileserver kernel: PDC202XX: Secondary channel reset.
> Nov 29 11:01:22 fileserver kernel: ide3: reset: success
> Nov 29 11:01:32 fileserver kernel: hdg: irq timeout: status=0xd0 { Busy }
> Nov 29 11:01:32 fileserver kernel: PDC202XX: Secondary channel reset.
> Nov 29 11:01:33 fileserver kernel: ide3: reset: success
> Nov 29 11:01:48 fileserver kernel: hdg: irq timeout: status=0xd0 { Busy }
> Nov 29 11:01:48 fileserver kernel: end_request: I/O error, dev 22:01
(hdg),
> sector 0
> Nov 29 11:01:48 fileserver kernel: raid5: Disk failure on hdg1, disabling
> device. Operation continuing on 8 devices
> Nov 29 11:01:48 fileserver kernel: hdg: status timeout: status=0xd0 {
Busy }
> Nov 29 11:01:48 fileserver kernel: PDC202XX: Secondary channel reset.
> Nov 29 11:01:48 fileserver kernel: hdg: drive not ready for command
> Nov 29 11:01:48 fileserver kernel: md: updating md0 RAID superblock on
> device
> Nov 29 11:01:48 fileserver kernel: md: hdc1 [events: 00000036]<6>(write)
> hdc1's sb offset: 117220672
> Nov 29 11:01:48 fileserver kernel: md: (skipping faulty hdg1 )
> Nov 29 11:01:48 fileserver kernel: md: hdb1 [events: 00000036]<6>(write)
> hdb1's sb offset: 117218176
> Nov 29 11:01:48 fileserver kernel: md: hdb1 [events: 00000036]<6>(write)
> hdb1's sb offset: 117218176
> Nov 29 11:01:48 fileserver kernel: md: hdt1 [events: 00000036]<6>(write)
> hdt1's sb offset: 117218176
> Nov 29 11:01:48 fileserver kernel: md: hdr1 [events: 00000036]<6>(write)
> hdr1's sb offset: 117218176
> Nov 29 11:01:48 fileserver kernel: md: hdp1 [events: 00000036]<6>(write)
> hdp1's sb offset: 117218176
> Nov 29 11:01:48 fileserver kernel: md: (skipping faulty hdn1 )
> Nov 29 11:01:48 fileserver kernel: md: hdj1 [events: 00000036]<6>(write)
> hdj1's sb offset: 117220672
> Nov 29 11:01:48 fileserver kernel: md: hdf1 [events: 00000036]<6>(write)
> hdf1's sb offset: 117218176
> Nov 29 11:01:48 fileserver kernel: md: recovery thread got woken up ...
> Nov 29 11:01:48 fileserver kernel: md0: no spare disk to reconstruct
> array! -- continuing in degraded mode
> Nov 29 11:01:48 fileserver kernel: md: recovery thread finished ...
> Nov 29 11:01:48 fileserver kernel: ide3: reset: success
> Nov 29 11:01:58 fileserver kernel: hdg: irq timeout: status=0xd0 { Busy }
> Nov 29 11:01:58 fileserver kernel: PDC202XX: Secondary channel reset.
> Nov 29 11:02:02 fileserver kernel: ide3: reset: success
> Nov 29 11:02:12 fileserver kernel: hdg: irq timeout: status=0xd0 { Busy }
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
> PCI: No IRQ known for interrupt pin A of device 00:1f.1. Probably buggy MP
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
>
>
> ----- Original Message -----
> From: "Petr Sebor" <petr@scssoft.com>
> To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
> Cc: <linux-kernel@vger.kernel.org>; <roubm9am@barbora.ms.mff.cuni.cz>
> Sent: Monday, December 09, 2002 12:41 AM
> Subject: Re: IDE feature request
>
>
> > On Sun, Dec 08, 2002 at 01:09:34AM +0000, Alan Cox wrote:
> > > Fix ide.c to generate a b c d e f and you should be able to get 16.
> >
> > Like this?
> >
> > -Petr
> >
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

