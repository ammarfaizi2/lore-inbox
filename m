Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262340AbULDDF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262340AbULDDF0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 22:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262417AbULDDF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 22:05:26 -0500
Received: from main.gmane.org ([80.91.229.2]:8342 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262340AbULDDFT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 22:05:19 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joshua Kwan <joshk@triplehelix.org>
Subject: Re: [2.6.10-rc2] In-kernel swsusp broken
Date: Fri, 03 Dec 2004 19:05:16 -0800
Message-ID: <41B1296C.8060804@triplehelix.org>
References: <419DC24C.9000902@triplehelix.org> <20041129164112.3d51be93.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
Cc: Pavel Machek <pavel@ucw.cz>
X-Gmane-NNTP-Posting-Host: adsl-68-126-237-170.dsl.pltn13.pacbell.net
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
In-Reply-To: <20041129164112.3d51be93.akpm@osdl.org>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andrew Morton wrote:
| Joshua, any progress on this one?
|
| Thanks.

Yes, I've run through the BK snapshots and have discovered that
something between 2.6.10-rc1-bk14 and 2.6.10-rc1-bk15 killed swsusp for
me. I'm reviewing the interdiff now, which I've put up for reading
convenience at

http://people.debian.org/~joshk/bk14-bk15.diff.bz2

Stay tuned.. I might find something!

- --
Joshua Kwan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQbEpbKOILr94RG8mAQJvGhAAy57ywx68+UwcoGdxa/hBRpfoZWvlPRpP
5Rg0tV/40Dz6tOmJ39NPZZi6+jKQqfOwRtFGA9xSQNm83T7Dd7EhpXEZQguCAAx8
8Jc3APwQVGa4mRpvif73gtZpjiP19uAzsKgXHAUbDeP9smJsAj18AY5/K96Mzm1y
3Gw3W68fn5e1C1Ae3B0DUdhkUey+NjFce6FZahrL4/NalACd7AP+sYf88FRJEiTG
HW+5kvPpuM93ofAfx7pZD9rK/z2mAw+YHyM8I8CgJKL7hnSZTcSSBJqkY7QfXRyB
IEtnqp7C9JzWtL+CmqBhV56DcZr8rlwTtI0hymMr3VFCVNazvC7HWg8rO/mddOAf
EWONfNVWh260MUi+/DNZbTx10Z0vtuHNMmp0NOiCd4f/dnyLlYH1W2MUwWOm3zYK
VYebrqUpZP/BGsdMFiN15yHTYJrJMowtY8aB52vA9MN7pqS/7SxYAsz81QJeT0EW
jkuVNxEu0CMt96pbIXQ7WBeYo69ezPIB26v3nnk32xnBtqSTkpECN6Wi3gQh2Rml
uJ5x2vJU845zyxVJYf6gQM17usMaIYTtcbQ8C34O6zGSEyFR/FyW4r7hK43f7FN3
v0oF/CdeHaZtJgjVe8AYuxyLvs4R3N35ibVvPdQV9ED2024V7ZbQLSQGj7nC1+G7
m7uIRi845+8=
=fwzq
-----END PGP SIGNATURE-----

