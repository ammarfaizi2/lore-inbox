Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261900AbVBTReP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261900AbVBTReP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 12:34:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261899AbVBTReP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 12:34:15 -0500
Received: from smtp1.poczta.interia.pl ([217.74.65.44]:40773 "EHLO
	smtp.poczta.interia.pl") by vger.kernel.org with ESMTP
	id S261900AbVBTReE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 12:34:04 -0500
Date: 20 Feb 2005 18:34:01 +0100
From: me <cellsan@interia.pl>
Subject: USB Storage problem (usb hangs)
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1804289383-1108920841=:65500"
X-ORIGINATE-IP: 83.16.246.186
IMPORTANCE: Normal
X-MSMAIL-PRIORITY: Normal
X-PRIORITY: 3
X-Mailer: PSE3
Message-Id: <20050220173401.48EF9E5B93@poczta.interia.pl>
X-EMID: f8540acc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-1804289383-1108920841=:65500
Content-Type: TEXT/plain; CHARSET=ISO-8859-2

Hi.

The device is: USB2.0 to IDE 3.5" hard disk enclosure.
Producer: Seven.

Part of /var/log/messages with USB debug enabled in kernel is
attached to this email.

Kernel: 2.6.9, 2.6.10 (i cant remember from which one is attached log).
Distribution: Gentoo.

I'm not subscribed to the list, pleas CC me.

-- 
Regards
Sebastian Fabrycki
cellsan@interia.pl

------------------------------------------------------------------
Sprawdz NOWE parametry hostingu!
>> http://link.interia.pl/f1857 << 

--0-1804289383-1108920841=:65500
Content-Type: TEXT/plain; CHARSET=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <usbmsg.txt43E9A723@91CBB55.3C15736A>
Content-Disposition: ATTACHMENT; FILENAME="usb-msg.txt"

Jan 10 23:34:30 globtel usb-storage: USB Mass Storage device detected=0AJan=
 10 23:34:30 globtel usb-storage: -- associate_dev=0AJan 10 23:34:30 globte=
l usb-storage: Vendor: 0x05e3, Product: 0x0702, Revision: 0x0002=0AJan 10 2=
3:34:30 globtel usb-storage: Interface Subclass: 0x06, Protocol: 0x50=0AJan=
 10 23:34:30 globtel usb-storage: Vendor: Genesys Logic,  Product: USB TO I=
DE=0AJan 10 23:34:30 globtel usb-storage: Transport: Bulk=0AJan 10 23:34:30=
 globtel usb-storage: Protocol: Transparent SCSI=0AJan 10 23:34:30 globtel =
usb-storage: usb_stor_control_msg: rq=3Dfe rqtype=3Da1 value=3D0000 index=
=3D00 len=3D1=0AJan 10 23:34:30 globtel usb-storage: GetMaxLUN command resu=
lt is 1, data is 0=0AJan 10 23:34:30 globtel usb-storage: *** thread sleepi=
ng.=0AJan 10 23:34:30 globtel scsi0 : SCSI emulation for USB Mass Storage d=
evices=0AJan 10 23:34:30 globtel usb-storage: queuecommand called=0AJan 10 =
23:34:30 globtel usb-storage: *** thread awakened.=0AJan 10 23:34:30 globte=
l usb-storage: Faking INQUIRY command=0AJan 10 23:34:30 globtel usb-storage=
: scsi cmd done, result=3D0x0=0AJan 10 23:34:30 globtel usb-storage: *** th=
read sleeping.=0AJan 10 23:34:30 globtel Vendor: Genesys   Model: USB to ID=
E Disk   Rev: 0002=0AJan 10 23:34:30 globtel Type:   Direct-Access         =
             ANSI SCSI revision: 02=0AJan 10 23:34:30 globtel usb-storage: =
queuecommand called=0AJan 10 23:34:30 globtel usb-storage: *** thread awake=
ned.=0AJan 10 23:34:30 globtel usb-storage: Command TEST_UNIT_READY (6 byte=
s)=0AJan 10 23:34:30 globtel usb-storage:  00 00 00 00 00 00=0AJan 10 23:34=
:30 globtel usb-storage: Bulk Command S 0x43425355 T 0x2 L 0 F 0 Trg 0 LUN =
0 CL 6=0AJan 10 23:34:30 globtel usb-storage: usb_stor_bulk_transfer_buf: x=
fer 31 bytes=0AJan 10 23:34:30 globtel usb-storage: Status code 0; transfer=
red 31/31=0AJan 10 23:34:30 globtel usb-storage: -- transfer complete=0AJan=
 10 23:34:30 globtel usb-storage: Bulk command transfer result=3D0=0AJan 10=
 23:34:30 globtel usb-storage: Attempting to get CSW...=0AJan 10 23:34:30 g=
lobtel usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes=0AJan 10 23:3=
4:40 globtel scsi.agent[7459]: Attribute /sys/devices/pci0000:00/0000:00:1d=
.7/usb1/1-4/1-4:1.0/host0/0:0:0:0/type does not exist=0AJan 10 23:35:00 glo=
btel usb-storage: command_abort called=0AJan 10 23:35:00 globtel usb-storag=
e: usb_stor_stop_transport called=0AJan 10 23:35:00 globtel usb-storage: --=
 cancelling URB=0AJan 10 23:35:00 globtel usb-storage: Status code -104; tr=
ansferred 0/13=0AJan 10 23:35:00 globtel usb-storage: -- transfer cancelled=
=0AJan 10 23:35:00 globtel usb-storage: Bulk status result =3D 4=0AJan 10 2=
3:35:00 globtel usb-storage: -- command was aborted=0AJan 10 23:35:00 globt=
el usb-storage: usb_stor_Bulk_reset called=0AJan 10 23:35:00 globtel usb-st=
orage: usb_stor_control_msg: rq=3Dff rqtype=3D21 value=3D0000 index=3D00 le=
n=3D0=0AJan 10 23:35:20 globtel usb-storage: Timeout -- cancelling URB=0AJa=
n 10 23:35:20 globtel usb-storage: Soft reset failed: -104=0AJan 10 23:35:2=
0 globtel usb-storage: scsi command aborted=0AJan 10 23:35:20 globtel usb-s=
torage: *** thread sleeping.=0AJan 10 23:35:20 globtel usb-storage: queueco=
mmand called=0AJan 10 23:35:20 globtel usb-storage: *** thread awakened.=0A=
Jan 10 23:35:20 globtel usb-storage: Command TEST_UNIT_READY (6 bytes)=0AJa=
n 10 23:35:20 globtel usb-storage:  00 00 00 00 00 00=0AJan 10 23:35:20 glo=
btel usb-storage: Bulk Command S 0x43425355 T 0x2 L 0 F 0 Trg 0 LUN 0 CL 6=
=0AJan 10 23:35:20 globtel usb-storage: usb_stor_bulk_transfer_buf: xfer 31=
 bytes=0AJan 10 23:35:20 globtel usb-storage: Status code 0; transferred 31=
/31=0AJan 10 23:35:20 globtel usb-storage: -- transfer complete=0AJan 10 23=
:35:20 globtel usb-storage: Bulk command transfer result=3D0=0AJan 10 23:35=
:20 globtel usb-storage: Attempting to get CSW...=0AJan 10 23:35:20 globtel=
 usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes=0AJan 10 23:35:30 g=
lobtel usb-storage: command_abort called=0AJan 10 23:35:30 globtel usb-stor=
age: usb_stor_stop_transport called=0AJan 10 23:35:30 globtel usb-storage: =
-- cancelling URB=0AJan 10 23:35:30 globtel usb-storage: Status code -104; =
transferred 0/13=0AJan 10 23:35:30 globtel usb-storage: -- transfer cancell=
ed=0AJan 10 23:35:30 globtel usb-storage: Bulk status result =3D 4=0AJan 10=
 23:35:30 globtel usb-storage: -- command was aborted=0AJan 10 23:35:30 glo=
btel usb-storage: usb_stor_Bulk_reset called=0AJan 10 23:35:30 globtel usb-=
storage: usb_stor_control_msg: rq=3Dff rqtype=3D21 value=3D0000 index=3D00 =
len=3D0=0AJan 10 23:35:50 globtel usb-storage: Timeout -- cancelling URB=0A=
Jan 10 23:35:50 globtel usb-storage: Soft reset failed: -104=0AJan 10 23:35=
:50 globtel usb-storage: scsi command aborted=0AJan 10 23:35:50 globtel usb=
-storage: *** thread sleeping.=0AJan 10 23:35:50 globtel usb-storage: devic=
e_reset called=0AJan 10 23:35:50 globtel usb-storage: usb_stor_Bulk_reset c=
alled=0AJan 10 23:35:50 globtel usb-storage: usb_stor_control_msg: rq=3Dff =
rqtype=3D21 value=3D0000 index=3D00 len=3D0=0AJan 10 23:36:10 globtel usb-s=
torage: Timeout -- cancelling URB=0AJan 10 23:36:10 globtel usb-storage: So=
ft reset failed: -104=0AJan 10 23:36:10 globtel usb-storage: bus_reset call=
ed=0A...=0A...=0A
--0-1804289383-1108920841=:65500--
