Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263584AbUAMCH6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 21:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263593AbUAMCH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 21:07:58 -0500
Received: from smtp-out2.blueyonder.co.uk ([195.188.213.5]:34645 "EHLO
	smtp-out2.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S263584AbUAMCHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 21:07:55 -0500
Date: Tue, 13 Jan 2004 02:07:40 +0000
From: Ciaran McCreesh <ciaranm@gentoo.org>
To: "Chris K. Engel" <morbie@legions.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sun Type5 Mapping 2.4 -> 2.6
Message-Id: <20040113020740.1127e1f0@snowdrop.home>
In-Reply-To: <Pine.LNX.4.56.0401121950030.18099@cyberspace7.legions.org>
References: <Pine.LNX.4.56.0401121950030.18099@cyberspace7.legions.org>
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__13_Jan_2004_02_07_40_+0000_jUJKMZlc8_Ph=9FN"
X-OriginalArrivalTime: 13 Jan 2004 02:08:12.0240 (UTC) FILETIME=[18D5AD00:01C3D97A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__13_Jan_2004_02_07_40_+0000_jUJKMZlc8_Ph=9FN
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Mon, 12 Jan 2004 19:54:02 -0600 (CST) "Chris K. Engel"
<morbie@legions.org> wrote:
| I've noticed something strange.
| When updating to 2.6.1, my type5's mapping was really, really set off.
| Nothing would work, period. (And I've noticed an abundance of mapping
| issues on non-US keyboard layouts.)

This one has been discussed several times on the sparc-linux mailing
list :) See this thread:

http://marc.theaimsgroup.com/?t=107391327800003&r=1&w=2

Short summary:

In 2.6.x, you need to use x86-style keymaps instead of sunkeymap. In
Gentoo, you do this by editing the KEYMAP setting in /etc/rc.conf . In
Debian, use `dpkg-reconfigure console-data` to select an i386 keymap. In
other distros, do whatever it is that distro uses to select a keymap.

-- 
Ciaran McCreesh
Mail:    ciaranm at gentoo.org
Web:     http://dev.gentoo.org/~ciaranm

--Signature=_Tue__13_Jan_2004_02_07_40_+0000_jUJKMZlc8_Ph=9FN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAA1L496zL6DUtXhERAvd8AJ9kOtsCwZhvLQ/8+zs7zUluiqtbJwCdGBDR
x3gDY3FtAp+yWZ0h4oKxquw=
=PnUn
-----END PGP SIGNATURE-----

--Signature=_Tue__13_Jan_2004_02_07_40_+0000_jUJKMZlc8_Ph=9FN--
