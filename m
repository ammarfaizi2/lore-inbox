Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264054AbUGFPzY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264054AbUGFPzY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 11:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264058AbUGFPzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 11:55:23 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:42953 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S264054AbUGFPzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 11:55:17 -0400
Message-ID: <40EACB64.2010503@comcast.net>
Date: Tue, 06 Jul 2004 11:55:16 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040630)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@gmx.de>
CC: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: post 2.6.7 BK change breaks Java?
References: <20040705231131.GA5958@merlin.emma.line.org>
In-Reply-To: <20040705231131.GA5958@merlin.emma.line.org>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The only thing I've seen kill java like that would be NX things, such as
the NX patch mentioned in an earlier thread; execshield; or PaX.  I saw
some talk about possibly enabling NX by default; but I don't see this in
the -mm6 list, and I have no idea where the bk patch list is.  I
wouldn't expect either Linus or Andrew to have decided to merge an NX
patch in at this stage; but it's a possibility.

Andrew?  Has anything like that been added in the bk tree?

Matthias Andree wrote:
| Hi,
|
| I've pulled from the linux-2.6 BK tree some post-2.6.7 version, compiled
| and installed it, and it breaks Java, standalone or plugged into
| firefox, the symptom is that the application catches SIGKILL. This
| didn't happen with stock 2.6.7 and doesn't happen with 2.6.6 either.
|
| Is there any particular change I should try backing out?
|
| TIA,
|
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA6stihDd4aOud5P8RAnSWAJsGGWL61RC+GIiKk083w6tN5minSQCfSzb4
tstDqu+7FnIyeCSrfSBPrS8=
=pOq9
-----END PGP SIGNATURE-----
