Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbTKCKTL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 05:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbTKCKTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 05:19:11 -0500
Received: from [193.195.148.66] ([193.195.148.66]:44026 "EHLO
	mailgate.invsat.com") by vger.kernel.org with ESMTP id S261953AbTKCKTI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 05:19:08 -0500
Date: Mon, 3 Nov 2003 10:18:57 +0000
From: Gavin Henry <gavin.henry@magicfx.co.uk>
To: linux-kernel@vger.kernel.org
Subject: ACPI Toshiba TECRA 8000 kernel 2.4.20, 2.4.22 and 2.6.0-test9 with
 Suse 8.2
Message-Id: <20031103101857.4609306e.gavin.henry@magicfx.co.uk>
Organization: http://www.Magicfx.co.uk
X-Mailer: Sylpheed version 0.9.6claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-Operating-System: Open Source
Mime-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on Domino1/Invsat Limited(Release 5.0.11  |July 24, 2002) at
 03/11/2003 10:19:24,
	Serialize by Router on Domino1/Invsat Limited(Release 5.0.11  |July 24, 2002) at
 03/11/2003 10:19:30,
	Serialize complete at 03/11/2003 10:19:30
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Mon__3_Nov_2003_10_18_57_+0000_x1kzQ3A+uOXQDiPK"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Mon__3_Nov_2003_10_18_57_+0000_x1kzQ3A+uOXQDiPK
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi all.

I have a clients laptop (above) and acpi seems to be broken. It is running Suse 8.2. There is a guide for all this at http://www.shroom.com/linux/laptop/8000.html

But it is for a 2.2 kernel.

The main error is from acpi saying "Cannot allocate resource region"

My question is: Has acpi been changed alot since then, as the kernel is not picking up the sound card and modem. I have traced this to acpi, as the only way I can get into the machine without pcmcia hanging to by putting pci=noacpi in grub.

Both are supported, but lspci -vv doesn't show them as acpi is off.

Am I correct is thinking that without acpi they will not be detected?

I have tried 2.6.0-test and 2.4.22 with this same error. Have not tired a 2.2 kernel on it.

-- 
Regards,

Gavin Henry.

Open Source. Open Solutions.
http://www.suretecsystems.com

--Signature=_Mon__3_Nov_2003_10_18_57_+0000_x1kzQ3A+uOXQDiPK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/piuVgNqd7Kng8UoRAuipAKC/yq/X9zxX87fcZ835xqlimnqXWACgsAHP
XopG+oHtyPsa1kE0VFTT5ME=
=uJ5I
-----END PGP SIGNATURE-----

--Signature=_Mon__3_Nov_2003_10_18_57_+0000_x1kzQ3A+uOXQDiPK--
