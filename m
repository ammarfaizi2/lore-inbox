Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262974AbUEOPOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262974AbUEOPOl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 11:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263227AbUEOPOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 11:14:40 -0400
Received: from [68.184.155.122] ([68.184.155.122]:43471 "EHLO wally.rdlg.net")
	by vger.kernel.org with ESMTP id S262974AbUEOPOi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 11:14:38 -0400
Date: Sat, 15 May 2004 11:14:10 -0400
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: dual-homed sourced out of lo?
Message-ID: <20040515151410.GE6684@rdlg.net>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rqzD5py0kzyFAOWN"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rqzD5py0kzyFAOWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


  We're working on a network-hardened solution and I've been picked to
figure out the solution to a problem.  In a week I'll have hardware to
play with but I'm trying to figure out the answer or a plan of attack
early.  Here's the setup:

Server had 2 interfaces with IP's:
eth0: 192.168.1.1
eth1: 192.168.2.1
lo: 192.168.0.1

We want to have the machine listening on eth0 and eth1 when both
networks are up and functional to the OSPF broadcasts.  Oubound traffic
needs to come from the 192.168.0.1 (lo) address though so that return
traffic goes to 192.168.0.1, not the other subnets and the server accept
the packets for lo.

Has anyone set up something like this which is relatively easy to
duplicate with a stock Linux box and Zebra for the OSPF?

Robert

:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

With Dreams To Be A King First One Should Be A Man
					- Manowar


--rqzD5py0kzyFAOWN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFApjPC8+1vMONE2jsRAt9+AJ9uJD/I7/9ltioIVwmKari9+b8+cQCePS7Y
TXE3aT5jaKZyJTjSaGDxKiA=
=yxDx
-----END PGP SIGNATURE-----

--rqzD5py0kzyFAOWN--
