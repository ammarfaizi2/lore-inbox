Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316845AbSH0UjI>; Tue, 27 Aug 2002 16:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316897AbSH0UjI>; Tue, 27 Aug 2002 16:39:08 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:3972 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S316845AbSH0UjG>; Tue, 27 Aug 2002 16:39:06 -0400
Date: Tue, 27 Aug 2002 22:43:22 +0200
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.5.32
Message-Id: <20020827224322.24561e60.us15@os.inf.tu-dresden.de>
In-Reply-To: <Pine.LNX.4.33.0208271239580.2564-100000@penguin.transmeta.com>
References: <Pine.LNX.4.33.0208271239580.2564-100000@penguin.transmeta.com>
Organization: Disorganized
X-Mailer: Sylpheed version 0.8.1claws (GTK+ 1.2.10; )
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha1; boundary="W6+=.h0RFIe)2K.e"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--W6+=.h0RFIe)2K.e
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Aug 2002 12:47:16 -0700 (PDT)
Linus Torvalds <torvalds@transmeta.com> wrote:

> Linux 2.5.32 ...

Hello,

It looks like the kernel is trying to read partition tables on IDE cdrom drives
in SCSI emulation mode - and failing at doing so.

Regards,
-Udo.


hda: hda1
hdb: hdb1 hdb2 hdb3 < hdb5 hdb6 hdb7 hdb8 hdb9 hdb10 >
hde:ide-scsi: unsup command: dev 21:00: REQ_CMD REQ_STARTED sector 0, nr/cnr 8/1

end_request: I/O error, dev 21:00, sector 0
Buffer I/O error on device ide2(33,0), logical block 0
ide-scsi: unsup command: dev 21:00: REQ_CMD REQ_STARTED sector 1, nr/cnr 7/1

end_request: I/O error, dev 21:00, sector 1
Buffer I/O error on device ide2(33,0), logical block 1
ide-scsi: unsup command: dev 21:00: REQ_CMD REQ_STARTED sector 2, nr/cnr 6/1

end_request: I/O error, dev 21:00, sector 2
Buffer I/O error on device ide2(33,0), logical block 2
ide-scsi: unsup command: dev 21:00: REQ_CMD REQ_STARTED sector 3, nr/cnr 5/1

end_request: I/O error, dev 21:00, sector 3
Buffer I/O error on device ide2(33,0), logical block 3
ide-scsi: unsup command: dev 21:00: REQ_CMD REQ_STARTED sector 4, nr/cnr 4/1

end_request: I/O error, dev 21:00, sector 4
Buffer I/O error on device ide2(33,0), logical block 4
ide-scsi: unsup command: dev 21:00: REQ_CMD REQ_STARTED sector 5, nr/cnr 3/1

end_request: I/O error, dev 21:00, sector 5
Buffer I/O error on device ide2(33,0), logical block 5
ide-scsi: unsup command: dev 21:00: REQ_CMD REQ_STARTED sector 6, nr/cnr 2/1

end_request: I/O error, dev 21:00, sector 6
Buffer I/O error on device ide2(33,0), logical block 6
ide-scsi: unsup command: dev 21:00: REQ_CMD REQ_STARTED sector 7, nr/cnr 1/1

end_request: I/O error, dev 21:00, sector 7
Buffer I/O error on device ide2(33,0), logical block 7
ide-scsi: unsup command: dev 21:00: REQ_CMD REQ_STARTED sector 0, nr/cnr 8/1

end_request: I/O error, dev 21:00, sector 0
Buffer I/O error on device ide2(33,0), logical block 0
ide-scsi: unsup command: dev 21:00: REQ_CMD REQ_STARTED sector 1, nr/cnr 7/1

end_request: I/O error, dev 21:00, sector 1
Buffer I/O error on device ide2(33,0), logical block 1
ide-scsi: unsup command: dev 21:00: REQ_CMD REQ_STARTED sector 2, nr/cnr 6/1

end_request: I/O error, dev 21:00, sector 2
Buffer I/O error on device ide2(33,0), logical block 2
ide-scsi: unsup command: dev 21:00: REQ_CMD REQ_STARTED sector 3, nr/cnr 5/1

end_request: I/O error, dev 21:00, sector 3
Buffer I/O error on device ide2(33,0), logical block 3
ide-scsi: unsup command: dev 21:00: REQ_CMD REQ_STARTED sector 4, nr/cnr 4/1

end_request: I/O error, dev 21:00, sector 4
Buffer I/O error on device ide2(33,0), logical block 4
ide-scsi: unsup command: dev 21:00: REQ_CMD REQ_STARTED sector 5, nr/cnr 3/1

end_request: I/O error, dev 21:00, sector 5
Buffer I/O error on device ide2(33,0), logical block 5
ide-scsi: unsup command: dev 21:00: REQ_CMD REQ_STARTED sector 6, nr/cnr 2/1

end_request: I/O error, dev 21:00, sector 6
Buffer I/O error on device ide2(33,0), logical block 6
ide-scsi: unsup command: dev 21:00: REQ_CMD REQ_STARTED sector 7, nr/cnr 1/1

end_request: I/O error, dev 21:00, sector 7
Buffer I/O error on device ide2(33,0), logical block 7
 unable to read partition table
SCSI subsystem driver Revision: 1.00


--W6+=.h0RFIe)2K.e
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9a+RtnhRzXSM7nSkRApdhAJ9WIlT1M8aoF/E1i5AJ5GlCTj6o5QCeIfqJ
54rpViHhgauFblQb7DSA7as=
=SAUd
-----END PGP SIGNATURE-----

--W6+=.h0RFIe)2K.e--

