Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275222AbTHGIUz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 04:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275229AbTHGIUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 04:20:54 -0400
Received: from mta11.srv.hcvlny.cv.net ([167.206.5.46]:24503 "EHLO
	mta11.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S275222AbTHGIUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 04:20:53 -0400
Date: Thu, 07 Aug 2003 04:20:37 -0400
From: Jeff Sipek <jeffpc@optonline.net>
Subject: Re: [PATCH][TRIVIAL] Bugzilla bug # 322 - double logical operator
 drivers/char/sx.c
In-reply-to: <3F319EE7.8010409@techsource.com>
To: Timothy Miller <miller@techsource.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <200308070420.45464.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: Text/Plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-description: clearsigned data
User-Agent: KMail/1.5.2
References: <200308061830.05586.jeffpc@optonline.net>
 <3F319EE7.8010409@techsource.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wednesday 06 August 2003 20:35, Timothy Miller wrote:
> Josef 'Jeff' Sipek wrote:
> > Just a simple fix to make the statements more readable. (instead of
> > "i < TIMEOUT > 0" the statement is divided into two, joined by &&.)
>
> Can you really DO (x < y > z) and have it work as an anded pair of
> comparisons?  Maybe this is an addition to C that I am not aware of.
>
> I would expect (x < y > z) to be equivalent to ((x < y) > z).

Odd, this has been in the kernel ever since Linus started using BK. I didn't 
check pre-BK. I wonder what the author intended to say. (I believe in the 
((a<b) && (b>c)) theory.)

Jeff.

- -- 
Don't drink and derive. Alcohol and algebra don't mix.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/MgvZwFP0+seVj/4RAjOUAKCVhi17CzCtv+4jhoKg04BkDBftiwCfeZUW
ri0/IEXltFT73QrOfFsRwcU=
=vd/t
-----END PGP SIGNATURE-----

