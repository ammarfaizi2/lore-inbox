Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261886AbTELEXb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 00:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbTELEXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 00:23:31 -0400
Received: from smtp3.cwidc.net ([154.33.63.113]:56307 "EHLO smtp3.cwidc.net")
	by vger.kernel.org with ESMTP id S261886AbTELEX1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 00:23:27 -0400
Message-ID: <3EBF24A8.1050100@tequila.co.jp>
Date: Mon, 12 May 2003 13:35:52 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4b) Gecko/20030506
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Two RAID1 mirrors are faster than three
References: <200305112212_MC3-1-386B-32BF@compuserve.com>
In-Reply-To: <200305112212_MC3-1-386B-32BF@compuserve.com>
X-Enigmail-Version: 0.75.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Chuck Ebbert wrote:

>   Add the third disk back into the array:
>         # raidhotadd /dev/md21 /dev/hde9
>         [rebuilt 3000MiB in 313s == (3000+3000)/313 == 19MiB/s throughput]

Why three drives in a Raid1? Raid one is just mirror, or is the third
drive like a "hot" replace drive if one of the others fail?

- --
Clemens Schwaighofer - IT Engineer & System Administration
==========================================================
Tequila Japan, 6-17-2 Ginza Chuo-ku, Tokyo 104-8167, JAPAN
Tel: +81-(0)3-3545-7703            Fax: +81-(0)3-3545-7343
http://www.tequila.jp
==========================================================
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+vySnjBz/yQjBxz8RAi+jAJ96566475BKb8o21/A7Wlzztba1jQCfSCnG
EchYBgaJBdvOPzVbx9rPorU=
=Ydkv
-----END PGP SIGNATURE-----

