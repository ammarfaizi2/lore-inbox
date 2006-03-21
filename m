Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932334AbWCURDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbWCURDO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 12:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbWCURDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 12:03:14 -0500
Received: from rwcrmhc12.comcast.net ([204.127.192.82]:23714 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751331AbWCURDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 12:03:13 -0500
Message-ID: <44203179.3090606@comcast.net>
Date: Tue, 21 Mar 2006 12:01:45 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mail/News 1.5 (X11/20060309)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Lifetime of flash memory
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I have a kind of dumb question.  I keep hearing that "USB Flash Memory"
or "Compact Flash Cards" and family have "a limited number of writes"
and will eventually wear out.  Recommendations like "DO NOT PUT A SWAP
FILE ON USB MEMORY" have come out of this.  In fact, quoting
Documentation/laptop-mode.txt:

  * If you're worried about your data, you might want to consider using
    a USB memory stick or something like that as a "working area". (Be
    aware though that flash memory can only handle a limited number of
    writes, and overuse may wear out your memory stick pretty quickly.
    Do _not_ use journalling filesystems on flash memory sticks.)

The question I have is, is this really significant?  I have heard quoted
that flash memory typically handles something like 3x10^18 writes; and
that compact flash cards, USB drives, SD cards, and family typically
have integrated control chipsets that include wear-leveling algorithms
(built-in flash like in an iPaq does not; hence jffs2).  Should we
really care that in about 95 billion years the thing will wear out
(assuming we write its entire capacity once a second)?

I call FUD.

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond

    We will enslave their women, eat their children and rape their
    cattle!
                                     -- Evil alien overlord from Blasto
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRCAxdws1xW0HCTEFAQJd6w//auD2v3RJYxTbUePJwXFriCTO2d35+uo1
xU80/Brd7Hkdn82hfk/Rozoj6zsZFYYpYqqDhvo0aOKUW/cxZhTymXlEUgNXx0k+
s2hkVM4+nXoJhQhFuLk3/bPXBQlu20xA1tt6pHMscIfavijPSn7aV7gPx+L+SpDD
VqGdsmynt68IRk09b9su0gsfuM0OxYrjVAXPN5l+cjzlEk+fyHGIALu26UwiL+31
Gs86zviWaX1MwK5G0IZQ0ITySG/wNGoMNcbSdbm/45r0JnLhHPQjX2WGwIh7t5Y2
UeoYLRZJ5gRF9PT0yP5tMy0XXhKpj0aEtl8ccB/aeOCPsUKAC+2K2SFCfZLZCj8x
GOGeJKsutim+H+Qec/lnOng1LYoA9fJaisGzAUEOHYhFuYOioPVvGBKiRQlX6mMf
ofCAIOwtzWgxTa4kJrhU3oF0DYhLtP7Je/LCQW0RqmnMrXcR23/AwBa5fHTzhW1C
Mb6eL1TtYPYoyoBcKKYgKMmXLXu4d2klgxM4RRpcCrVfrupsHXr5VSzt+XYf7twX
TnY6DhmVVqp1YIVbWPXbNHplQuOU7ywdu+Y7q75jywqFBxGqeo+mPoL8ItW3IthZ
/zaoJVUH+n0FyydC+FYJ3SWx7AkPx46hZmO2UQmVlOAq2Fuc8I3haaOIQmADt0Ar
pwGzS3E92J0=
=48mD
-----END PGP SIGNATURE-----
