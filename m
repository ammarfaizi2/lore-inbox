Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267303AbUHPAPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267303AbUHPAPn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 20:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267311AbUHPAPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 20:15:22 -0400
Received: from smtp1.cwidc.net ([154.33.63.111]:25838 "EHLO smtp1.cwidc.net")
	by vger.kernel.org with ESMTP id S267298AbUHPAOD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 20:14:03 -0400
Message-ID: <411FFC3B.9050808@tequila.co.jp>
Date: Mon, 16 Aug 2004 09:13:47 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: TEQUILA\Japan
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040724
X-Accept-Language: en-us, en, ja
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Radeon FB slightly broken in 2.6.8.x
References: <411F5F7F.9050403@tequila.co.jp> <1092608961.9529.23.camel@gaston>
In-Reply-To: <1092608961.9529.23.camel@gaston>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Benjamin Herrenschmidt wrote:
| On Sun, 2004-08-15 at 23:05, Clemens Schwaighofer wrote:
|
|>-----BEGIN PGP SIGNED MESSAGE-----
|>Hash: SHA1
|>
|>Hi,
|>
|>I am a forced owner of a Radeon 7500 in my Sony Laptop. with 2.6.7 the
|>framebuffer works perfectly fine, but with 2.6.8.x I get strange
|>colerful ascii garbage on the bottom of the screen during booten and
|>then good 10 or more lines are sort of "hidden" outside of the screen.
|>It seems like the screen is not positioned to the end of the output.
|>Kinda strange, cause I first thought it stopped loading exim4 for some
|>reason and not until after I pressed enter a lot I saw that I had a
|>login screen just very far outside of my visual area :)
|>
|>Config attached, but it hasn't chagned to 2.6.7 in the FB area.
|
|
| Does it get back to normal at the end of boot ?

The "colorful" ascii disappear as they are only ~10 lines and they
scroll up. But even after login, the actual cursor is ~10-15 lines
outside of the visible area.

- --
Clemens Schwaighofer - IT Engineer & System Administration
==========================================================
TEQUILA\Japan, 6-17-2 Ginza Chuo-ku, Tokyo 104-8167, JAPAN
Tel: +81-(0)3-3545-7703            Fax: +81-(0)3-3545-7343
http://www.tequila.co.jp
==========================================================
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBH/w6jBz/yQjBxz8RAnCSAJ9bhdf4eppcFqEM0RTreRSwjjyD0gCg2ah/
ZFcqSMs+SegwlPSp6LBMamk=
=P1oP
-----END PGP SIGNATURE-----
