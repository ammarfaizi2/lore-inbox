Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268039AbUJSGlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268039AbUJSGlF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 02:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268040AbUJSGlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 02:41:05 -0400
Received: from cerebus.immunix.com ([198.145.28.33]:13463 "EHLO
	haldeman.int.wirex.com") by vger.kernel.org with ESMTP
	id S268039AbUJSGlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 02:41:00 -0400
Date: Mon, 18 Oct 2004 23:40:59 -0700
From: Seth Arnold <sarnold@immunix.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.9, gpm, framebuffer console --> blanking characters
Message-ID: <20041019064059.GD4415@immunix.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="osDK9TLjxFScVI/L"
Content-Disposition: inline
X-Paranoia-1: Greetings CIA, FBI, MI5, NSA, ATF, Treasury, Ashcroft, Immigration!
X-Paranoia-2: A huge shout-out to my Big Brother, John Poindexter!
X-Paranoia-3: All your base are belong to U.S.
X-spamtrap: smart.monkies@nanas.surriel.com
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--osDK9TLjxFScVI/L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello, I'm using linux 2.6.9, Debian's gpm 1.19.6-18 package, on my g3
ibook. I'm using the frame buffer console. I've compiled in:

CONFIG_FB=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_OF=y
CONFIG_FB_RADEON=y
CONFIG_FB_RADEON_I2C=y

When I use gpm to "mouse over" characters on the console, the character
under the cursor is removed, and it isn't re-drawn when the mouse leaves
the character. It is only re-drawn when selected with gpm -- scrolling
the screen doesn't re-paint the characters.

So, the screen will look something like this:

# CONFIG_FB_ATY128 is not set
# CONFIG     TY is not set
# CONFIG FB_  S is no    t
# CONFIG FB_N  MAGIC  s not set
# CONFI  FB_KY   is  ot set
# CONFIG_FB_3DF     not set

lspci reports:
0000:00:10.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M6 LY

Any suggestions? Thanks

--osDK9TLjxFScVI/L
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBdLb7+9nuM9mwoJkRArTBAJ9p9tV8nuaRGheQkYld4lSKhpUfUgCgkM+C
4AXZfGvg5zQW7ze/BQnjhFg=
=vP/r
-----END PGP SIGNATURE-----

--osDK9TLjxFScVI/L--
