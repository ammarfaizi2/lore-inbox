Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266679AbUFWVHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266679AbUFWVHV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 17:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266678AbUFWVGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 17:06:54 -0400
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:65225 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S266674AbUFWVGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 17:06:09 -0400
Date: Wed, 23 Jun 2004 14:06:03 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Roland Lezuo <roland.lezuo@chello.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: usb-storage, sd_mod problem, with debugging infos ;)
Message-ID: <20040623210603.GB8166@one-eyed-alien.net>
Mail-Followup-To: Roland Lezuo <roland.lezuo@chello.at>,
	linux-kernel@vger.kernel.org
References: <40D9EAFF.8070403@chello.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
Content-Disposition: inline
In-Reply-To: <40D9EAFF.8070403@chello.at>
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2004 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

A patch for this is already on it's way to Linus.

Matt

On Wed, Jun 23, 2004 at 10:41:35PM +0200, Roland Lezuo wrote:
> Hello,
>=20
> I feel a bit ignored about this topic, but well I'll simply retry. Since
> 2.6.4 my usb stick does not work with linux any more. When searching the
> internet for a solution I just find people with similar problems but no
> solutions...
>=20
> This happens when I plug in my stick (Traxdata EZ drive)
>=20
> P.S.: please CC me personally, i'll try any patches...
>=20
>=20
> usb 1-4: new high speed USB device using address 2
> usb-storage: USB Mass Storage device detected
> usb-storage: altsetting is 0, id_index is 92
> usb-storage: -- associate_dev
> usb-storage: Transport: Bulk
> usb-storage: Protocol: Transparent SCSI
> usb-storage: Endpoints: In: 0xd315ef54 Out: 0xd315ef68 Int: 0x00000000
> (Period 0)
> usb-storage: usb_stor_control_msg: rq=3Dfe rqtype=3Da1 value=3D0000 index=
=3D00 len=3D1
> usb-storage: GetMaxLUN command result is 1, data is 0
> usb-storage: *** thread sleeping.
> scsi0 : SCSI emulation for USB Mass Storage devices
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Command INQUIRY (6 bytes)
> usb-storage:  12 00 00 00 24 00
> usb-storage: Bulk Command S 0x43425355 T 0x1 L 36 F 128 Trg 0 LUN 0 CL 6
> usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
> usb-storage: Status code 0; transferred 31/31
> usb-storage: -- transfer complete
> usb-storage: Bulk command transfer result=3D0
> usb-storage: usb_stor_bulk_transfer_buf: xfer 36 bytes
> usb-storage: Status code 0; transferred 36/36
> usb-storage: -- transfer complete
> usb-storage: Bulk data transfer result 0x0
> usb-storage: Attempting to get CSW...
> usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
> usb-storage: Status code 0; transferred 13/13
> usb-storage: -- transfer complete
> usb-storage: Bulk status result =3D 0
> usb-storage: Bulk Status S 0x53425355 T 0x1 R 0 Stat 0x0
> usb-storage: scsi cmd done, result=3D0x0
> usb-storage: *** thread sleeping.
> ~  Vendor: Generic   Model:                   Rev:
> ~  Type:   Direct-Access                      ANSI SCSI revision: 02
> Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Bad LUN (0:1)
> usb-storage: scsi cmd done, result=3D0x40000
> usb-storage: *** thread sleeping.
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Bad target number (1:0)
> usb-storage: scsi cmd done, result=3D0x40000
> usb-storage: *** thread sleeping.
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Bad target number (2:0)
> usb-storage: scsi cmd done, result=3D0x40000
> usb-storage: *** thread sleeping.
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Bad target number (3:0)
> usb-storage: scsi cmd done, result=3D0x40000
> usb-storage: *** thread sleeping.
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Bad target number (4:0)
> usb-storage: scsi cmd done, result=3D0x40000
> usb-storage: *** thread sleeping.
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Bad target number (5:0)
> usb-storage: scsi cmd done, result=3D0x40000
> usb-storage: *** thread sleeping.
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Bad target number (6:0)
> usb-storage: scsi cmd done, result=3D0x40000
> usb-storage: *** thread sleeping.
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Bad target number (7:0)
> usb-storage: scsi cmd done, result=3D0x40000
> usb-storage: *** thread sleeping.
> USB Mass Storage device found at 2
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Command TEST_UNIT_READY (6 bytes)
> usb-storage:  00 00 00 00 00 00
> usb-storage: Bulk Command S 0x43425355 T 0xa L 0 F 0 Trg 0 LUN 0 CL 6
> usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
> usb-storage: Status code 0; transferred 31/31
> usb-storage: -- transfer complete
> usb-storage: Bulk command transfer result=3D0
> usb-storage: Attempting to get CSW...
> usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
> usb-storage: Status code 0; transferred 13/13
> usb-storage: -- transfer complete
> usb-storage: Bulk status result =3D 0
> usb-storage: Bulk Status S 0x53425355 T 0xa R 0 Stat 0x0
> usb-storage: scsi cmd done, result=3D0x0
> usb-storage: *** thread sleeping.
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Command READ_CAPACITY (10 bytes)
> usb-storage:  25 00 00 00 00 00 00 00 00 00
> usb-storage: Bulk Command S 0x43425355 T 0xb L 8 F 128 Trg 0 LUN 0 CL 10
> usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
> usb-storage: Status code 0; transferred 31/31
> usb-storage: -- transfer complete
> usb-storage: Bulk command transfer result=3D0
> usb-storage: usb_stor_bulk_transfer_buf: xfer 8 bytes
> usb-storage: Status code 0; transferred 8/8
> usb-storage: -- transfer complete
> usb-storage: Bulk data transfer result 0x0
> usb-storage: Attempting to get CSW...
> usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
> usb-storage: Status code 0; transferred 13/13
> usb-storage: -- transfer complete
> usb-storage: Bulk status result =3D 0
> usb-storage: Bulk Status S 0x53425355 T 0xb R 0 Stat 0x0
> usb-storage: scsi cmd done, result=3D0x0
> usb-storage: *** thread sleeping.
> SCSI device sda: 251904 512-byte hdwr sectors (129 MB)
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Command MODE_SENSE (6 bytes)
> usb-storage:  1a 00 3f 00 04 00
> usb-storage: Bulk Command S 0x43425355 T 0xc L 4 F 128 Trg 0 LUN 0 CL 6
> usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
> usb-storage: Status code 0; transferred 31/31
> usb-storage: -- transfer complete
> usb-storage: Bulk command transfer result=3D0
> usb-storage: usb_stor_bulk_transfer_buf: xfer 4 bytes
> usb-storage: Status code 0; transferred 4/4
> usb-storage: -- transfer complete
> usb-storage: Bulk data transfer result 0x0
> usb-storage: Attempting to get CSW...
> usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
> usb-storage: Status code 0; transferred 13/13
> usb-storage: -- transfer complete
> usb-storage: Bulk status result =3D 0
> usb-storage: Bulk Status S 0x53425355 T 0xc R 0 Stat 0x0
> usb-storage: scsi cmd done, result=3D0x0
> usb-storage: *** thread sleeping.
> sda: Write Protect is off
> sda: Mode Sense: 03 00 00 00
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Command MODE_SENSE (6 bytes)
> usb-storage:  1a 00 08 00 04 00
> usb-storage: Bulk Command S 0x43425355 T 0xd L 4 F 128 Trg 0 LUN 0 CL 6
> usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
> usb-storage: Status code 0; transferred 31/31
> usb-storage: -- transfer complete
> usb-storage: Bulk command transfer result=3D0
> usb-storage: usb_stor_bulk_transfer_buf: xfer 4 bytes
>=20
> HERE: 1 minute delay
>=20
> usb-storage: command_abort called
> usb-storage: usb_stor_stop_transport called
> usb-storage: -- cancelling URB
> usb-storage: Status code -104; transferred 0/4
> usb-storage: -- transfer cancelled
> usb-storage: Bulk data transfer result 0x4
> usb-storage: -- command was aborted
> usb-storage: usb_stor_Bulk_reset called
> usb-storage: usb_stor_control_msg: rq=3Dff rqtype=3D21 value=3D0000 index=
=3D00 len=3D0
> usb-storage: Soft reset failed: -32
> usb-storage: scsi command aborted
> usb-storage: *** thread sleeping.
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Command TEST_UNIT_READY (6 bytes)
> usb-storage:  00 00 00 00 00 00
> usb-storage: Bulk Command S 0x43425355 T 0xd L 0 F 0 Trg 0 LUN 0 CL 6
> usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
> usb-storage: Status code 0; transferred 31/31
> usb-storage: -- transfer complete
> usb-storage: Bulk command transfer result=3D0
> usb-storage: Attempting to get CSW...
> usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
> usb-storage: Status code -32; transferred 0/13
> usb-storage: clearing endpoint halt for pipe 0xc0008280
> usb-storage: usb_stor_control_msg: rq=3D01 rqtype=3D02 value=3D0000 index=
=3D81 len=3D0
> usb-storage: usb_stor_clear_halt: result =3D -71
> usb-storage: Bulk status result =3D 4
> usb-storage: -- transport indicates error, resetting
> usb-storage: usb_stor_Bulk_reset called
> usb-storage: usb_stor_control_msg: rq=3Dff rqtype=3D21 value=3D0000 index=
=3D00 len=3D0
> usb-storage: Soft reset failed: -71
> usb-storage: scsi cmd done, result=3D0x70000
> usb-storage: *** thread sleeping.
> usb-storage: device_reset called
> usb-storage: usb_stor_Bulk_reset called
> usb-storage: usb_stor_control_msg: rq=3Dff rqtype=3D21 value=3D0000 index=
=3D00 len=3D0
> usb-storage: Soft reset failed: -71
> usb-storage: bus_reset called
> usb-storage: usb_reset_device returns -19
> scsi: Device offlined - not ready after error recovery: host 0 channel 0
> id 0 lun 0
> sda: asking for cache data failed
> sda: assuming drive cache: write through
> Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
> usb-storage: usb_stor_exit() called
> usb-storage: -- calling usb_deregister()
> usbcore: deregistering driver usb-storage
> usb-storage: storage_disconnect() called
> usb-storage: usb_stor_stop_transport called
> usb-storage: -- dissociate_dev
> devfs_remove: scsi/host0/bus0/target0/lun0/generic not found, cannot remo=
ve
> ~ [<c0104e2e>] dump_stack+0x1e/0x20
> ~ [<c01df1f6>] devfs_remove+0xa6/0xb0
> ~ [<c02af2bf>] sg_remove+0xdf/0x260
> ~ [<c026c693>] class_device_del+0xc3/0xd0
> ~ [<c026c6b4>] class_device_unregister+0x14/0x20
> ~ [<c02a91a9>] scsi_remove_device+0x39/0xb0
> ~ [<c02a84f4>] scsi_forget_host+0x44/0x90
> ~ [<c02a13bc>] scsi_remove_host+0x2c/0x60
> ~ [<e09b0605>] storage_disconnect+0x45/0x51 [usb_storage]
> ~ [<e09ba0f6>] usb_unbind_interface+0x76/0x80 [usbcore]
> ~ [<c026b8c6>] device_release_driver+0x66/0x70
> ~ [<c026b8f2>] driver_detach+0x22/0x40
> ~ [<c026bb95>] bus_remove_driver+0x55/0x90
> ~ [<c026bffa>] driver_unregister+0x1a/0x42
> ~ [<e09ba1d3>] usb_deregister+0x33/0x40 [usbcore]
> ~ [<e09b0caa>] usb_stor_exit+0x2a/0x2c [usb_storage]
> ~ [<c012e62f>] sys_delete_module+0x14f/0x1c0
> ~ [<c010402f>] syscall_call+0x7/0xb
>=20
> usb-storage: -- sending exit command to thread
> usb-storage: *** thread awakened.
> usb-storage: -- exit command received
> usb-storage: -- usb_stor_release_resources finished
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

It was a new hope.
					-- Dust Puppy
User Friendly, 12/25/1998

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFA2fC7IjReC7bSPZARAja8AKDRBHnFSeztIgu/30dNguAg26tESwCeO/0s
ZnPAsjoAuwg3+HfoP6weLR4=
=Tni9
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--
