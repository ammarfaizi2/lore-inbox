Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263784AbUECQ6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263784AbUECQ6V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 12:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263798AbUECQ6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 12:58:21 -0400
Received: from stud.fbi.fh-darmstadt.de ([141.100.40.65]:701 "EHLO
	stud1.fbihome.de") by vger.kernel.org with ESMTP id S263784AbUECQ6A convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 12:58:00 -0400
From: Sergio Vergata <vergata@stud.fbi.fh-darmstadt.de>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] Problem with USB2.0 and USB-Storage writing to DVD+-R
Date: Mon, 3 May 2004 18:57:38 +0200
User-Agent: KMail/1.6.2
Cc: USB development list <linux-usb-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.0405031148090.4414-100000@ida.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0405031148090.4414-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200405031857.44982.vergata@stud.fbi.fh-darmstadt.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi 
I have just testet with 2.6.6rc3 without preemt but same problem 

I have inserted also the dmesg output that i got that time, the last time this 
message dissapeared to fast so now here the output

Cu Sergio

sandokan:/# cat /proc/bus/usb/devices

T:  Bus=04 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480 MxCh= 6
B:  Alloc=  0/800 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.6-rc3 ehci_hcd
S:  Product=Intel Corp. 82801DB USB2
S:  SerialNumber=0000:00:1d.7
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=256ms

T:  Bus=03 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.6-rc3 uhci_hcd
S:  Product=Intel Corp. 82801DB USB (Hub #3)
S:  SerialNumber=0000:00:1d.2
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.6-rc3 uhci_hcd
S:  Product=Intel Corp. 82801DB USB (Hub #2)
S:  SerialNumber=0000:00:1d.1
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.6-rc3 uhci_hcd
S:  Product=Intel Corp. 82801DB USB (Hub #1)
S:  SerialNumber=0000:00:1d.0
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms


dmesg_output ->
usb 4-3: new high speed USB device using address 2
scsi0 : SCSI emulation for USB Mass Storage devices
  Vendor: HL-DT-ST  Model: DVDRAM GSA-4081B  Rev: A100
  Type:   CD-ROM                             ANSI SCSI revision: 02
USB Mass Storage device found at 2
sr0: scsi3-mmc drive: 32x/32x writer dvd-ram cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Hangcheck: hangcheck value past margin!
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 5
scsi: Device offlined - not ready after error recovery: host 0 channel 0 id 0 
lun 0
usb 4-3: USB disconnect, address 2
sr 0:0:0:0: Illegal state transition offline->cancel
Badness in scsi_device_set_state at drivers/scsi/scsi_lib.c:1640
Call Trace:
 [<e1a887e0>] scsi_device_set_state+0xc0/0x110 [scsi_mod]
 [<e1a83d18>] scsi_device_cancel+0x28/0xfb [scsi_mod]
 [<e1a83e30>] scsi_device_cancel_cb+0x0/0x20 [scsi_mod]
 [<c020973d>] device_for_each_child+0x3d/0x70
 [<e1a83e82>] scsi_host_cancel+0x32/0xa0 [scsi_mod]
 [<e1a83e30>] scsi_device_cancel_cb+0x0/0x20 [scsi_mod]
 [<e1936412>] usb_buffer_free+0x52/0x60 [usbcore]
 [<e1a83f09>] scsi_remove_host+0x19/0x60 [scsi_mod]
 [<e1adbcf8>] storage_disconnect+0x38/0x48 [usb_storage]
 [<e1935106>] usb_unbind_interface+0x76/0x80 [usbcore]
 [<c020a656>] device_release_driver+0x66/0x70
 [<c020a795>] bus_remove_device+0x55/0xa0
 [<c020968d>] device_del+0x5d/0xa0
 [<c02096e3>] device_unregister+0x13/0x30
 [<e193af30>] usb_disable_device+0x70/0xb0 [usbcore]
 [<e1935d24>] usb_disconnect+0x94/0xf0 [usbcore]
 [<e1937e01>] hub_port_connect_change+0x281/0x290 [usbcore]
 [<e19377a3>] hub_port_status+0x43/0xb0 [usbcore]
 [<e19380ba>] hub_events+0x2aa/0x300 [usbcore]
 [<e1938145>] hub_thread+0x35/0x100 [usbcore]
 [<c0105e62>] ret_from_fork+0x6/0x14
 [<c01168d0>] default_wake_function+0x0/0x20
 [<e1938110>] hub_thread+0x0/0x100 [usbcore]
 [<c01042ad>] kernel_thread_helper+0x5/0x18

sr 0:0:0:0: Illegal state transition offline->cancel
Badness in scsi_device_set_state at drivers/scsi/scsi_lib.c:1640
Call Trace:
 [<e1a887e0>] scsi_device_set_state+0xc0/0x110 [scsi_mod]
 [<e1a8a630>] scsi_remove_device+0x20/0xc0 [scsi_mod]
 [<e1a89a8a>] scsi_forget_host+0x2a/0x50 [scsi_mod]
 [<e1a83f19>] scsi_remove_host+0x29/0x60 [scsi_mod]
 [<e1adbcf8>] storage_disconnect+0x38/0x48 [usb_storage]
 [<e1935106>] usb_unbind_interface+0x76/0x80 [usbcore]
 [<c020a656>] device_release_driver+0x66/0x70
 [<c020a795>] bus_remove_device+0x55/0xa0
 [<c020968d>] device_del+0x5d/0xa0
 [<c02096e3>] device_unregister+0x13/0x30
 [<e193af30>] usb_disable_device+0x70/0xb0 [usbcore]
 [<e1935d24>] usb_disconnect+0x94/0xf0 [usbcore]
 [<e1937e01>] hub_port_connect_change+0x281/0x290 [usbcore]
 [<e19377a3>] hub_port_status+0x43/0xb0 [usbcore]
 [<e19380ba>] hub_events+0x2aa/0x300 [usbcore]
 [<e1938145>] hub_thread+0x35/0x100 [usbcore]
 [<c0105e62>] ret_from_fork+0x6/0x14
 [<c01168d0>] default_wake_function+0x0/0x20
 [<e1938110>] hub_thread+0x0/0x100 [usbcore]
 [<c01042ad>] kernel_thread_helper+0x5/0x18

On Monday 03 May 2004 17:48, Alan Stern wrote:
> On Sun, 2 May 2004, Sergio Vergata wrote:
> > Hi list,
> >
> > I want to report a problem that occured to me.
> > I have an USB2.0 DVD Recorder attached to my Laptop.
> >
> > ehci_hcd ist loaded and detect the new device!
> >
> > usb 4-3: new high speed USB device using address 2
> > Initializing USB Mass Storage driver...
> > scsi0 : SCSI emulation for USB Mass Storage devices
> >   Vendor: HL-DT-ST  Model: DVDRAM GSA-4081B  Rev: A100
> >   Type:   CD-ROM                             ANSI SCSI revision: 02
> > USB Mass Storage device found at 2
> > drivers/usb/core/usb.c: registered new driver usb-storage
> > USB Mass Storage support registered.
> > sr0: scsi3-mmc drive: 32x/32x writer dvd-ram cd/rw xa/form2 cdda tray
> > Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
> >
> > I can also read the DVD or CD in the device, but writing to the recorder
> > gets an error an after that the kernel oopses.
> >
> > The RecorderDevice hangs up and remain in the writingoperation on the
> > same position, in the writinglog there is a long wait at position 0,6% at
> > this time the usb is resettet and could not be reinitialised, so the
> > following error occures, after a while and a lot of rejecting I/O the
> > kernel gets an Oops could be that it happens because of Preempt?
> >
> > What do you say ?
> >
> > Thanx Sergio
>
> Can you post the contents of /proc/bus/usb/devices with your recorder
> plugged in?
>
> Alan Stern

- -- 
Microsoft is to operating systems & security ....
             .... what McDonalds is to gourmet cooking

PGP-Key http://vergata.it/GPG/F17FDB2F.asc
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAlnoHVP5w5vF/2y8RAn+oAJ9BeOSh+J6jU0wipYVE49korHmNggCgxkaL
x2y+ATHwEpIQ/IrOyr/JzaM=
=MAJo
-----END PGP SIGNATURE-----
