Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261332AbUL2JtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbUL2JtL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 04:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261337AbUL2JtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 04:49:11 -0500
Received: from h80ad25cd.async.vt.edu ([128.173.37.205]:31458 "EHLO
	h80ad25cd.async.vt.edu") by vger.kernel.org with ESMTP
	id S261332AbUL2JtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 04:49:02 -0500
Message-Id: <200412290948.iBT9mr4P030887@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 10/11/2004 with nmh-1.1-RC3
To: Dave Airlie <airlied@linux.ie>
Cc: linux-kernel@vger.kernel.org
Subject: Re: running Linus kernel on FC3 
In-Reply-To: Your message of "Wed, 29 Dec 2004 09:25:01 GMT."
             <Pine.LNX.4.58.0412290922420.2899@skynet> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.58.0412290853540.2899@skynet> <200412290920.iBT9KcCq026840@turing-police.cc.vt.edu>
            <Pine.LNX.4.58.0412290922420.2899@skynet>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1156668200P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 29 Dec 2004 04:48:52 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1156668200P
Content-Type: text/plain; charset=us-ascii

On Wed, 29 Dec 2004 09:25:01 GMT, Dave Airlie said:

> lots of things like:.. some ntpd ones as well..
> audit(1104309139.067:0): avc:  denied  { write } for  pid=3222
> exe=/sbin/minilogd name=/ dev=tmpfs ino=464
> scontext=user_u:system_r:syslogd_t tcontext=user_u:object_r:tmpfs_t
> tclass=dir

Much more likely that these are fixed in more recent updates to the actual
policy, which is loaded into the kernel at startup.  Relevant RPMS:

selinux-policy-strict-1.19.15-9.noarch.rpm
selinux-policy-strict-sources-1.19.15-9.noarch.rpm
selinux-policy-targeted-1.19.15-9.noarch.rpm
selinux-policy-targeted-sources-1.19.15-9.noarch.rpm

(Those are the current ones in the fedora-devel tree as of about 24 hours ago).





--==_Exmh_-1156668200P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFB0n2CcC3lWbTT17ARAnj6AKCJ4OVIONfK41h3VCROVhu919rx7wCgppcV
sJc9HYlVdiDN5n6UKpObc4I=
=2shE
-----END PGP SIGNATURE-----

--==_Exmh_-1156668200P--
