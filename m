Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265382AbSK3TQ3>; Sat, 30 Nov 2002 14:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267287AbSK3TQ3>; Sat, 30 Nov 2002 14:16:29 -0500
Received: from cs78149057.pp.htv.fi ([62.78.149.57]:54659 "EHLO
	devil.pp.htv.fi") by vger.kernel.org with ESMTP id <S265382AbSK3TQ3>;
	Sat, 30 Nov 2002 14:16:29 -0500
Subject: [2.5.50] ext3_add_entry: bad entry in directory #288740: rec_len
	is smaller than minimal
From: Mika Liljeberg <mika.liljeberg@welho.com>
To: ext3-users@redhat.com
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-2mGAHThG+nby7KkWCizj"
Organization: 
Message-Id: <1038684228.1986.13.camel@devil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 30 Nov 2002 21:23:48 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2mGAHThG+nby7KkWCizj
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Just had this problem on linux 2.5.50.

	MikaL


--=-2mGAHThG+nby7KkWCizj
Content-Disposition: attachment; filename=dmesg.txt
Content-Type: text/plain; name=dmesg.txt; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

EXT3-fs error (device ide1(22,6)): ext3_add_entry: bad entry in directory #=
288740: rec_len is smaller than minimal - offset=3D0, inode=3D0, rec_len=3D=
0, name_len=3D0
Aborting journal on device ide1(22,6).
ext3_abort called.
EXT3-fs abort (device ide1(22,6)): ext3_journal_start: Detected aborted jou=
rnal
Remounting filesystem read-only
EXT3-fs error (device ide1(22,6)) in start_transaction: Journal has aborted
EXT3-fs error (device ide1(22,6)) in ext3_delete_inode: Journal has aborted
ext3_reserve_inode_write: aborting transaction: Journal has aborted in __ex=
t3_journal_get_write_access<2>EXT3-fs error (device ide1(22,6)) in ext3_res=
erve_inode_write: Journal has aborted
EXT3-fs error (device ide1(22,6)) in ext3_create: Journal has aborted

--=-2mGAHThG+nby7KkWCizj--
