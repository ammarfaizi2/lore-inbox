Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261469AbVFNDxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbVFNDxL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 23:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261450AbVFNDwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 23:52:12 -0400
Received: from h80ad2544.async.vt.edu ([128.173.37.68]:7948 "EHLO
	h80ad2544.async.vt.edu") by vger.kernel.org with ESMTP
	id S261432AbVFNDvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 23:51:15 -0400
Message-Id: <200506140346.j5E3koe7015011@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Andreas Dilger <adilger@clusterfs.com>
Cc: Hans Reiser <reiser@namesys.com>, fs <fs@ercist.iscas.ac.cn>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, zhiming@admin.iscas.ac.cn,
       qufuping@ercist.iscas.ac.cn, madsys@ercist.iscas.ac.cn,
       xuh@nttdata.com.cn, koichi@intellilink.co.jp,
       kuroiwaj@intellilink.co.jp, okuyama@intellilink.co.jp,
       matsui_v@valinux.co.jp, kikuchi_v@valinux.co.jp,
       fernando@intellilink.co.jp, kskmori@intellilink.co.jp,
       takenakak@intellilink.co.jp, yamaguchi@intellilink.co.jp,
       ext2-devel@lists.sourceforge.net, shaggy@austin.ibm.com,
       xfs-masters@oss.sgi.com,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: [Ext2-devel] Re: [RFD] FS behavior (I/O failure) in kernel summit 
In-Reply-To: Your message of "Mon, 13 Jun 2005 16:13:15 EDT."
             <20050613201315.GC19319@moraine.clusterfs.com> 
From: Valdis.Kletnieks@vt.edu
References: <1118692436.2512.157.camel@CoolQ> <42ADC99D.5000801@namesys.com>
            <20050613201315.GC19319@moraine.clusterfs.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1118720809_4874P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 13 Jun 2005 23:46:49 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1118720809_4874P
Content-Type: text/plain; charset=us-ascii

On Mon, 13 Jun 2005 16:13:15 EDT, Andreas Dilger said:
> > fs wrote:
> > >   c. do not care, just print some kernel debugging info(EXT2 JFS 
> > >      ReiserFS)

> 1b.  I don't think it is possible to get 1c behaviour for journal
> errors on ext3.

Are there any realistic cases where you'd *want* behavior 1c?

(The very idea makes me cringe - I had 2 different vendor's 4.3BSD-based
systems basically do 1c when a Fujitsu Super-Eagle went oxide plow - it merrily
went along all night dragging the crashed head hither and yon failing to write
into newly-destroyed blocks all over the disk....)



--==_Exmh_1118720809_4874P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCrlMpcC3lWbTT17ARAoCGAJ0S8mpQmIb3dWifXyy0W8h74W0Y4ACgpMr8
/4YzGmPdE3BtQiUJy1edqdg=
=nayt
-----END PGP SIGNATURE-----

--==_Exmh_1118720809_4874P--
