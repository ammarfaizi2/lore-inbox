Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129589AbRBAMjq>; Thu, 1 Feb 2001 07:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129613AbRBAMjh>; Thu, 1 Feb 2001 07:39:37 -0500
Received: from tabaluga.ipe.uni-stuttgart.de ([129.69.22.180]:49676 "EHLO
	tabaluga.ipe.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S129589AbRBAMjW>; Thu, 1 Feb 2001 07:39:22 -0500
From: Nils Rennebarth <nils@ipe.uni-stuttgart.de>
Date: Thu, 1 Feb 2001 13:38:12 +0100
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: What does "NAT: dropping untracked packet" mean?
Message-ID: <20010201133811.D14768@ipe.uni-stuttgart.de>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="at6+YcpfzWZg/htY"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--at6+YcpfzWZg/htY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Since enabling (but not yet using) firewalling in the 2.4.1 kernel, my log
gets clobbered with messages like:

Feb  1 12:58:56 obelix kernel: NAT: 0 dropping untracked packet ce767600 1 129.69.22.21 -> 224.0.0.2
Feb  1 12:59:01 obelix kernel: NAT: 0 dropping untracked packet ce767480 1 129.69.22.21 -> 224.0.0.2
Feb  1 12:59:04 obelix kernel: NAT: 0 dropping untracked packet ce767d80 1 129.69.22.21 -> 224.0.0.2
Feb  1 13:00:44 obelix kernel: NAT: 0 dropping untracked packet ce767600 1 129.69.22.51 -> 224.0.0.2
Feb  1 13:00:47 obelix kernel: NAT: 0 dropping untracked packet ce767600 1 129.69.22.51 -> 224.0.0.2
Feb  1 13:00:50 obelix kernel: NAT: 0 dropping untracked packet ce767b40 1 129.69.22.51 -> 224.0.0.2

The IP Adresses belong to Windows 98 computers. What does the message mean,
and what could I do to stop them?


Nils

--
*New* *New* *New*    - on shellac records
   Windows HE        - see top 10 reasons to downgrade on
Historical Edition     http://www.microsoft.com/windowshe

--at6+YcpfzWZg/htY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6eVizqgAZ+sZlgs4RAkqjAJ4mGyGwUv6QK/q8HMvQ+kWX6goMywCfYI7z
lgSXpqOnaOXBT1OSgEzNWSs=
=aCmB
-----END PGP SIGNATURE-----

--at6+YcpfzWZg/htY--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
