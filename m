Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbTKCD4o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 22:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbTKCD4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 22:56:43 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:45512 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id S261891AbTKCD4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 22:56:42 -0500
Date: Mon, 3 Nov 2003 04:56:37 +0100
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] Linux-2.6.0-test9
Message-Id: <20031103045637.7d2acb90.us15@os.inf.tu-dresden.de>
In-Reply-To: <bo4gf0$4o8$1@build.pdx.osdl.net>
References: <20031103000924.494d960f.us15@os.inf.tu-dresden.de>
	<20031103001913.612795b3.us15@os.inf.tu-dresden.de>
	<bo4gf0$4o8$1@build.pdx.osdl.net>
Organization: Fiasco Core Team
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
X-Mailer: X-Mailer 5.0 Gold
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Mon__3_Nov_2003_04_56_37_+0100_EgMhNcqNPPzO.NJi"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Mon__3_Nov_2003_04_56_37_+0100_EgMhNcqNPPzO.NJi
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Sun, 02 Nov 2003 19:01:51 -0800 Linus Torvalds (LT) wrote:

LT> The good news (?) is that you seem to have preempt enabled, and there is one
LT> known (but fairly hard-to-hit) race in UP+preempt locking due to bad
LT> barrier ordering in test9 (and all previous kernels too, for that matter).
LT> That should be fixed in the current BK snapshots, but you can also avoid
LT> the problem by just not enabling preempt.

Yes, the kernel is UP + preempt. I'll try the current BK snapshot and will
let you know should the problem occur again.

-Udo.

--Signature=_Mon__3_Nov_2003_04_56_37_+0100_EgMhNcqNPPzO.NJi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/pdH1nhRzXSM7nSkRAlhTAJ0ZVband3yHuPPnwAInapfohIPH9ACfVFo0
6gsz2weya4hdcgdwlUVTFZk=
=WF8e
-----END PGP SIGNATURE-----

--Signature=_Mon__3_Nov_2003_04_56_37_+0100_EgMhNcqNPPzO.NJi--
