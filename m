Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267448AbTAMIRk>; Mon, 13 Jan 2003 03:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267457AbTAMIRj>; Mon, 13 Jan 2003 03:17:39 -0500
Received: from smtp.rhein-zeitung.DE ([212.7.160.14]:14991 "EHLO
	smtp.rhein-zeitung.DE") by vger.kernel.org with ESMTP
	id <S267448AbTAMIRE>; Mon, 13 Jan 2003 03:17:04 -0500
Date: Mon, 13 Jan 2003 09:25:53 +0100
From: Oliver Graf <ograf@rz-online.net>
To: linux-kernel@vger.kernel.org
Subject: usb-storage problem with >2.4.19
Message-ID: <20030113082553.GA22704@rz-online.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-PGP-Key: http://wwwkeys.de.pgp.net:11371/pks/lookup?op=get&search=0x0B17417A
X-RIPE-Key-Cert: PGPKEY-0B17417A
Organization: KEVAG Telekom GmbH / RZ-Online GmbH
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

If have problems with a Tevion 6in1 Flash Card Reader and newer 2.4
kernels.

With 2.4.19(-ac?) everthing works fine. The reader and its four
subdevices are detectet and accessible. But starting with 2.4.20 the
kernel will only detect one (the first) subdevice of the reader.

I tried to find the changes that caused that behaviour, but it did not
jump at me, so I try here, perhaps someone with more intimate knowledge
of usb stuff can find the problem.

If you should test something, give some additional logs, etc., just mail
me.

Regards,
  Oliver.

P.S.: The outputs are of 2.4.19-ac4 and 2.4.21-pre3-ac3, but the problem
will happen with any patch after ands including 2.4.20. config is
usb-storage as module + debugging, plus all special device handling
options activated. but it will happen witrh all specials deactivated
too.

P.P.S.: The logs show a normal attach / detach action with the reader,
as you can see.

--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="usb-devices.working-2.4.19-ac4"

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 4
B:  Alloc=146/900 us (16%), #Int=  3, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB OHCI Root Hub
S:  SerialNumber=f882b000
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms
T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  3 Spd=12  MxCh= 5
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=046a ProdID=0003 Rev= 2.10
S:  Manufacturer=Cherry GmbH
S:  Product=Cherry GmbH USB-Hub
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=255ms
T:  Bus=01 Lev=02 Prnt=03 Port=00 Cnt=01 Dev#=  4 Spd=1.5 MxCh= 0
D:  Ver= 1.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=046d ProdID=c401 Rev= 2.10
S:  Manufacturer=Logitech
S:  Product=USB-PS/2 Trackball
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr= 50mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=hid
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=10ms
T:  Bus=01 Lev=02 Prnt=03 Port=02 Cnt=02 Dev#=  6 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=16 #Cfgs=  1
P:  Vendor=0483 ProdID=1307 Rev= 1.33
S:  Manufacturer=Generic
S:  Product=USBMass Storage Device
S:  SerialNumber=Mass Storage - 7
C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=08(stor.) Sub=06 Prot=50 Driver=usb-storage
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
T:  Bus=01 Lev=02 Prnt=03 Port=04 Cnt=03 Dev#=  5 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=046a ProdID=0001 Rev= 2.10
S:  Manufacturer=Cherry GmbH
S:  Product=Cherry GmbH USB-Keyboard
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=01 Driver=hid
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=10ms

--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="usb-devices.notwork-2.4.21-pre3-ac3"

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 4
B:  Alloc=146/900 us (16%), #Int=  3, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB OHCI Root Hub
S:  SerialNumber=f882b000
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms
T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  3 Spd=12  MxCh= 5
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=046a ProdID=0003 Rev= 2.10
S:  Manufacturer=Cherry GmbH
S:  Product=Cherry GmbH USB-Hub
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=255ms
T:  Bus=01 Lev=02 Prnt=03 Port=00 Cnt=01 Dev#=  4 Spd=1.5 MxCh= 0
D:  Ver= 1.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=046d ProdID=c401 Rev= 2.10
S:  Manufacturer=Logitech
S:  Product=USB-PS/2 Trackball
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr= 50mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=hid
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=10ms
T:  Bus=01 Lev=02 Prnt=03 Port=04 Cnt=02 Dev#=  5 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=046a ProdID=0001 Rev= 2.10
S:  Manufacturer=Cherry GmbH
S:  Product=Cherry GmbH USB-Keyboard
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=01 Driver=hid
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=10ms

--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="usb-storage.working-2.4.19-ac4.log"

Jan 13 09:04:01 maus kernel: hub.c: USB new device connect on bus1/2/3, assigned device number 6
Jan 13 09:04:01 maus kernel: Initializing USB Mass Storage driver...
Jan 13 09:04:01 maus kernel: usb.c: registered new driver usb-storage
Jan 13 09:04:01 maus kernel: usb-storage: act_altsettting is 0
Jan 13 09:04:01 maus kernel: usb-storage: id_index calculated to be: 85
Jan 13 09:04:01 maus kernel: usb-storage: Array length appears to be: 87
Jan 13 09:04:01 maus kernel: usb-storage: USB Mass Storage device detected
Jan 13 09:04:01 maus kernel: usb-storage: Endpoints: In: 0xf794a180 Out: 0xf794a194 Int: 0x00000000 (Period 0)
Jan 13 09:04:01 maus kernel: usb-storage: New GUID 04831307fffe9ffffffffe97
Jan 13 09:04:01 maus kernel: usb-storage: GetMaxLUN command result is 1, data is 3
Jan 13 09:04:01 maus kernel: usb-storage: Transport: Bulk
Jan 13 09:04:01 maus kernel: usb-storage: Protocol: Transparent SCSI
Jan 13 09:04:01 maus kernel: usb-storage: *** thread sleeping.
Jan 13 09:04:01 maus kernel: scsi1 : SCSI emulation for USB Mass Storage devices
Jan 13 09:04:01 maus kernel: usb-storage: queuecommand() called
Jan 13 09:04:01 maus kernel: usb-storage: *** thread awakened.
Jan 13 09:04:01 maus kernel: usb-storage: Command INQUIRY (6 bytes)
Jan 13 09:04:01 maus kernel: usb-storage: 12 00 00 00 ff 00 00 00 00 a0 eb f7
Jan 13 09:04:01 maus kernel: usb-storage: Bulk command S 0x43425355 T 0xe Trg 0 LUN 0 L 255 F 128 CL 6
Jan 13 09:04:01 maus kernel: usb-storage: Bulk command transfer result=0
Jan 13 09:04:01 maus kernel: usb-storage: usb_stor_transfer_partial(): xfer 255 bytes
Jan 13 09:04:01 maus kernel: usb-storage: usb_stor_bulk_msg() returned 0 xferred 96/255
Jan 13 09:04:01 maus kernel: usb-storage: Bulk data transfer result 0x1
Jan 13 09:04:01 maus kernel: usb-storage: Attempting to get CSW...
Jan 13 09:04:01 maus kernel: usb-storage: Bulk status result = 0
Jan 13 09:04:01 maus kernel: usb-storage: Bulk status Sig 0x53425355 T 0xe R 159 Stat 0x0
Jan 13 09:04:01 maus kernel: usb-storage: Fixing INQUIRY data to show SCSI rev 2
Jan 13 09:04:01 maus kernel: usb-storage: scsi cmd done, result=0x0
Jan 13 09:04:01 maus kernel: usb-storage: *** thread sleeping.
Jan 13 09:04:01 maus kernel: usb-storage: queuecommand() called
Jan 13 09:04:01 maus kernel: usb-storage: *** thread awakened.
Jan 13 09:04:01 maus kernel: usb-storage: Command INQUIRY (6 bytes)
Jan 13 09:04:01 maus kernel: usb-storage: 12 20 00 00 ff 00 00 00 00 a0 eb f7
Jan 13 09:04:01 maus kernel: usb-storage: Bulk command S 0x43425355 T 0xf Trg 0 LUN 1 L 255 F 128 CL 6
Jan 13 09:04:01 maus kernel: usb-storage: Bulk command transfer result=0
Jan 13 09:04:01 maus kernel: usb-storage: usb_stor_transfer_partial(): xfer 255 bytes
Jan 13 09:04:01 maus kernel: usb-storage: usb_stor_bulk_msg() returned 0 xferred 96/255
Jan 13 09:04:01 maus kernel: usb-storage: Bulk data transfer result 0x1
Jan 13 09:04:01 maus kernel: usb-storage: Attempting to get CSW...
Jan 13 09:04:01 maus kernel: usb-storage: Bulk status result = 0
Jan 13 09:04:01 maus kernel: usb-storage: Bulk status Sig 0x53425355 T 0xf R 159 Stat 0x0
Jan 13 09:04:01 maus kernel: usb-storage: Fixing INQUIRY data to show SCSI rev 2
Jan 13 09:04:01 maus kernel: usb-storage: scsi cmd done, result=0x0
Jan 13 09:04:01 maus kernel: usb-storage: *** thread sleeping.
Jan 13 09:04:01 maus kernel: usb-storage: queuecommand() called
Jan 13 09:04:01 maus kernel: usb-storage: *** thread awakened.
Jan 13 09:04:01 maus kernel: usb-storage: Command INQUIRY (6 bytes)
Jan 13 09:04:01 maus kernel: usb-storage: 12 40 00 00 ff 00 00 00 00 a0 eb f7
Jan 13 09:04:01 maus kernel: usb-storage: Bulk command S 0x43425355 T 0x10 Trg 0 LUN 2 L 255 F 128 CL 6
Jan 13 09:04:01 maus kernel: usb-storage: Bulk command transfer result=0
Jan 13 09:04:01 maus kernel: usb-storage: usb_stor_transfer_partial(): xfer 255 bytes
Jan 13 09:04:01 maus kernel: usb-storage: usb_stor_bulk_msg() returned 0 xferred 96/255
Jan 13 09:04:01 maus kernel: usb-storage: Bulk data transfer result 0x1
Jan 13 09:04:01 maus kernel: usb-storage: Attempting to get CSW...
Jan 13 09:04:01 maus kernel: usb-storage: Bulk status result = 0
Jan 13 09:04:01 maus kernel: usb-storage: Bulk status Sig 0x53425355 T 0x10 R 159 Stat 0x0
Jan 13 09:04:01 maus kernel: usb-storage: Fixing INQUIRY data to show SCSI rev 2
Jan 13 09:04:01 maus kernel: usb-storage: scsi cmd done, result=0x0
Jan 13 09:04:01 maus kernel: usb-storage: *** thread sleeping.
Jan 13 09:04:01 maus kernel: usb-storage: queuecommand() called
Jan 13 09:04:01 maus kernel: usb-storage: *** thread awakened.
Jan 13 09:04:01 maus kernel: usb-storage: Command INQUIRY (6 bytes)
Jan 13 09:04:01 maus kernel: usb-storage: 12 60 00 00 ff 00 00 00 00 a0 eb f7
Jan 13 09:04:01 maus kernel: usb-storage: Bulk command S 0x43425355 T 0x11 Trg 0 LUN 3 L 255 F 128 CL 6
Jan 13 09:04:01 maus kernel: usb-storage: Bulk command transfer result=0
Jan 13 09:04:01 maus kernel: usb-storage: usb_stor_transfer_partial(): xfer 255 bytes
Jan 13 09:04:01 maus kernel: usb-storage: usb_stor_bulk_msg() returned 0 xferred 96/255
Jan 13 09:04:01 maus kernel: usb-storage: Bulk data transfer result 0x1
Jan 13 09:04:01 maus kernel: usb-storage: Attempting to get CSW...
Jan 13 09:04:01 maus kernel: usb-storage: Bulk status result = 0
Jan 13 09:04:01 maus kernel: usb-storage: Bulk status Sig 0x53425355 T 0x11 R 159 Stat 0x0
Jan 13 09:04:01 maus kernel: usb-storage: Fixing INQUIRY data to show SCSI rev 2
Jan 13 09:04:01 maus kernel: usb-storage: scsi cmd done, result=0x0
Jan 13 09:04:01 maus kernel: usb-storage: *** thread sleeping.
Jan 13 09:04:01 maus kernel: usb-storage: queuecommand() called
Jan 13 09:04:01 maus kernel: usb-storage: *** thread awakened.
Jan 13 09:04:01 maus kernel: usb-storage: Bad LUN (0/4)
Jan 13 09:04:01 maus kernel: usb-storage: *** thread sleeping.
Jan 13 09:04:01 maus kernel: usb-storage: queuecommand() called
Jan 13 09:04:01 maus kernel: usb-storage: *** thread awakened.
Jan 13 09:04:01 maus kernel: usb-storage: Bad target number (1/0)
Jan 13 09:04:01 maus kernel: usb-storage: *** thread sleeping.
Jan 13 09:04:01 maus kernel: usb-storage: queuecommand() called
Jan 13 09:04:01 maus kernel: usb-storage: *** thread awakened.
Jan 13 09:04:01 maus kernel: usb-storage: Bad target number (2/0)
Jan 13 09:04:01 maus kernel: usb-storage: *** thread sleeping.
Jan 13 09:04:01 maus kernel: usb-storage: queuecommand() called
Jan 13 09:04:01 maus kernel: usb-storage: *** thread awakened.
Jan 13 09:04:01 maus kernel: usb-storage: Bad target number (3/0)
Jan 13 09:04:01 maus kernel: usb-storage: *** thread sleeping.
Jan 13 09:04:01 maus kernel: usb-storage: queuecommand() called
Jan 13 09:04:01 maus kernel: usb-storage: *** thread awakened.
Jan 13 09:04:01 maus kernel: usb-storage: Bad target number (4/0)
Jan 13 09:04:01 maus kernel: usb-storage: *** thread sleeping.
Jan 13 09:04:01 maus kernel: usb-storage: queuecommand() called
Jan 13 09:04:01 maus kernel: usb-storage: *** thread awakened.
Jan 13 09:04:01 maus kernel: usb-storage: Bad target number (5/0)
Jan 13 09:04:01 maus kernel: usb-storage: *** thread sleeping.
Jan 13 09:04:01 maus kernel: usb-storage: queuecommand() called
Jan 13 09:04:01 maus kernel: usb-storage: *** thread awakened.
Jan 13 09:04:01 maus kernel: usb-storage: Bad target number (6/0)
Jan 13 09:04:01 maus kernel: usb-storage: *** thread sleeping.
Jan 13 09:04:01 maus kernel: usb-storage: queuecommand() called
Jan 13 09:04:01 maus kernel: usb-storage: *** thread awakened.
Jan 13 09:04:01 maus kernel: usb-storage: Bad target number (7/0)
Jan 13 09:04:01 maus kernel: usb-storage: *** thread sleeping.
Jan 13 09:04:01 maus kernel: WARNING: USB Mass Storage data integrity not assured
Jan 13 09:04:01 maus kernel: USB Mass Storage device found at 6
Jan 13 09:04:01 maus kernel: USB Mass Storage support registered.
Jan 13 09:04:01 maus kernel: usb.c: USB device 6 (vend/prod 0x483/0x1307) is not claimed by any active driver.
Jan 13 09:04:01 maus kernel:   Vendor: Generic   Model: Flash R/W         Rev: 2002
Jan 13 09:04:01 maus kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Jan 13 09:04:01 maus kernel:   Vendor: Generic   Model: Flash R/W         Rev: 2002
Jan 13 09:04:01 maus kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Jan 13 09:04:01 maus kernel:   Vendor: Generic   Model: Flash R/W         Rev: 2002
Jan 13 09:04:01 maus kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Jan 13 09:04:01 maus kernel:   Vendor: Generic   Model: Flash R/W         Rev: 2002
Jan 13 09:04:01 maus kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Jan 13 09:04:22 maus kernel: usb-storage: queuecommand() called
Jan 13 09:04:22 maus kernel: usb-storage: *** thread awakened.
Jan 13 09:04:22 maus kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
Jan 13 09:04:22 maus kernel: usb-storage: 00 00 00 00 00 00 00 00 00 00 92 f8
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command S 0x43425355 T 0x1a Trg 0 LUN 0 L 0 F 0 CL 6
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command transfer result=0
Jan 13 09:04:22 maus kernel: usb-storage: Attempting to get CSW...
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status result = 0
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status Sig 0x53425355 T 0x1a R 0 Stat 0x1
Jan 13 09:04:22 maus kernel: usb-storage: -- transport indicates command failure
Jan 13 09:04:22 maus kernel: usb-storage: Issuing auto-REQUEST_SENSE
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command S 0x43425355 T 0x1a Trg 0 LUN 0 L 18 F 128 CL 6
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command transfer result=0
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_transfer_partial(): xfer 18 bytes
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_bulk_msg() returned 0 xferred 18/18
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_transfer_partial(): transfer complete
Jan 13 09:04:22 maus kernel: usb-storage: Bulk data transfer result 0x0
Jan 13 09:04:22 maus kernel: usb-storage: Attempting to get CSW...
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status result = 0
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status Sig 0x53425355 T 0x1a R 0 Stat 0x0
Jan 13 09:04:22 maus kernel: usb-storage: -- Result from auto-sense is 0
Jan 13 09:04:22 maus kernel: usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, ASCQ: 0x0
Jan 13 09:04:22 maus kernel: usb-storage: Not Ready: media not present
Jan 13 09:04:22 maus kernel: usb-storage: scsi cmd done, result=0x2
Jan 13 09:04:22 maus kernel: usb-storage: *** thread sleeping.
Jan 13 09:04:22 maus kernel: usb-storage: queuecommand() called
Jan 13 09:04:22 maus kernel: usb-storage: *** thread awakened.
Jan 13 09:04:22 maus kernel: usb-storage: Command READ_CAPACITY (10 bytes)
Jan 13 09:04:22 maus kernel: usb-storage: 25 00 00 00 00 00 00 00 00 00 92 f8
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command S 0x43425355 T 0x1b Trg 0 LUN 0 L 8 F 128 CL 10
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command transfer result=0
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_transfer_partial(): xfer 8 bytes
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_bulk_msg() returned -32 xferred 0/8
Jan 13 09:04:22 maus kernel: usb-storage: clearing endpoint halt for pipe 0xc0010680
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_clear_halt: result=0
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_transfer_partial(): unknown error
Jan 13 09:04:22 maus kernel: usb-storage: Bulk data transfer result 0x2
Jan 13 09:04:22 maus kernel: usb-storage: Attempting to get CSW...
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status result = 0
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status Sig 0x53425355 T 0x1b R 8 Stat 0x1
Jan 13 09:04:22 maus kernel: usb-storage: -- transport indicates command failure
Jan 13 09:04:22 maus kernel: usb-storage: Issuing auto-REQUEST_SENSE
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command S 0x43425355 T 0x1b Trg 0 LUN 0 L 18 F 128 CL 10
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command transfer result=0
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_transfer_partial(): xfer 18 bytes
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_bulk_msg() returned 0 xferred 18/18
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_transfer_partial(): transfer complete
Jan 13 09:04:22 maus kernel: usb-storage: Bulk data transfer result 0x0
Jan 13 09:04:22 maus kernel: usb-storage: Attempting to get CSW...
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status result = 0
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status Sig 0x53425355 T 0x1b R 0 Stat 0x0
Jan 13 09:04:22 maus kernel: usb-storage: -- Result from auto-sense is 0
Jan 13 09:04:22 maus kernel: usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, ASCQ: 0x0
Jan 13 09:04:22 maus kernel: usb-storage: Not Ready: media not present
Jan 13 09:04:22 maus kernel: usb-storage: scsi cmd done, result=0x2
Jan 13 09:04:22 maus kernel: usb-storage: *** thread sleeping.
Jan 13 09:04:22 maus kernel: usb-storage: queuecommand() called
Jan 13 09:04:22 maus kernel: usb-storage: *** thread awakened.
Jan 13 09:04:22 maus kernel: usb-storage: Command READ_CAPACITY (10 bytes)
Jan 13 09:04:22 maus kernel: usb-storage: 25 00 00 00 00 00 00 00 00 00 92 f8
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command S 0x43425355 T 0x1c Trg 0 LUN 0 L 8 F 128 CL 10
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command transfer result=0
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_transfer_partial(): xfer 8 bytes
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_bulk_msg() returned -32 xferred 0/8
Jan 13 09:04:22 maus kernel: usb-storage: clearing endpoint halt for pipe 0xc0010680
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_clear_halt: result=0
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_transfer_partial(): unknown error
Jan 13 09:04:22 maus kernel: usb-storage: Bulk data transfer result 0x2
Jan 13 09:04:22 maus kernel: usb-storage: Attempting to get CSW...
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status result = 0
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status Sig 0x53425355 T 0x1c R 8 Stat 0x1
Jan 13 09:04:22 maus kernel: usb-storage: -- transport indicates command failure
Jan 13 09:04:22 maus kernel: usb-storage: Issuing auto-REQUEST_SENSE
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command S 0x43425355 T 0x1c Trg 0 LUN 0 L 18 F 128 CL 10
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command transfer result=0
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_transfer_partial(): xfer 18 bytes
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_bulk_msg() returned 0 xferred 18/18
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_transfer_partial(): transfer complete
Jan 13 09:04:22 maus kernel: usb-storage: Bulk data transfer result 0x0
Jan 13 09:04:22 maus kernel: usb-storage: Attempting to get CSW...
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status result = 0
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status Sig 0x53425355 T 0x1c R 0 Stat 0x0
Jan 13 09:04:22 maus kernel: usb-storage: -- Result from auto-sense is 0
Jan 13 09:04:22 maus kernel: usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, ASCQ: 0x0
Jan 13 09:04:22 maus kernel: usb-storage: Not Ready: media not present
Jan 13 09:04:22 maus kernel: usb-storage: scsi cmd done, result=0x2
Jan 13 09:04:22 maus kernel: usb-storage: *** thread sleeping.
Jan 13 09:04:22 maus kernel: usb-storage: queuecommand() called
Jan 13 09:04:22 maus kernel: usb-storage: *** thread awakened.
Jan 13 09:04:22 maus kernel: usb-storage: Command READ_CAPACITY (10 bytes)
Jan 13 09:04:22 maus kernel: usb-storage: 25 00 00 00 00 00 00 00 00 00 92 f8
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command S 0x43425355 T 0x1d Trg 0 LUN 0 L 8 F 128 CL 10
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command transfer result=0
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_transfer_partial(): xfer 8 bytes
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_bulk_msg() returned -32 xferred 0/8
Jan 13 09:04:22 maus kernel: usb-storage: clearing endpoint halt for pipe 0xc0010680
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_clear_halt: result=0
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_transfer_partial(): unknown error
Jan 13 09:04:22 maus kernel: usb-storage: Bulk data transfer result 0x2
Jan 13 09:04:22 maus kernel: usb-storage: Attempting to get CSW...
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status result = 0
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status Sig 0x53425355 T 0x1d R 8 Stat 0x1
Jan 13 09:04:22 maus kernel: usb-storage: -- transport indicates command failure
Jan 13 09:04:22 maus kernel: usb-storage: Issuing auto-REQUEST_SENSE
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command S 0x43425355 T 0x1d Trg 0 LUN 0 L 18 F 128 CL 10
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command transfer result=0
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_transfer_partial(): xfer 18 bytes
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_bulk_msg() returned 0 xferred 18/18
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_transfer_partial(): transfer complete
Jan 13 09:04:22 maus kernel: usb-storage: Bulk data transfer result 0x0
Jan 13 09:04:22 maus kernel: usb-storage: Attempting to get CSW...
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status result = 0
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status Sig 0x53425355 T 0x1d R 0 Stat 0x0
Jan 13 09:04:22 maus kernel: usb-storage: -- Result from auto-sense is 0
Jan 13 09:04:22 maus kernel: usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, ASCQ: 0x0
Jan 13 09:04:22 maus kernel: usb-storage: Not Ready: media not present
Jan 13 09:04:22 maus kernel: usb-storage: scsi cmd done, result=0x2
Jan 13 09:04:22 maus kernel: usb-storage: *** thread sleeping.
Jan 13 09:04:22 maus kernel:  /dev/scsi/host1/bus0/target0/lun0: I/O error: dev 08:00, sector 0
Jan 13 09:04:22 maus kernel: usb-storage: queuecommand() called
Jan 13 09:04:22 maus kernel: usb-storage: *** thread awakened.
Jan 13 09:04:22 maus kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
Jan 13 09:04:22 maus kernel: usb-storage: 00 20 00 00 00 00 00 00 00 00 00 00
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command S 0x43425355 T 0x1e Trg 0 LUN 1 L 0 F 0 CL 6
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command transfer result=0
Jan 13 09:04:22 maus kernel: usb-storage: Attempting to get CSW...
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status result = 0
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status Sig 0x53425355 T 0x1e R 0 Stat 0x1
Jan 13 09:04:22 maus kernel: usb-storage: -- transport indicates command failure
Jan 13 09:04:22 maus kernel: usb-storage: Issuing auto-REQUEST_SENSE
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command S 0x43425355 T 0x1e Trg 0 LUN 1 L 18 F 128 CL 6
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command transfer result=0
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_transfer_partial(): xfer 18 bytes
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_bulk_msg() returned 0 xferred 18/18
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_transfer_partial(): transfer complete
Jan 13 09:04:22 maus kernel: usb-storage: Bulk data transfer result 0x0
Jan 13 09:04:22 maus kernel: usb-storage: Attempting to get CSW...
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status result = 0
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status Sig 0x53425355 T 0x1e R 0 Stat 0x0
Jan 13 09:04:22 maus kernel: usb-storage: -- Result from auto-sense is 0
Jan 13 09:04:22 maus kernel: usb-storage: -- code: 0x70, key: 0x6, ASC: 0x28, ASCQ: 0x0
Jan 13 09:04:22 maus kernel: usb-storage: Unit Attention: not ready to ready transition
Jan 13 09:04:22 maus kernel: usb-storage: scsi cmd done, result=0x2
Jan 13 09:04:22 maus kernel: usb-storage: *** thread sleeping.
Jan 13 09:04:22 maus kernel: usb-storage: queuecommand() called
Jan 13 09:04:22 maus kernel: usb-storage: *** thread awakened.
Jan 13 09:04:22 maus kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
Jan 13 09:04:22 maus kernel: usb-storage: 00 20 00 00 00 00 00 00 00 00 00 00
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command S 0x43425355 T 0x1f Trg 0 LUN 1 L 0 F 0 CL 6
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command transfer result=0
Jan 13 09:04:22 maus kernel: usb-storage: Attempting to get CSW...
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status result = 0
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status Sig 0x53425355 T 0x1f R 0 Stat 0x0
Jan 13 09:04:22 maus kernel: usb-storage: scsi cmd done, result=0x0
Jan 13 09:04:22 maus kernel: usb-storage: *** thread sleeping.
Jan 13 09:04:22 maus kernel: usb-storage: queuecommand() called
Jan 13 09:04:22 maus kernel: usb-storage: *** thread awakened.
Jan 13 09:04:22 maus kernel: usb-storage: Command READ_CAPACITY (10 bytes)
Jan 13 09:04:22 maus kernel: usb-storage: 25 20 00 00 00 00 00 00 00 00 00 00
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command S 0x43425355 T 0x20 Trg 0 LUN 1 L 8 F 128 CL 10
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command transfer result=0
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_transfer_partial(): xfer 8 bytes
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_bulk_msg() returned 0 xferred 8/8
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_transfer_partial(): transfer complete
Jan 13 09:04:22 maus kernel: usb-storage: Bulk data transfer result 0x0
Jan 13 09:04:22 maus kernel: usb-storage: Attempting to get CSW...
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status result = 0
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status Sig 0x53425355 T 0x20 R 0 Stat 0x0
Jan 13 09:04:22 maus kernel: usb-storage: scsi cmd done, result=0x0
Jan 13 09:04:22 maus kernel: usb-storage: *** thread sleeping.
Jan 13 09:04:22 maus kernel: usb-storage: queuecommand() called
Jan 13 09:04:22 maus kernel: usb-storage: *** thread awakened.
Jan 13 09:04:22 maus kernel: usb-storage: Command MODE_SENSE (6 bytes)
Jan 13 09:04:22 maus kernel: usb-storage: 1a 20 3f 00 ff 00 00 00 00 00 00 00
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command S 0x43425355 T 0x21 Trg 0 LUN 1 L 255 F 128 CL 6
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command transfer result=0
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_transfer_partial(): xfer 255 bytes
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_bulk_msg() returned 0 xferred 4/255
Jan 13 09:04:22 maus kernel: usb-storage: Bulk data transfer result 0x1
Jan 13 09:04:22 maus kernel: usb-storage: Attempting to get CSW...
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status result = 0
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status Sig 0x53425355 T 0x21 R 251 Stat 0x0
Jan 13 09:04:22 maus kernel: usb-storage: scsi cmd done, result=0x0
Jan 13 09:04:22 maus kernel: usb-storage: *** thread sleeping.
Jan 13 09:04:22 maus kernel:  /dev/scsi/host1/bus0/target0/lun1:<7>usb-storage: queuecommand() called
Jan 13 09:04:22 maus kernel: usb-storage: *** thread awakened.
Jan 13 09:04:22 maus kernel: usb-storage: Command READ_10 (10 bytes)
Jan 13 09:04:22 maus kernel: usb-storage: 28 20 00 00 00 00 00 00 08 00 00 00
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command S 0x43425355 T 0x22 Trg 0 LUN 1 L 4096 F 128 CL 10
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command transfer result=0
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_transfer_partial(): xfer 4096 bytes
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_bulk_msg() returned 0 xferred 4096/4096
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_transfer_partial(): transfer complete
Jan 13 09:04:22 maus kernel: usb-storage: Bulk data transfer result 0x0
Jan 13 09:04:22 maus kernel: usb-storage: Attempting to get CSW...
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status result = 0
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status Sig 0x53425355 T 0x22 R 0 Stat 0x0
Jan 13 09:04:22 maus kernel: usb-storage: scsi cmd done, result=0x0
Jan 13 09:04:22 maus kernel: usb-storage: *** thread sleeping.
Jan 13 09:04:22 maus kernel: usb-storage: queuecommand() called
Jan 13 09:04:22 maus kernel: usb-storage: *** thread awakened.
Jan 13 09:04:22 maus kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
Jan 13 09:04:22 maus kernel: usb-storage: 00 40 00 00 00 00 00 00 00 00 00 00
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command S 0x43425355 T 0x23 Trg 0 LUN 2 L 0 F 0 CL 6
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command transfer result=0
Jan 13 09:04:22 maus kernel: usb-storage: Attempting to get CSW...
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status result = 0
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status Sig 0x53425355 T 0x23 R 0 Stat 0x1
Jan 13 09:04:22 maus kernel: usb-storage: -- transport indicates command failure
Jan 13 09:04:22 maus kernel: usb-storage: Issuing auto-REQUEST_SENSE
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command S 0x43425355 T 0x23 Trg 0 LUN 2 L 18 F 128 CL 6
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command transfer result=0
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_transfer_partial(): xfer 18 bytes
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_bulk_msg() returned 0 xferred 18/18
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_transfer_partial(): transfer complete
Jan 13 09:04:22 maus kernel: usb-storage: Bulk data transfer result 0x0
Jan 13 09:04:22 maus kernel: usb-storage: Attempting to get CSW...
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status result = 0
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status Sig 0x53425355 T 0x23 R 0 Stat 0x0
Jan 13 09:04:22 maus kernel: usb-storage: -- Result from auto-sense is 0
Jan 13 09:04:22 maus kernel: usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, ASCQ: 0x0
Jan 13 09:04:22 maus kernel: usb-storage: Not Ready: media not present
Jan 13 09:04:22 maus kernel: usb-storage: scsi cmd done, result=0x2
Jan 13 09:04:22 maus kernel: usb-storage: *** thread sleeping.
Jan 13 09:04:22 maus kernel: usb-storage: queuecommand() called
Jan 13 09:04:22 maus kernel: usb-storage: *** thread awakened.
Jan 13 09:04:22 maus kernel: usb-storage: Command READ_CAPACITY (10 bytes)
Jan 13 09:04:22 maus kernel: usb-storage: 25 40 00 00 00 00 00 00 00 00 00 00
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command S 0x43425355 T 0x24 Trg 0 LUN 2 L 8 F 128 CL 10
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command transfer result=0
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_transfer_partial(): xfer 8 bytes
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_bulk_msg() returned -32 xferred 0/8
Jan 13 09:04:22 maus kernel: usb-storage: clearing endpoint halt for pipe 0xc0010680
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_clear_halt: result=0
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_transfer_partial(): unknown error
Jan 13 09:04:22 maus kernel: usb-storage: Bulk data transfer result 0x2
Jan 13 09:04:22 maus kernel: usb-storage: Attempting to get CSW...
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status result = 0
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status Sig 0x53425355 T 0x24 R 8 Stat 0x1
Jan 13 09:04:22 maus kernel: usb-storage: -- transport indicates command failure
Jan 13 09:04:22 maus kernel: usb-storage: Issuing auto-REQUEST_SENSE
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command S 0x43425355 T 0x24 Trg 0 LUN 2 L 18 F 128 CL 10
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command transfer result=0
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_transfer_partial(): xfer 18 bytes
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_bulk_msg() returned 0 xferred 18/18
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_transfer_partial(): transfer complete
Jan 13 09:04:22 maus kernel: usb-storage: Bulk data transfer result 0x0
Jan 13 09:04:22 maus kernel: usb-storage: Attempting to get CSW...
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status result = 0
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status Sig 0x53425355 T 0x24 R 0 Stat 0x0
Jan 13 09:04:22 maus kernel: usb-storage: -- Result from auto-sense is 0
Jan 13 09:04:22 maus kernel: usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, ASCQ: 0x0
Jan 13 09:04:22 maus kernel: usb-storage: Not Ready: media not present
Jan 13 09:04:22 maus kernel: usb-storage: scsi cmd done, result=0x2
Jan 13 09:04:22 maus kernel: usb-storage: *** thread sleeping.
Jan 13 09:04:22 maus kernel: usb-storage: queuecommand() called
Jan 13 09:04:22 maus kernel: usb-storage: *** thread awakened.
Jan 13 09:04:22 maus kernel: usb-storage: Command READ_CAPACITY (10 bytes)
Jan 13 09:04:22 maus kernel: usb-storage: 25 40 00 00 00 00 00 00 00 00 00 00
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command S 0x43425355 T 0x25 Trg 0 LUN 2 L 8 F 128 CL 10
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command transfer result=0
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_transfer_partial(): xfer 8 bytes
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_bulk_msg() returned -32 xferred 0/8
Jan 13 09:04:22 maus kernel: usb-storage: clearing endpoint halt for pipe 0xc0010680
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_clear_halt: result=0
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_transfer_partial(): unknown error
Jan 13 09:04:22 maus kernel: usb-storage: Bulk data transfer result 0x2
Jan 13 09:04:22 maus kernel: usb-storage: Attempting to get CSW...
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status result = 0
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status Sig 0x53425355 T 0x25 R 8 Stat 0x1
Jan 13 09:04:22 maus kernel: usb-storage: -- transport indicates command failure
Jan 13 09:04:22 maus kernel: usb-storage: Issuing auto-REQUEST_SENSE
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command S 0x43425355 T 0x25 Trg 0 LUN 2 L 18 F 128 CL 10
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command transfer result=0
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_transfer_partial(): xfer 18 bytes
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_bulk_msg() returned 0 xferred 18/18
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_transfer_partial(): transfer complete
Jan 13 09:04:22 maus kernel: usb-storage: Bulk data transfer result 0x0
Jan 13 09:04:22 maus kernel: usb-storage: Attempting to get CSW...
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status result = 0
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status Sig 0x53425355 T 0x25 R 0 Stat 0x0
Jan 13 09:04:22 maus kernel: usb-storage: -- Result from auto-sense is 0
Jan 13 09:04:22 maus kernel: usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, ASCQ: 0x0
Jan 13 09:04:22 maus kernel: usb-storage: Not Ready: media not present
Jan 13 09:04:22 maus kernel: usb-storage: scsi cmd done, result=0x2
Jan 13 09:04:22 maus kernel: usb-storage: *** thread sleeping.
Jan 13 09:04:22 maus kernel: usb-storage: queuecommand() called
Jan 13 09:04:22 maus kernel: usb-storage: *** thread awakened.
Jan 13 09:04:22 maus kernel: usb-storage: Command READ_CAPACITY (10 bytes)
Jan 13 09:04:22 maus kernel: usb-storage: 25 40 00 00 00 00 00 00 00 00 00 00
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command S 0x43425355 T 0x26 Trg 0 LUN 2 L 8 F 128 CL 10
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command transfer result=0
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_transfer_partial(): xfer 8 bytes
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_bulk_msg() returned -32 xferred 0/8
Jan 13 09:04:22 maus kernel: usb-storage: clearing endpoint halt for pipe 0xc0010680
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_clear_halt: result=0
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_transfer_partial(): unknown error
Jan 13 09:04:22 maus kernel: usb-storage: Bulk data transfer result 0x2
Jan 13 09:04:22 maus kernel: usb-storage: Attempting to get CSW...
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status result = 0
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status Sig 0x53425355 T 0x26 R 8 Stat 0x1
Jan 13 09:04:22 maus kernel: usb-storage: -- transport indicates command failure
Jan 13 09:04:22 maus kernel: usb-storage: Issuing auto-REQUEST_SENSE
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command S 0x43425355 T 0x26 Trg 0 LUN 2 L 18 F 128 CL 10
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command transfer result=0
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_transfer_partial(): xfer 18 bytes
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_bulk_msg() returned 0 xferred 18/18
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_transfer_partial(): transfer complete
Jan 13 09:04:22 maus kernel: usb-storage: Bulk data transfer result 0x0
Jan 13 09:04:22 maus kernel: usb-storage: Attempting to get CSW...
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status result = 0
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status Sig 0x53425355 T 0x26 R 0 Stat 0x0
Jan 13 09:04:22 maus kernel: usb-storage: -- Result from auto-sense is 0
Jan 13 09:04:22 maus kernel: usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, ASCQ: 0x0
Jan 13 09:04:22 maus kernel: usb-storage: Not Ready: media not present
Jan 13 09:04:22 maus kernel: usb-storage: scsi cmd done, result=0x2
Jan 13 09:04:22 maus kernel: usb-storage: *** thread sleeping.
Jan 13 09:04:22 maus kernel:  /dev/scsi/host1/bus0/target0/lun2: I/O error: dev 08:20, sector 0
Jan 13 09:04:22 maus kernel: usb-storage: queuecommand() called
Jan 13 09:04:22 maus kernel: usb-storage: *** thread awakened.
Jan 13 09:04:22 maus kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
Jan 13 09:04:22 maus kernel: usb-storage: 00 60 00 00 00 00 00 00 00 00 00 00
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command S 0x43425355 T 0x27 Trg 0 LUN 3 L 0 F 0 CL 6
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command transfer result=0
Jan 13 09:04:22 maus kernel: usb-storage: Attempting to get CSW...
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status result = 0
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status Sig 0x53425355 T 0x27 R 0 Stat 0x1
Jan 13 09:04:22 maus kernel: usb-storage: -- transport indicates command failure
Jan 13 09:04:22 maus kernel: usb-storage: Issuing auto-REQUEST_SENSE
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command S 0x43425355 T 0x27 Trg 0 LUN 3 L 18 F 128 CL 6
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command transfer result=0
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_transfer_partial(): xfer 18 bytes
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_bulk_msg() returned 0 xferred 18/18
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_transfer_partial(): transfer complete
Jan 13 09:04:22 maus kernel: usb-storage: Bulk data transfer result 0x0
Jan 13 09:04:22 maus kernel: usb-storage: Attempting to get CSW...
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status result = 0
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status Sig 0x53425355 T 0x27 R 0 Stat 0x0
Jan 13 09:04:22 maus kernel: usb-storage: -- Result from auto-sense is 0
Jan 13 09:04:22 maus kernel: usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, ASCQ: 0x0
Jan 13 09:04:22 maus kernel: usb-storage: Not Ready: media not present
Jan 13 09:04:22 maus kernel: usb-storage: scsi cmd done, result=0x2
Jan 13 09:04:22 maus kernel: usb-storage: *** thread sleeping.
Jan 13 09:04:22 maus kernel: usb-storage: queuecommand() called
Jan 13 09:04:22 maus kernel: usb-storage: *** thread awakened.
Jan 13 09:04:22 maus kernel: usb-storage: Command READ_CAPACITY (10 bytes)
Jan 13 09:04:22 maus kernel: usb-storage: 25 60 00 00 00 00 00 00 00 00 00 00
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command S 0x43425355 T 0x28 Trg 0 LUN 3 L 8 F 128 CL 10
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command transfer result=0
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_transfer_partial(): xfer 8 bytes
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_bulk_msg() returned -32 xferred 0/8
Jan 13 09:04:22 maus kernel: usb-storage: clearing endpoint halt for pipe 0xc0010680
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_clear_halt: result=0
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_transfer_partial(): unknown error
Jan 13 09:04:22 maus kernel: usb-storage: Bulk data transfer result 0x2
Jan 13 09:04:22 maus kernel: usb-storage: Attempting to get CSW...
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status result = 0
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status Sig 0x53425355 T 0x28 R 8 Stat 0x1
Jan 13 09:04:22 maus kernel: usb-storage: -- transport indicates command failure
Jan 13 09:04:22 maus kernel: usb-storage: Issuing auto-REQUEST_SENSE
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command S 0x43425355 T 0x28 Trg 0 LUN 3 L 18 F 128 CL 10
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command transfer result=0
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_transfer_partial(): xfer 18 bytes
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_bulk_msg() returned 0 xferred 18/18
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_transfer_partial(): transfer complete
Jan 13 09:04:22 maus kernel: usb-storage: Bulk data transfer result 0x0
Jan 13 09:04:22 maus kernel: usb-storage: Attempting to get CSW...
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status result = 0
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status Sig 0x53425355 T 0x28 R 0 Stat 0x0
Jan 13 09:04:22 maus kernel: usb-storage: -- Result from auto-sense is 0
Jan 13 09:04:22 maus kernel: usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, ASCQ: 0x0
Jan 13 09:04:22 maus kernel: usb-storage: Not Ready: media not present
Jan 13 09:04:22 maus kernel: usb-storage: scsi cmd done, result=0x2
Jan 13 09:04:22 maus kernel: usb-storage: *** thread sleeping.
Jan 13 09:04:22 maus kernel: usb-storage: queuecommand() called
Jan 13 09:04:22 maus kernel: usb-storage: *** thread awakened.
Jan 13 09:04:22 maus kernel: usb-storage: Command READ_CAPACITY (10 bytes)
Jan 13 09:04:22 maus kernel: usb-storage: 25 60 00 00 00 00 00 00 00 00 00 00
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command S 0x43425355 T 0x29 Trg 0 LUN 3 L 8 F 128 CL 10
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command transfer result=0
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_transfer_partial(): xfer 8 bytes
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_bulk_msg() returned -32 xferred 0/8
Jan 13 09:04:22 maus kernel: usb-storage: clearing endpoint halt for pipe 0xc0010680
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_clear_halt: result=0
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_transfer_partial(): unknown error
Jan 13 09:04:22 maus kernel: usb-storage: Bulk data transfer result 0x2
Jan 13 09:04:22 maus kernel: usb-storage: Attempting to get CSW...
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status result = 0
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status Sig 0x53425355 T 0x29 R 8 Stat 0x1
Jan 13 09:04:22 maus kernel: usb-storage: -- transport indicates command failure
Jan 13 09:04:22 maus kernel: usb-storage: Issuing auto-REQUEST_SENSE
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command S 0x43425355 T 0x29 Trg 0 LUN 3 L 18 F 128 CL 10
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command transfer result=0
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_transfer_partial(): xfer 18 bytes
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_bulk_msg() returned 0 xferred 18/18
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_transfer_partial(): transfer complete
Jan 13 09:04:22 maus kernel: usb-storage: Bulk data transfer result 0x0
Jan 13 09:04:22 maus kernel: usb-storage: Attempting to get CSW...
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status result = 0
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status Sig 0x53425355 T 0x29 R 0 Stat 0x0
Jan 13 09:04:22 maus kernel: usb-storage: -- Result from auto-sense is 0
Jan 13 09:04:22 maus kernel: usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, ASCQ: 0x0
Jan 13 09:04:22 maus kernel: usb-storage: Not Ready: media not present
Jan 13 09:04:22 maus kernel: usb-storage: scsi cmd done, result=0x2
Jan 13 09:04:22 maus kernel: usb-storage: *** thread sleeping.
Jan 13 09:04:22 maus kernel: usb-storage: queuecommand() called
Jan 13 09:04:22 maus kernel: usb-storage: *** thread awakened.
Jan 13 09:04:22 maus kernel: usb-storage: Command READ_CAPACITY (10 bytes)
Jan 13 09:04:22 maus kernel: usb-storage: 25 60 00 00 00 00 00 00 00 00 00 00
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command S 0x43425355 T 0x2a Trg 0 LUN 3 L 8 F 128 CL 10
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command transfer result=0
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_transfer_partial(): xfer 8 bytes
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_bulk_msg() returned -32 xferred 0/8
Jan 13 09:04:22 maus kernel: usb-storage: clearing endpoint halt for pipe 0xc0010680
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_clear_halt: result=0
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_transfer_partial(): unknown error
Jan 13 09:04:22 maus kernel: usb-storage: Bulk data transfer result 0x2
Jan 13 09:04:22 maus kernel: usb-storage: Attempting to get CSW...
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status result = 0
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status Sig 0x53425355 T 0x2a R 8 Stat 0x1
Jan 13 09:04:22 maus kernel: usb-storage: -- transport indicates command failure
Jan 13 09:04:22 maus kernel: usb-storage: Issuing auto-REQUEST_SENSE
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command S 0x43425355 T 0x2a Trg 0 LUN 3 L 18 F 128 CL 10
Jan 13 09:04:22 maus kernel: usb-storage: Bulk command transfer result=0
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_transfer_partial(): xfer 18 bytes
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_bulk_msg() returned 0 xferred 18/18
Jan 13 09:04:22 maus kernel: usb-storage: usb_stor_transfer_partial(): transfer complete
Jan 13 09:04:22 maus kernel: usb-storage: Bulk data transfer result 0x0
Jan 13 09:04:22 maus kernel: usb-storage: Attempting to get CSW...
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status result = 0
Jan 13 09:04:22 maus kernel: usb-storage: Bulk status Sig 0x53425355 T 0x2a R 0 Stat 0x0
Jan 13 09:04:22 maus kernel: usb-storage: -- Result from auto-sense is 0
Jan 13 09:04:22 maus kernel: usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, ASCQ: 0x0
Jan 13 09:04:22 maus kernel: usb-storage: Not Ready: media not present
Jan 13 09:04:22 maus kernel: usb-storage: scsi cmd done, result=0x2
Jan 13 09:04:22 maus kernel: usb-storage: *** thread sleeping.
Jan 13 09:04:22 maus kernel:  /dev/scsi/host1/bus0/target0/lun3: I/O error: dev 08:30, sector 0
Jan 13 09:04:22 maus kernel: Attached scsi removable disk sda at scsi1, channel 0, id 0, lun 0
Jan 13 09:04:22 maus kernel: Attached scsi removable disk sdb at scsi1, channel 0, id 0, lun 1
Jan 13 09:04:22 maus kernel: Attached scsi removable disk sdc at scsi1, channel 0, id 0, lun 2
Jan 13 09:04:22 maus kernel: Attached scsi removable disk sdd at scsi1, channel 0, id 0, lun 3
Jan 13 09:04:22 maus kernel: sda : READ CAPACITY failed.
Jan 13 09:04:22 maus kernel: sda : status = 1, message = 00, host = 0, driver = 08 
Jan 13 09:04:22 maus kernel: Current sd00:00: sense key Not Ready
Jan 13 09:04:22 maus kernel: Additional sense indicates Medium not present
Jan 13 09:04:22 maus kernel: sda : block size assumed to be 512 bytes, disk size 1GB.  
Jan 13 09:04:22 maus kernel:  I/O error: dev 08:00, sector 0
Jan 13 09:04:22 maus kernel:  unable to read partition table
Jan 13 09:04:22 maus kernel: SCSI device sdb: 500816 512-byte hdwr sectors (256 MB)
Jan 13 09:04:22 maus kernel: sdb: Write Protect is off
Jan 13 09:04:22 maus kernel:  p1
Jan 13 09:04:22 maus kernel: sdc : READ CAPACITY failed.
Jan 13 09:04:22 maus kernel: sdc : status = 1, message = 00, host = 0, driver = 08 
Jan 13 09:04:22 maus kernel: Current sd00:00: sense key Not Ready
Jan 13 09:04:22 maus kernel: Additional sense indicates Medium not present
Jan 13 09:04:22 maus kernel: sdc : block size assumed to be 512 bytes, disk size 1GB.  
Jan 13 09:04:22 maus kernel:  I/O error: dev 08:20, sector 0
Jan 13 09:04:22 maus kernel:  unable to read partition table
Jan 13 09:04:22 maus kernel: sdd : READ CAPACITY failed.
Jan 13 09:04:22 maus kernel: sdd : status = 1, message = 00, host = 0, driver = 08 
Jan 13 09:04:22 maus kernel: Current sd00:00: sense key Not Ready
Jan 13 09:04:22 maus kernel: Additional sense indicates Medium not present
Jan 13 09:04:22 maus kernel: sdd : block size assumed to be 512 bytes, disk size 1GB.  
Jan 13 09:04:22 maus kernel:  I/O error: dev 08:30, sector 0
Jan 13 09:04:22 maus kernel:  unable to read partition table
Jan 13 09:04:54 maus kernel: usb.c: USB disconnect on device 6
Jan 13 09:04:54 maus kernel: usb-storage: storage_disconnect() called
Jan 13 09:04:54 maus kernel: usb-storage: -- releasing main URB
Jan 13 09:04:54 maus kernel: usb-storage: -- usb_unlink_urb() returned -19

--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="usb-storage.notwork-2.4.21-pre3-ac3.log"

Jan 13 09:11:14 maus kernel: hub.c: new USB device 02:00.0-2.3, assigned address 6
Jan 13 09:11:14 maus kernel: Initializing USB Mass Storage driver...
Jan 13 09:11:14 maus kernel: usb.c: registered new driver usb-storage
Jan 13 09:11:14 maus kernel: usb-storage: act_altsettting is 0
Jan 13 09:11:14 maus kernel: usb-storage: id_index calculated to be: 70
Jan 13 09:11:14 maus kernel: usb-storage: Array length appears to be: 72
Jan 13 09:11:14 maus kernel: usb-storage: USB Mass Storage device detected
Jan 13 09:11:14 maus kernel: usb-storage: Endpoints: In: 0xf729eb80 Out: 0xf729eb94 Int: 0x00000000 (Period 0)
Jan 13 09:11:14 maus kernel: usb-storage: New GUID 04831307fffe9ffffffffe97
Jan 13 09:11:14 maus kernel: usb-storage: GetMaxLUN command result is -32, data is 128
Jan 13 09:11:14 maus kernel: usb-storage: clearing endpoint halt for pipe 0x80000680
Jan 13 09:11:14 maus kernel: usb-storage: Transport: Bulk
Jan 13 09:11:14 maus kernel: usb-storage: Protocol: Transparent SCSI
Jan 13 09:11:14 maus kernel: usb-storage: *** thread sleeping.
Jan 13 09:11:14 maus kernel: scsi1 : SCSI emulation for USB Mass Storage devices
Jan 13 09:11:14 maus kernel: usb-storage: queuecommand() called
Jan 13 09:11:14 maus kernel: usb-storage: *** thread awakened.
Jan 13 09:11:14 maus kernel: usb-storage: Command INQUIRY (6 bytes)
Jan 13 09:11:14 maus kernel: usb-storage: 12 00 00 00 ff 00 14 f7 c4 8c ae f7
Jan 13 09:11:14 maus kernel: usb-storage: Bulk command S 0x43425355 T 0xe Trg 0 LUN 0 L 255 F 128 CL 6
Jan 13 09:11:14 maus kernel: usb-storage: Bulk command transfer result=0
Jan 13 09:11:14 maus kernel: usb-storage: usb_stor_transfer_partial(): xfer 255 bytes
Jan 13 09:11:14 maus kernel: usb-storage: usb_stor_bulk_msg() returned 0 xferred 96/255
Jan 13 09:11:14 maus kernel: usb-storage: Bulk data transfer result 0x1
Jan 13 09:11:14 maus kernel: usb-storage: Attempting to get CSW...
Jan 13 09:11:14 maus kernel: usb-storage: Bulk status result = 0
Jan 13 09:11:14 maus kernel: usb-storage: Bulk status Sig 0x53425355 T 0xe R 159 Stat 0x0
Jan 13 09:11:14 maus kernel: usb-storage: Fixing INQUIRY data to show SCSI rev 2
Jan 13 09:11:14 maus kernel: usb-storage: scsi cmd done, result=0x0
Jan 13 09:11:14 maus kernel: usb-storage: *** thread sleeping.
Jan 13 09:11:14 maus kernel: usb-storage: queuecommand() called
Jan 13 09:11:14 maus kernel: usb-storage: *** thread awakened.
Jan 13 09:11:14 maus kernel: usb-storage: Bad LUN (0/1)
Jan 13 09:11:14 maus kernel: usb-storage: *** thread sleeping.
Jan 13 09:11:14 maus kernel: usb-storage: queuecommand() called
Jan 13 09:11:14 maus kernel: usb-storage: *** thread awakened.
Jan 13 09:11:14 maus kernel: usb-storage: Bad target number (1/0)
Jan 13 09:11:14 maus kernel: usb-storage: *** thread sleeping.
Jan 13 09:11:14 maus kernel: usb-storage: queuecommand() called
Jan 13 09:11:14 maus kernel: usb-storage: *** thread awakened.
Jan 13 09:11:14 maus kernel: usb-storage: Bad target number (2/0)
Jan 13 09:11:14 maus kernel: usb-storage: *** thread sleeping.
Jan 13 09:11:14 maus kernel: usb-storage: queuecommand() called
Jan 13 09:11:14 maus kernel: usb-storage: *** thread awakened.
Jan 13 09:11:14 maus kernel: usb-storage: Bad target number (3/0)
Jan 13 09:11:14 maus kernel: usb-storage: *** thread sleeping.
Jan 13 09:11:14 maus kernel: usb-storage: queuecommand() called
Jan 13 09:11:14 maus kernel: usb-storage: *** thread awakened.
Jan 13 09:11:14 maus kernel: usb-storage: Bad target number (4/0)
Jan 13 09:11:14 maus kernel: usb-storage: *** thread sleeping.
Jan 13 09:11:14 maus kernel: usb-storage: queuecommand() called
Jan 13 09:11:14 maus kernel: usb-storage: *** thread awakened.
Jan 13 09:11:14 maus kernel: usb-storage: Bad target number (5/0)
Jan 13 09:11:14 maus kernel: usb-storage: *** thread sleeping.
Jan 13 09:11:14 maus kernel: usb-storage: queuecommand() called
Jan 13 09:11:14 maus kernel: usb-storage: *** thread awakened.
Jan 13 09:11:14 maus kernel: usb-storage: Bad target number (6/0)
Jan 13 09:11:14 maus kernel: usb-storage: *** thread sleeping.
Jan 13 09:11:14 maus kernel: usb-storage: queuecommand() called
Jan 13 09:11:14 maus kernel: usb-storage: *** thread awakened.
Jan 13 09:11:14 maus kernel: usb-storage: Bad target number (7/0)
Jan 13 09:11:14 maus kernel: usb-storage: *** thread sleeping.
Jan 13 09:11:14 maus kernel: WARNING: USB Mass Storage data integrity not assured
Jan 13 09:11:14 maus kernel: USB Mass Storage device found at 6
Jan 13 09:11:14 maus kernel: USB Mass Storage support registered.
Jan 13 09:11:14 maus kernel: usb.c: USB device 6 (vend/prod 0x483/0x1307) is not claimed by any active driver.
Jan 13 09:11:14 maus kernel:   Vendor: Generic   Model: Flash R/W         Rev: 2002
Jan 13 09:11:14 maus kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Jan 13 09:11:23 maus kernel: usb-storage: queuecommand() called
Jan 13 09:11:23 maus kernel: usb-storage: *** thread awakened.
Jan 13 09:11:23 maus kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
Jan 13 09:11:23 maus kernel: usb-storage: 00 00 00 00 00 00 00 00 00 00 92 f8
Jan 13 09:11:23 maus kernel: usb-storage: Bulk command S 0x43425355 T 0x17 Trg 0 LUN 0 L 0 F 0 CL 6
Jan 13 09:11:23 maus kernel: usb-storage: Bulk command transfer result=0
Jan 13 09:11:23 maus kernel: usb-storage: Attempting to get CSW...
Jan 13 09:11:23 maus kernel: usb-storage: Bulk status result = 0
Jan 13 09:11:23 maus kernel: usb-storage: Bulk status Sig 0x53425355 T 0x17 R 0 Stat 0x1
Jan 13 09:11:23 maus kernel: usb-storage: -- transport indicates command failure
Jan 13 09:11:23 maus kernel: usb-storage: Issuing auto-REQUEST_SENSE
Jan 13 09:11:23 maus kernel: usb-storage: Bulk command S 0x43425355 T 0x17 Trg 0 LUN 0 L 18 F 128 CL 6
Jan 13 09:11:23 maus kernel: usb-storage: Bulk command transfer result=0
Jan 13 09:11:23 maus kernel: usb-storage: usb_stor_transfer_partial(): xfer 18 bytes
Jan 13 09:11:23 maus kernel: usb-storage: usb_stor_bulk_msg() returned 0 xferred 18/18
Jan 13 09:11:23 maus kernel: usb-storage: usb_stor_transfer_partial(): transfer complete
Jan 13 09:11:23 maus kernel: usb-storage: Bulk data transfer result 0x0
Jan 13 09:11:23 maus kernel: usb-storage: Attempting to get CSW...
Jan 13 09:11:23 maus kernel: usb-storage: Bulk status result = 0
Jan 13 09:11:23 maus kernel: usb-storage: Bulk status Sig 0x53425355 T 0x17 R 0 Stat 0x0
Jan 13 09:11:23 maus kernel: usb-storage: -- Result from auto-sense is 0
Jan 13 09:11:23 maus kernel: usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, ASCQ: 0x0
Jan 13 09:11:23 maus kernel: usb-storage: Not Ready: media not present
Jan 13 09:11:23 maus kernel: usb-storage: scsi cmd done, result=0x2
Jan 13 09:11:23 maus kernel: usb-storage: *** thread sleeping.
Jan 13 09:11:23 maus kernel: usb-storage: queuecommand() called
Jan 13 09:11:23 maus kernel: usb-storage: *** thread awakened.
Jan 13 09:11:23 maus kernel: usb-storage: Command READ_CAPACITY (10 bytes)
Jan 13 09:11:23 maus kernel: usb-storage: 25 00 00 00 00 00 00 00 00 00 92 f8
Jan 13 09:11:23 maus kernel: usb-storage: Bulk command S 0x43425355 T 0x18 Trg 0 LUN 0 L 8 F 128 CL 10
Jan 13 09:11:23 maus kernel: usb-storage: Bulk command transfer result=0
Jan 13 09:11:23 maus kernel: usb-storage: usb_stor_transfer_partial(): xfer 8 bytes
Jan 13 09:11:23 maus kernel: usb-storage: usb_stor_bulk_msg() returned -32 xferred 0/8
Jan 13 09:11:23 maus kernel: usb-storage: clearing endpoint halt for pipe 0xc0010680
Jan 13 09:11:23 maus kernel: usb-storage: usb_stor_clear_halt: result=0
Jan 13 09:11:23 maus kernel: usb-storage: usb_stor_transfer_partial(): unknown error
Jan 13 09:11:23 maus kernel: usb-storage: Bulk data transfer result 0x2
Jan 13 09:11:23 maus kernel: usb-storage: Attempting to get CSW...
Jan 13 09:11:23 maus kernel: usb-storage: Bulk status result = 0
Jan 13 09:11:23 maus kernel: usb-storage: Bulk status Sig 0x53425355 T 0x18 R 8 Stat 0x1
Jan 13 09:11:23 maus kernel: usb-storage: -- transport indicates command failure
Jan 13 09:11:23 maus kernel: usb-storage: Issuing auto-REQUEST_SENSE
Jan 13 09:11:23 maus kernel: usb-storage: Bulk command S 0x43425355 T 0x18 Trg 0 LUN 0 L 18 F 128 CL 10
Jan 13 09:11:23 maus kernel: usb-storage: Bulk command transfer result=0
Jan 13 09:11:23 maus kernel: usb-storage: usb_stor_transfer_partial(): xfer 18 bytes
Jan 13 09:11:23 maus kernel: usb-storage: usb_stor_bulk_msg() returned 0 xferred 18/18
Jan 13 09:11:23 maus kernel: usb-storage: usb_stor_transfer_partial(): transfer complete
Jan 13 09:11:23 maus kernel: usb-storage: Bulk data transfer result 0x0
Jan 13 09:11:23 maus kernel: usb-storage: Attempting to get CSW...
Jan 13 09:11:23 maus kernel: usb-storage: Bulk status result = 0
Jan 13 09:11:23 maus kernel: usb-storage: Bulk status Sig 0x53425355 T 0x18 R 0 Stat 0x0
Jan 13 09:11:23 maus kernel: usb-storage: -- Result from auto-sense is 0
Jan 13 09:11:23 maus kernel: usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, ASCQ: 0x0
Jan 13 09:11:23 maus kernel: usb-storage: Not Ready: media not present
Jan 13 09:11:23 maus kernel: usb-storage: scsi cmd done, result=0x2
Jan 13 09:11:23 maus kernel: usb-storage: *** thread sleeping.
Jan 13 09:11:23 maus kernel: usb-storage: queuecommand() called
Jan 13 09:11:23 maus kernel: usb-storage: *** thread awakened.
Jan 13 09:11:23 maus kernel: usb-storage: Command READ_CAPACITY (10 bytes)
Jan 13 09:11:23 maus kernel: usb-storage: 25 00 00 00 00 00 00 00 00 00 92 f8
Jan 13 09:11:23 maus kernel: usb-storage: Bulk command S 0x43425355 T 0x19 Trg 0 LUN 0 L 8 F 128 CL 10
Jan 13 09:11:23 maus kernel: usb-storage: Bulk command transfer result=0
Jan 13 09:11:23 maus kernel: usb-storage: usb_stor_transfer_partial(): xfer 8 bytes
Jan 13 09:11:23 maus kernel: usb-storage: usb_stor_bulk_msg() returned -32 xferred 0/8
Jan 13 09:11:23 maus kernel: usb-storage: clearing endpoint halt for pipe 0xc0010680
Jan 13 09:11:23 maus kernel: usb-storage: usb_stor_clear_halt: result=0
Jan 13 09:11:23 maus kernel: usb-storage: usb_stor_transfer_partial(): unknown error
Jan 13 09:11:23 maus kernel: usb-storage: Bulk data transfer result 0x2
Jan 13 09:11:23 maus kernel: usb-storage: Attempting to get CSW...
Jan 13 09:11:23 maus kernel: usb-storage: Bulk status result = 0
Jan 13 09:11:23 maus kernel: usb-storage: Bulk status Sig 0x53425355 T 0x19 R 8 Stat 0x1
Jan 13 09:11:23 maus kernel: usb-storage: -- transport indicates command failure
Jan 13 09:11:23 maus kernel: usb-storage: Issuing auto-REQUEST_SENSE
Jan 13 09:11:23 maus kernel: usb-storage: Bulk command S 0x43425355 T 0x19 Trg 0 LUN 0 L 18 F 128 CL 10
Jan 13 09:11:23 maus kernel: usb-storage: Bulk command transfer result=0
Jan 13 09:11:23 maus kernel: usb-storage: usb_stor_transfer_partial(): xfer 18 bytes
Jan 13 09:11:23 maus kernel: usb-storage: usb_stor_bulk_msg() returned 0 xferred 18/18
Jan 13 09:11:23 maus kernel: usb-storage: usb_stor_transfer_partial(): transfer complete
Jan 13 09:11:23 maus kernel: usb-storage: Bulk data transfer result 0x0
Jan 13 09:11:23 maus kernel: usb-storage: Attempting to get CSW...
Jan 13 09:11:23 maus kernel: usb-storage: Bulk status result = 0
Jan 13 09:11:23 maus kernel: usb-storage: Bulk status Sig 0x53425355 T 0x19 R 0 Stat 0x0
Jan 13 09:11:23 maus kernel: usb-storage: -- Result from auto-sense is 0
Jan 13 09:11:23 maus kernel: usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, ASCQ: 0x0
Jan 13 09:11:23 maus kernel: usb-storage: Not Ready: media not present
Jan 13 09:11:23 maus kernel: usb-storage: scsi cmd done, result=0x2
Jan 13 09:11:23 maus kernel: usb-storage: *** thread sleeping.
Jan 13 09:11:23 maus kernel: usb-storage: queuecommand() called
Jan 13 09:11:23 maus kernel: usb-storage: *** thread awakened.
Jan 13 09:11:23 maus kernel: usb-storage: Command READ_CAPACITY (10 bytes)
Jan 13 09:11:23 maus kernel: usb-storage: 25 00 00 00 00 00 00 00 00 00 92 f8
Jan 13 09:11:23 maus kernel: usb-storage: Bulk command S 0x43425355 T 0x1a Trg 0 LUN 0 L 8 F 128 CL 10
Jan 13 09:11:23 maus kernel: usb-storage: Bulk command transfer result=0
Jan 13 09:11:23 maus kernel: usb-storage: usb_stor_transfer_partial(): xfer 8 bytes
Jan 13 09:11:23 maus kernel: usb-storage: usb_stor_bulk_msg() returned -32 xferred 0/8
Jan 13 09:11:23 maus kernel: usb-storage: clearing endpoint halt for pipe 0xc0010680
Jan 13 09:11:23 maus kernel: usb-storage: usb_stor_clear_halt: result=0
Jan 13 09:11:23 maus kernel: usb-storage: usb_stor_transfer_partial(): unknown error
Jan 13 09:11:23 maus kernel: usb-storage: Bulk data transfer result 0x2
Jan 13 09:11:23 maus kernel: usb-storage: Attempting to get CSW...
Jan 13 09:11:23 maus kernel: usb-storage: Bulk status result = 0
Jan 13 09:11:23 maus kernel: usb-storage: Bulk status Sig 0x53425355 T 0x1a R 8 Stat 0x1
Jan 13 09:11:23 maus kernel: usb-storage: -- transport indicates command failure
Jan 13 09:11:23 maus kernel: usb-storage: Issuing auto-REQUEST_SENSE
Jan 13 09:11:23 maus kernel: usb-storage: Bulk command S 0x43425355 T 0x1a Trg 0 LUN 0 L 18 F 128 CL 10
Jan 13 09:11:23 maus kernel: usb-storage: Bulk command transfer result=0
Jan 13 09:11:23 maus kernel: usb-storage: usb_stor_transfer_partial(): xfer 18 bytes
Jan 13 09:11:23 maus kernel: usb-storage: usb_stor_bulk_msg() returned 0 xferred 18/18
Jan 13 09:11:23 maus kernel: usb-storage: usb_stor_transfer_partial(): transfer complete
Jan 13 09:11:23 maus kernel: usb-storage: Bulk data transfer result 0x0
Jan 13 09:11:23 maus kernel: usb-storage: Attempting to get CSW...
Jan 13 09:11:23 maus kernel: usb-storage: Bulk status result = 0
Jan 13 09:11:23 maus kernel: usb-storage: Bulk status Sig 0x53425355 T 0x1a R 0 Stat 0x0
Jan 13 09:11:23 maus kernel: usb-storage: -- Result from auto-sense is 0
Jan 13 09:11:23 maus kernel: usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, ASCQ: 0x0
Jan 13 09:11:23 maus kernel: usb-storage: Not Ready: media not present
Jan 13 09:11:23 maus kernel: usb-storage: scsi cmd done, result=0x2
Jan 13 09:11:23 maus kernel: usb-storage: *** thread sleeping.
Jan 13 09:11:23 maus kernel:  /dev/scsi/host1/bus0/target0/lun0: I/O error: dev 08:00, sector 0
Jan 13 09:11:23 maus kernel: Attached scsi removable disk sda at scsi1, channel 0, id 0, lun 0
Jan 13 09:11:23 maus kernel: sda : READ CAPACITY failed.
Jan 13 09:11:23 maus kernel: sda : status = 1, message = 00, host = 0, driver = 08 
Jan 13 09:11:23 maus kernel: Current sd00:00: sense key Not Ready
Jan 13 09:11:23 maus kernel: Additional sense indicates Medium not present
Jan 13 09:11:23 maus kernel: sda : block size assumed to be 512 bytes, disk size 1GB.  
Jan 13 09:11:23 maus kernel:  I/O error: dev 08:00, sector 0
Jan 13 09:11:23 maus kernel:  unable to read partition table
Jan 13 09:11:33 maus kernel: usb.c: USB disconnect on device 02:00.0-2.3 address 6
Jan 13 09:11:33 maus kernel: usb-storage: storage_disconnect() called
Jan 13 09:11:33 maus kernel: usb-storage: -- releasing main URB
Jan 13 09:11:33 maus kernel: usb-storage: -- usb_unlink_urb() returned -19

--cNdxnHkX5QqsyA0e--
