Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265789AbUAKHBM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 02:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265791AbUAKHBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 02:01:12 -0500
Received: from gizmo02ps.bigpond.com ([144.140.71.12]:5571 "HELO
	gizmo02ps.bigpond.com") by vger.kernel.org with SMTP
	id S265789AbUAKHBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 02:01:09 -0500
Mail-Copies-To: never
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Increase recursive symlink limit from 5 to 8
Keywords: seem,limit,symlink,path,entities
References: <E1AeMqJ-00022k-00@minerva.hungry.com>
	<2flllofnvp6.fsf@saruman.uio.no>
From: Steve Youngs <sryoungs@bigpond.net.au>
X-Face: #/1'_-|5_1$xjR,mVKhpfMJcRh8"k}_a{EkIO:Ox<]@zl/Yr|H,qH#3jJi6Aw(Mg@"!+Z"C
 N_S3!3jzW^FnPeumv4l#,E}J.+e%0q(U>#b-#`~>l^A!_j5AEgpU)>t+VYZ$:El7hLa1:%%L=3%B>n
 K{^jU_{&
Organization: Linux Users - Fanatics Dept.
X-URL: <http://users.bigpond.net.au/sryoungs/>
X-Request-PGP: <http://users.bigpond.net.au/sryoungs/pgp/sryoungs.asc>
X-OpenPGP-Fingerprint: 1659 2093 19D5 C06E D320  3A20 1D27 DB4B A94B 3003
X-Attribution: SY
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Date: Sun, 11 Jan 2004 17:01:01 +1000
In-Reply-To: <2flllofnvp6.fsf@saruman.uio.no> (Petter Reinholdtsen's message
 of "Sun, 11 Jan 2004 02:03:01 +0100")
Message-ID: <microsoft-free.87isjj0y1e.fsf@eicq.dnsalias.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) XEmacs/21.4 (Reasonable Discussion,
 linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

* Petter Reinholdtsen <pere@hungry.com> writes:

  >   Linux:         Symlink limit seem to be 6 path entities.
  >   AIX:           Symlink limit seem to be 21 path entities.
  >   HP-UX:         Symlink limit seem to be 21 path entities.
  >   Solaris:       Symlink limit seem to be 21 path entities.
  >   Irix:          Symlink limit seem to be 31 path entities.
  >   Mac OS X:      Symlink limit seem to be 33 path entities.
  >   Tru64 Unix:    Symlink limit seem to be 65 path entities.

  > I really think this limit should be increased in Linux.  Not sure
  > how high it should go, but from 5 to somewhere between 20 and 64
  > seem like a good idea to me.

6 does seem pretty low.  What was the reason for setting it there?  Is
there a downside to increasing it?

-- 
|---<Steve Youngs>---------------<GnuPG KeyID: A94B3003>---|
|              Ashes to ashes, dust to dust.               |
|      The proof of the pudding, is under the crust.       |
|------------------------------<sryoungs@bigpond.net.au>---|

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Eicq - The XEmacs ICQ Client <http://eicq.sf.net/>

iEYEABECAAYFAkAA9LAACgkQHSfbS6lLMANxNgCgqtU86VhvsxWNftb+pCv/xPCh
v4AAoNmWK69DltwQ+ssfuTafS6KSh2Io
=vqGu
-----END PGP SIGNATURE-----
--=-=-=--
