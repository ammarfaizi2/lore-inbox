Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267668AbUHRUjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267668AbUHRUjY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 16:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267650AbUHRUjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 16:39:23 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:27314 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S267646AbUHRUgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 16:36:19 -0400
Date: Wed, 18 Aug 2004 11:17:54 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Helge Hafting <helge.hafting@hist.no>
Cc: Janusz Dziemidowicz <rraptorr@kursor.pl>,
       Diego Calleja <diegocg@teleline.es>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] ext3 documentation (lack of)
Message-ID: <20040818171754.GN8967@schnapps.adilger.int>
Mail-Followup-To: Helge Hafting <helge.hafting@hist.no>,
	Janusz Dziemidowicz <rraptorr@kursor.pl>,
	Diego Calleja <diegocg@teleline.es>, linux-kernel@vger.kernel.org
References: <20040818025951.63c4134e.diegocg@teleline.es> <200408172301.09350.ryan@spitfire.gotdns.org> <20040818133818.7b0582f3.diegocg@teleline.es> <Pine.LNX.4.61.0408181414450.18542@stacja.kursor.pl> <412352C9.7090006@hist.no>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VSVNCtZB1QZ8vhj+"
Content-Disposition: inline
In-Reply-To: <412352C9.7090006@hist.no>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VSVNCtZB1QZ8vhj+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Aug 18, 2004  14:59 +0200, Helge Hafting wrote:
> ACL's does not require use of the user_xattr mount option - I have tested
> that acl's work on ext3 with only the "acl" option.  I guess user_xattr is
> turned on automatically as needed - you can use the option if you want
> posix extended attributes without acls.

Actually, user_xattr is entirely unrelated to acls.  The user_xattr option
is used to enable arbitrary EAs that can be stored by the owner of the file
with setfattr and read with getfattr (along with the syscalls for same).
The acl support uses "in kernel" EAs that the user cannot modify.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/


--VSVNCtZB1QZ8vhj+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFBI49CpIg59Q01vtYRAkrSAJ9W3KTLNIlT7haP/WX9pKcEaOlmrACbBEXI
xe9pWgUTojDp6IUBiZ7Q0Yc=
=oDzB
-----END PGP SIGNATURE-----

--VSVNCtZB1QZ8vhj+--
