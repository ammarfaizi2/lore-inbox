Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964998AbWI0QFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964998AbWI0QFr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 12:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965106AbWI0QFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 12:05:47 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:13710 "EHLO
	fmmailgate03.web.de") by vger.kernel.org with ESMTP id S964998AbWI0QFq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 12:05:46 -0400
Message-ID: <451ABE0E.2030904@web.de>
Date: Wed, 27 Sep 2006 18:08:14 +0000
From: Michael Rasenberger <miraze@web.de>
User-Agent: Thunderbird 1.5.0.5 (X11/20060926)
MIME-Version: 1.0
To: akpm@osdl.org
CC: sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: 2.6.18-mm1 violates sandbox feature on linux distribution
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

when building external kernel module on gentoo linux distribution,
2.6.18-mm1 violates gentoo's sandbox feature due to file creation in
"as-instr" test in scripts/Kbuild.include. (AFAIK due to removal of
revert-x86_64-mm-detect-cfi.patch)

It probably also happens with other external built kernel modules on
gentoo and maybe with other distros using some kind of sandbox for
package installation.



Regards
Michael
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFGr4OC0GEtIi2MlcRAkZzAJ0dJQr8TCZPwJqxLPBb8sTCieAEvgCffotW
rVnYUm7rljLJQEycEO6A2/I=
=Z5ti
-----END PGP SIGNATURE-----
