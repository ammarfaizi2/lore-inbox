Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbTFDJVC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 05:21:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbTFDJVC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 05:21:02 -0400
Received: from smtp3.cwidc.net ([154.33.63.113]:34517 "EHLO smtp3.cwidc.net")
	by vger.kernel.org with ESMTP id S261216AbTFDJVB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 05:21:01 -0400
Message-ID: <3EDDBD16.9050301@tequila.co.jp>
Date: Wed, 04 Jun 2003 18:34:14 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5a) Gecko/20030528
X-Accept-Language: en-us, en, ja
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: Daniel.A.Christian@NASA.gov, linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-rc7 SMP module unresolved symbols
References: <200306031728.41982.Daniel.A.Christian@NASA.gov> <20030604083150.GA2770@werewolf.able.es>
In-Reply-To: <20030604083150.GA2770@werewolf.able.es>
X-Enigmail-Version: 0.75.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

J.A. Magallon wrote:

> You're missing a make install, I think ( at least this is what I do,
> perhaps something is redundant:

make install only works if you have something like "install_kernel.sh"
script available in your system. not all systems have that. so it might
just fail. and there is no problem by copying the System.map and bzImage
by hand to the /boot directory

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

iD8DBQE+3b0WjBz/yQjBxz8RAj+3AKDJj10rIQqgCSlBJbqUbp4GImoU5QCdFswF
z+rzMeBmzsWZOxscKODMNNg=
=AmJW
-----END PGP SIGNATURE-----

