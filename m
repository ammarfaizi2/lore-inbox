Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264502AbUAFPdX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 10:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264538AbUAFPdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 10:33:23 -0500
Received: from [68.114.43.143] ([68.114.43.143]:4526 "EHLO wally.rdlg.net")
	by vger.kernel.org with ESMTP id S264502AbUAFPdQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 10:33:16 -0500
Date: Tue, 6 Jan 2004 10:33:14 -0500
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: What's dying here?
Message-ID: <20040106153314.GC31644@rdlg.net>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NtwzykIc2mflq5ck"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NtwzykIc2mflq5ck
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


While trying to untar 2.6.1-rc1 my machine hung up.  A dmesg gave me
this:


scsi1:0:0:0: Attempting to queue an ABORT message
CDB: 0x2a 0x0 0x3 0x66 0xcb 0xf 0x0 0x4 0x0 0x0
scsi1: At time of recovery, card was not paused
>>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
scsi1: Dumping Card State while idle, at SEQADDR 0x7
Card was paused
ACCUM =3D 0xbe, SINDEX =3D 0x9, DINDEX =3D 0x8c, ARG_2 =3D 0x0
HCNT =3D 0x0 SCBPTR =3D 0x6
SCSISIGI[0x0] ERROR[0x0] SCSIBUSL[0x0] LASTPHASE[0x1]=20
SCSISEQ[0x12] SBLKCTL[0x2] SCSIRATE[0x0] SEQCTL[0x10]=20
SEQ_FLAGS[0xc0] SSTAT0[0x5] SSTAT1[0xa] SSTAT2[0x0]=20
SSTAT3[0x0] SIMODE0[0x0] SIMODE1[0xa4] SXFRCTL0[0x80]=20
DFCNTRL[0x0] DFSTATUS[0x29]=20
STACK: 0x37 0x169 0x10c 0x3
SCB count =3D 116
Kernel NEXTQSCB =3D 2
Card NEXTQSCB =3D 2
QINFIFO entries:=20
Waiting Queue entries:=20
Disconnected Queue entries:=20
QOUTFIFO entries:=20
Sequencer Free SCB List: 6 8 7 15 3 12 0 13 11 10 4 9 2 1 5 14=20
Sequencer SCB Info:=20
  0 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]=20
  1 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]=20
  2 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]=20
  3 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]=20
  4 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]=20
  5 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]=20
  6 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]=20
  7 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]=20
  8 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]=20
  9 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]=20
 10 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]=20
 11 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]=20
 12 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]=20
 13 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]=20
 14 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]=20
 15 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]=20
Pending list:=20
 26 SCB_CONTROL[0x64] SCB_SCSIID[0x7] SCB_LUN[0x0]=20
Kernel Free SCB list: 9 6 3 18 39 54 11 23 0 56 51 63 15 62 22 27 59 16 1 3=
1 36 40 50 24 58 55 12 13 4 34 33 14 114 57 32 38 25 48 37 30 17 20 53 52 4=
9 7 60 8 61 29 28 35 46 5 47 21 10 41 19 43 45 44 42 67 115 108 109 110 111=
 104 105 106 107 100 101 102 103 96 97 98 99 92 93 94 95 88 89 90 91 84 85 =
86 87 80 81 82 83 76 77 78 79 72 73 74 75 68 69 70 71 64 65 66 113 112=20
DevQ(0:0:0): 0 waiting

<<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
(scsi1:A:0:0): Device is disconnected, re-queuing SCB
Recovery code sleeping
(scsi1:A:0:0): Abort Tag Message Sent
(scsi1:A:0:0): SCB 26 - Abort Tag Completed.
Recovery SCB completes
Recovery code awake
aic7xxx_abort returns 0x2002
scsi1:0:0:0: Attempting to queue an ABORT message
CDB: 0x28 0x0 0x3 0x4b 0xe8 0x6f 0x0 0x1 0x0 0x0
scsi1: At time of recovery, card was not paused
>>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
scsi1: Dumping Card State while idle, at SEQADDR 0x7
Card was paused
ACCUM =3D 0xbb, SINDEX =3D 0x64, DINDEX =3D 0x65, ARG_2 =3D 0xe
HCNT =3D 0x0 SCBPTR =3D 0x2
SCSISIGI[0x0] ERROR[0x0] SCSIBUSL[0x0] LASTPHASE[0x1]=20
SCSISEQ[0x12] SBLKCTL[0x2] SCSIRATE[0x0] SEQCTL[0x10]=20
SEQ_FLAGS[0xc0] SSTAT0[0x5] SSTAT1[0xa] SSTAT2[0x0]=20
SSTAT3[0x0] SIMODE0[0x0] SIMODE1[0xa4] SXFRCTL0[0x80]=20
DFCNTRL[0x0] DFSTATUS[0x2d]=20
STACK: 0xe4 0x169 0x199 0x3
SCB count =3D 116
Kernel NEXTQSCB =3D 25
Card NEXTQSCB =3D 25
QINFIFO entries:=20
Waiting Queue entries:=20
Disconnected Queue entries: 2:56=20
QOUTFIFO entries:=20
Sequencer Free SCB List: 5 10 11 7 12 3 1 4 13 6 9 0 15 8 14=20
Sequencer SCB Info:=20
  0 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]=20
  1 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]=20
  2 SCB_CONTROL[0x64] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0x38]=20
  3 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]=20
  4 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]=20
  5 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]=20
  6 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]=20
  7 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]=20
  8 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]=20
  9 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]=20
 10 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]=20
 11 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]=20
 12 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]=20
 13 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]=20
 14 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]=20
 15 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]=20
Pending list:=20
 56 SCB_CONTROL[0x60] SCB_SCSIID[0x7] SCB_LUN[0x0]=20
Kernel Free SCB list: 27 39 50 2 18 63 52 59 17 13 20 40 58 48 15 54 49 37 =
33 0 57 23 8 6 16 32 36 26 1 22 30 51 4 12 7 24 3 38 14 60 62 114 53 31 55 =
34 9 11 61 29 28 35 46 5 47 21 10 41 19 43 45 44 42 67 115 108 109 110 111 =
104 105 106 107 100 101 102 103 96 97 98 99 92 93 94 95 88 89 90 91 84 85 8=
6 87 80 81 82 83 76 77 78 79 72 73 74 75 68 69 70 71 64 65 66 113 112=20
DevQ(0:0:0): 0 waiting

<<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
(scsi1:A:0:0): Device is disconnected, re-queuing SCB
Recovery code sleeping
(scsi1:A:0:0): Abort Tag Message Sent
(scsi1:A:0:0): SCB 56 - Abort Tag Completed.
Recovery SCB completes
Recovery code awake
aic7xxx_abort returns 0x2002


lspci gives me this:
02:04.0 SCSI storage controller: Adaptec AHA-3940U/UW/UWD / AIC-7882U
       Flags: bus master, medium devsel, latency 64, IRQ 17
       I/O ports at 2000 [disabled] [size=3D256]
       Memory at ea000000 (32-bit, non-prefetchable) [size=3D4K]
       Expansion ROM at <unassigned> [disabled] [size=3D64K]

The disk is a 36Gig Seagate.


Would this be a dying disk, dying scsi controller or just a bug?
:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Life is not a destination, it's a journey.
  Microsoft produces 15 car pileups on the highway.
    Don't stop traffic to stand and gawk at the tragedy.

--NtwzykIc2mflq5ck
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQE/+tU68+1vMONE2jsRAjfYAJ9Gaoqut1igZri/m77s646FqH9/zgCgpUWa
4EiLV/+LLHHOlFeoTqJKYYY=
=52uZ
-----END PGP SIGNATURE-----

--NtwzykIc2mflq5ck--
