Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264579AbUF1A32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264579AbUF1A32 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 20:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264578AbUF1A32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 20:29:28 -0400
Received: from smtp3.cwidc.net ([154.33.63.113]:37532 "EHLO smtp3.cwidc.net")
	by vger.kernel.org with ESMTP id S264579AbUF1A30 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 20:29:26 -0400
Message-ID: <40DF6658.9030900@tequila.co.jp>
Date: Mon, 28 Jun 2004 09:29:12 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: TEQUILA\ Japan
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040308
X-Accept-Language: en-us, en, ja
MIME-Version: 1.0
To: Matthias Urlichs <smurf@smurf.noris.de>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.7 and khelper
References: <40DB76F1.9010107@tequila.co.jp> <20040624184749.008358b0.akpm@osdl.org> <pan.2004.06.25.10.56.09.276622@smurf.noris.de>
In-Reply-To: <pan.2004.06.25.10.56.09.276622@smurf.noris.de>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Matthias Urlichs wrote:
| Hi, Andrew Morton wrote:
|
|
|>>I have a Debian/unstable box here (the same one that has these "fast
|>>clock problems with 2.6.7-mm1) and every night after the syslog restart
|>>the process with the id "4", which is khelper is reported to be
|>>respawning to fast.
|>
|>Strange.  I assume that what's happening is that the children of khelper
|>are being created and are dying,
|
|
| Umm, that ID refers to /etc/inittab, not to the process ID.

hmm, whatever it really was, thought it happend 4 times in a row, I
couldn't trigger it the whole weekend ...

- --
Clemens Schwaighofer - IT Engineer & System Administration
==========================================================
TEQUILA\Japan, 6-17-2 Ginza Chuo-ku, Tokyo 104-8167, JAPAN
Tel: +81-(0)3-3545-7703            Fax: +81-(0)3-3545-7343
http://www.tequila.co.jp
==========================================================
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA32ZXjBz/yQjBxz8RAoBNAKDS+ZwnDDaPj8+POWzvI6/EULPXngCcDwBd
aq4om4MF50YPTyfgDl4NU7E=
=CxLJ
-----END PGP SIGNATURE-----
