Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262981AbTDFOf1 (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 10:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262982AbTDFOf1 (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 10:35:27 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:13763 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id S262981AbTDFOf0 (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 10:35:26 -0400
Date: Sun, 6 Apr 2003 17:46:55 +0200
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: poweroff problem
Message-Id: <20030406174655.592b7f60.us15@os.inf.tu-dresden.de>
In-Reply-To: <20030407002703.16993dc4.sfr@canb.auug.org.au>
References: <20030405060804.31946.qmail@webmail5.rediffmail.com>
	<20030406233319.042878d3.sfr@canb.auug.org.au>
	<20030406155814.68c5c908.us15@os.inf.tu-dresden.de>
	<20030407002703.16993dc4.sfr@canb.auug.org.au>
Organization: Disorganized
X-Mailer: Sylpheed version 0.8.11claws3 (GTK+ 1.2.10; Linux 2.4.21-pre6)
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.6i+ZmWFM_)6Nfq"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.6i+ZmWFM_)6Nfq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Apr 2003 00:27:03 +1000 Stephen Rothwell (SR) wrote:

SR> I was asuming the original report was from a kernel using APM not ACPI.
SR> Did 2.4.2 have ACPI?

Err no, so he must have been using APM.

2.4.2+APM has the problem, 2.4.21-pre+ACPI has the problem. Do APM and
ACPI both share the same code to power off a machine? If so that seems to
be the culprit.

-Udo.

--=.6i+ZmWFM_)6Nfq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.3.1 (GNU/Linux)

iD8DBQE+kEvxnhRzXSM7nSkRAk5rAJ9hDj9zFLHkGWtiH0TcY3fuuMlb8wCfeXcR
KGFZaup74V9sZPsKqaNkgO4=
=5kOO
-----END PGP SIGNATURE-----

--=.6i+ZmWFM_)6Nfq--
