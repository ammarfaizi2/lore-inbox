Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267838AbTBEHVs>; Wed, 5 Feb 2003 02:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267839AbTBEHVs>; Wed, 5 Feb 2003 02:21:48 -0500
Received: from chaos.ao.net ([205.244.242.21]:26769 "EHLO chaos.ao.net")
	by vger.kernel.org with ESMTP id <S267838AbTBEHVq>;
	Wed, 5 Feb 2003 02:21:46 -0500
Date: Wed, 5 Feb 2003 02:31:20 -0500
From: "Harik A'ttar" <harik@chaos.ao.net>
To: linux-kernel@vger.kernel.org
Subject: devfsd lockups (2.4.20)
Message-ID: <20030205073120.GK26431@chaos.ao.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y4/B1uKDHmWlpzsz"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Bayes-Status: No, probability=0.000
X-Bayes-Debug: , K6:0.010, kernel:0.010, kernel:0.010, Y4:0.010, micalg:0.010, pgp-signature:0.010, devfsd:0.010, --Dan:0.010, triggers:0.010, pgp-sha1:0.010, pgp-signature:0.010, -----END:0.010, 4i:0.010, P2:0.010, defunct:0.016
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Y4/B1uKDHmWlpzsz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

(Cc please, I read via the archives)

I may have missed this in the archives, if so just ignore this.

2.4.20 UP experiences a lockup on any access to /dev.  Not sure what
triggers it, I'll watch more carefully tomorrow night.

Symtoms are: every process trying to open/readdir /dev blocks on disk
forever.  Processes already using devices continue to work.  System
rapidly accumulates defunct processes, but ALT-SYSREQ-* works to
umount/sync/reboot.

The only thing unusual about this system is that it's compiled for K6
and it's now running on a P2.  If it's determined to be because of
the CPU upgrade, it probably is wanting a printk("WARNING! Incompatable
Processor detected!")

None of my other 2.4.20 boxes have this happen, but they also don't
handle quite the volume of mail this one does.

--Dan

--Y4/B1uKDHmWlpzsz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----

iD8DBQE+QL3IkycScExRgsgRAjtfAJ92c3XfkjTtoSlbfnFFt81lORSXhgCdE3dM
gL4UVofAuXFMMG+scflrjYU=
=l/Gt
-----END PGP SIGNATURE-----

--Y4/B1uKDHmWlpzsz--
