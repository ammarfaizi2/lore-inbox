Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262996AbTCSKK3>; Wed, 19 Mar 2003 05:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262997AbTCSKK3>; Wed, 19 Mar 2003 05:10:29 -0500
Received: from cs-ats40.donpac.ru ([217.107.128.161]:7172 "EHLO pazke")
	by vger.kernel.org with ESMTP id <S262996AbTCSKKX>;
	Wed, 19 Mar 2003 05:10:23 -0500
Date: Wed, 19 Mar 2003 13:21:17 +0300
To: linux-kernel@vger.kernel.org
Cc: linux-usb-users@lists.sourceforge.net
Subject: USB harddrive not working (2.4, 2.5)
Message-ID: <20030319102117.GA689@pazke>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	linux-usb-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Uname: Linux 2.5.65 i686 unknown
From: Andrey Panin <pazke@orbita1.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

ISD200 based hard drive bay doesn't work with 2.4 & 2.5, 
can someone assist me with it?

Kernel message log appended.

Best regards.

-- 
Andrey Panin		| Embedded systems software developer
pazke@orbita1.ru	| PGP key: wwwkeys.pgp.net

--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="usb.log"

drivers/usb/core/usb.c: registered new driver hub
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.0
PCI: Found IRQ 11 for device 00:1f.2
PCI: Setting latency timer of device 00:1f.2 to 64
uhci-hcd 00:1f.2: Intel Corp. 82801AA USB
uhci-hcd 00:1f.2: irq 11, io base 0000d000
uhci-hcd 00:1f.2: new USB bus registered, assigned bus number 1
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x101
hub 1-0:0: new USB device on port 2, assigned address 2
Initializing USB Mass Storage driver...
usb-storage: act_altsetting is 0
usb-storage: id_index calculated to be: 32
usb-storage: Array length appears to be: 81
usb-storage: Vendor: In-System
usb-storage: Product: USB/IDE Bridge (ATA/ATAPI)
usb-storage: USB Mass Storage device detected
usb-storage: Endpoints: In: 0xc336b934 Out: 0xc336b920 Int: 0xc336b948 (Period 32)
usb-storage: GetMaxLUN command result is 1, data is 0
usb-storage: Transport: Bulk
usb-storage: Protocol: ISD200 ATA/ATAPI
usb-storage: Allocating usb_ctrlrequest
usb-storage: Allocating URB
usb-storage: Allocating scatter-gather request block
usb-storage: ISD200 Initialization...
usb-storage: Entering isd200_get_inquiry_data
usb-storage: Entering isd200_manual_enum
usb-storage: Entering isd200_read_config
usb-storage: usb_stor_ctrl_transfer(): rq=02 rqtype=c0 value=0000 index=02 len=8
usb-storage: Status code 0; transferred 8/8
usb-storage: -- transfer complete
usb-storage:    Retrieved the following ISD200 Config Data:
usb-storage:       Event Notification: 0x0
usb-storage:       External Clock: 0x0
usb-storage:       ATA Init Timeout: 0x19
usb-storage:       ATAPI Command Block Size: 0x0
usb-storage:       Master/Slave Selection: 0x0
usb-storage:       ATAPI Reset: 0x0
usb-storage:       ATA Timing: 0x1
usb-storage:       ATA Major Command: 0x24
usb-storage:       ATA Minor Command: 0x24
usb-storage:       Init Status: 0x0
usb-storage:       Config Descriptor 2: 0x0
usb-storage:       Skip Device Boot: 0x0
usb-storage:       ATA 3 State Supsend: 0x0
usb-storage:       Descriptor Override: 0x8
usb-storage:       Last LUN Identifier: 0x0
usb-storage:       SRST Enable: 0x0
usb-storage: Leaving isd200_read_config 00000000
usb-storage:    isd200_action(ENUM,0xa0)
usb-storage: Bulk command S 0x43425355 T 0x0 Trg 0 LUN 1 L 0 F 0 CL 0
usb-storage: usb_stor_bulk_transfer_buf(): xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf(): xfer 13 bytes
usb-storage: Status code -32; transferred 0/13
usb-storage: clearing endpoint halt for pipe 0xc0010280
usb-storage: usb_stor_clear_halt: result=0
usb-storage: Attempting to get CSW (2nd try)...
usb-storage: usb_stor_bulk_transfer_buf(): xfer 13 bytes
usb-storage: Status code -32; transferred 0/13
usb-storage: clearing endpoint halt for pipe 0xc0010280
usb-storage: usb_stor_clear_halt: result=0
usb-storage: Bulk status result = 2
usb-storage:    isd200_action(0x04) error: 2
usb-storage:    Setting Master/Slave selection to 0
usb-storage: Entering isd200_write_config
usb-storage:    Writing the following ISD200 Config Data:
usb-storage:       Event Notification: 0x0
usb-storage:       External Clock: 0x0
usb-storage:       ATA Init Timeout: 0x19
usb-storage:       ATAPI Command Block Size: 0x0
usb-storage:       Master/Slave Selection: 0x0
usb-storage:       ATAPI Reset: 0x0
usb-storage:       ATA Timing: 0x1
usb-storage:       ATA Major Command: 0x24
usb-storage:       ATA Minor Command: 0x24
usb-storage:       Init Status: 0x0
usb-storage:       Config Descriptor 2: 0x0
usb-storage:       Skip Device Boot: 0x0
usb-storage:       ATA 3 State Supsend: 0x0
usb-storage:       Descriptor Override: 0x8
usb-storage:       Last LUN Identifier: 0x0
usb-storage:       SRST Enable: 0x0
usb-storage: usb_stor_ctrl_transfer(): rq=01 rqtype=40 value=0000 index=02 len=8
usb-storage: Status code 0; transferred 8/8
usb-storage: -- transfer complete
usb-storage:    ISD200 Config Data was written successfully
usb-storage: Leaving isd200_write_config 00000000
usb-storage: Leaving isd200_manual_enum 00000000
usb-storage: Protocol changed to: Transparent SCSI
usb-storage: Leaving isd200_get_inquiry_data 00000000
usb-storage: ISD200 Initialization complete
usb-storage: *** thread sleeping.
scsi0 : SCSI emulation for USB Mass Storage devices
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command INQUIRY (6 bytes)
usb-storage:  12 00 00 00 24 00
usb-storage: Bulk command S 0x43425355 T 0x1 Trg 0 LUN 0 L 36 F 128 CL 6
usb-storage: usb_stor_bulk_transfer_buf(): xfer 31 bytes
usb-storage: Status code -32; transferred 31/31
usb-storage: clearing endpoint halt for pipe 0xc0008200
usb-storage: usb_stor_clear_halt: result=0
usb-storage: Bulk command transfer result=2
usb-storage: -- transport indicates error, resetting
usb-storage: Bulk reset requested
usb-storage: command_abort() called
usb-storage: usb_stor_abort_transport called
usb-storage: Soft reset: clearing bulk-in endpoint halt
usb-storage: Soft reset: clearing bulk-out endpoint halt
usb-storage: Soft reset done
usb-storage: scsi cmd done, result=0x70000
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command TEST_UNIT_READY (6 bytes)
usb-storage:  00 00 00 00 00 00
usb-storage: Bulk command S 0x43425355 T 0x1 Trg 0 LUN 0 L 0 F 0 CL 6
usb-storage: usb_stor_bulk_transfer_buf(): xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf(): xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0x1 R 0 Stat 0x2
usb-storage: -- transport indicates error, resetting
usb-storage: Bulk reset requested
usb-storage: command_abort() called
usb-storage: usb_stor_abort_transport called
usb-storage: Soft reset: clearing bulk-in endpoint halt
usb-storage: Soft reset: clearing bulk-out endpoint halt
usb-storage: Soft reset done
usb-storage: scsi cmd done, result=0x70000
usb-storage: *** thread sleeping.
usb-storage: device_reset() called
usb-storage: Bulk reset requested
usb-storage: Soft reset: clearing bulk-in endpoint halt
usb-storage: Soft reset: clearing bulk-out endpoint halt
usb-storage: Soft reset done
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command TEST_UNIT_READY (6 bytes)
usb-storage:  00 00 00 00 00 00
usb-storage: Bulk command S 0x43425355 T 0x1 Trg 0 LUN 0 L 0 F 0 CL 6
usb-storage: usb_stor_bulk_transfer_buf(): xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf(): xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0x1 R 0 Stat 0x2
usb-storage: -- transport indicates error, resetting
usb-storage: Bulk reset requested
usb-storage: command_abort() called
usb-storage: usb_stor_abort_transport called
usb-storage: Soft reset: clearing bulk-in endpoint halt
usb-storage: Soft reset: clearing bulk-out endpoint halt
usb-storage: Soft reset done
usb-storage: scsi cmd done, result=0x70000
usb-storage: *** thread sleeping.
usb-storage: bus_reset() called
drivers/usb/core/hub.c: USB device not accepting new address (error=-22)
usb-storage: usb_reset_device returns -22
scsi: Device offlined - not ready after error recovery: host 0 channel 0 id 0 lun 0
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Bad target number (1/0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Bad target number (2/0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Bad target number (3/0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Bad target number (4/0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Bad target number (5/0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Bad target number (6/0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Bad target number (7/0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 2
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.

--RnlQjJ0d97Da+TV1--
