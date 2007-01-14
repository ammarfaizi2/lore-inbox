Return-Path: <linux-kernel-owner+w=401wt.eu-S1751144AbXANJOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbXANJOy (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 04:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbXANJOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 04:14:54 -0500
Received: from lmailproxy02.edpnet.net ([212.71.1.195]:39763 "EHLO
	lmailproxy02.edpnet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144AbXANJOx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 04:14:53 -0500
X-Greylist: delayed 868 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Jan 2007 04:14:53 EST
Date: Sun, 14 Jan 2007 10:00:21 +0100
From: Laurent Bigonville <l.bigonville@edpnet.be>
To: linux-kernel@vger.kernel.org
Subject: WIFEXITED returns odd value when preempt enabled
Message-Id: <20070114100021.cd828dd7.l.bigonville@edpnet.be>
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.10.7; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sun__14_Jan_2007_10_00_21_+0100_WSI_OzHU37CZHZIE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Sun__14_Jan_2007_10_00_21_+0100_WSI_OzHU37CZHZIE
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi,

I'm using pam-keyring[1] (a pam-module which launch gnome-keyring and
unlock it). The module fails with preempt kernel version 2.6.20 but
works with 2.6.20 without preempt enabled.

I have a look at the code of the module and the problem seems to come
from the value returned by WIFEXITED().

Is it possible that the problem comes from the kernel?

Regards

Laurent Bigonville

[1] http://www.hekanetworks.com/pam_keyring/

--Signature=_Sun__14_Jan_2007_10_00_21_+0100_WSI_OzHU37CZHZIE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFqfEsVLyDt/3apY8RAmK8AKCr4vue5xohhhHhQ8FRd82BKjV7QACgod23
s7qlWATO8YLmNO8D2rKlCTo=
=u3Hj
-----END PGP SIGNATURE-----

--Signature=_Sun__14_Jan_2007_10_00_21_+0100_WSI_OzHU37CZHZIE--
