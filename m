Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266816AbUFYQre@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266816AbUFYQre (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 12:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266806AbUFYQqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 12:46:34 -0400
Received: from mail018.syd.optusnet.com.au ([211.29.132.72]:42675 "EHLO
	mail018.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266807AbUFYQqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 12:46:14 -0400
Message-ID: <40DC56CB.5040907@kolivas.org>
Date: Sat, 26 Jun 2004 02:46:03 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040615)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Buesch <mbuesch@freenet.de>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Staircase scheduler v7.4
References: <200406251840.46577.mbuesch@freenet.de>
In-Reply-To: <200406251840.46577.mbuesch@freenet.de>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Michael Buesch wrote:
| Hi,
|
| I just applied the patch against 2.6.7-bk7 and saw
| the following strange thing:
|
| I was compiling some program, as suddenly compilation
| stopped. g++ was running (sorry, I didn't look at the
| process state. Maybe it was in T or something like that),
| but it didn't get any timeslice. (so didn't execute. Simply
| stayed around and didn't finish).
| I noticed this since I switched from staircase 7.1 to 7.4
| a few minutes ago. No such problems before.
| I'm not really sure, if it's a staircase problem. Just
| wanted to let you know.

I haven't seen what is in -bk7 so I don't know if there's an issue with
applying it to that. Anything's possible, though. See if you can
reproduce it and isolate it to staircase or not and collect some more
info about what is happening with the task from top, vmstat and
/proc/$pid/status

Cheers,
Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA3FbLZUg7+tp6mRURAhYpAJ0de38QQsNCSeM+t++OjOeCcTIN/wCfTLMj
mZJ/IUxcRip4VInYzFsH1Nk=
=yXKm
-----END PGP SIGNATURE-----
