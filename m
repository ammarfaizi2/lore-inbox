Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266477AbUGKCJr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266477AbUGKCJr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 22:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266478AbUGKCJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 22:09:46 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:44219 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S266477AbUGKCJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 22:09:44 -0400
Message-ID: <40F0A165.9090203@comcast.net>
Date: Sat, 10 Jul 2004 22:09:41 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040630)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: vlobanov <vlobanov@speakeasy.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Quick question.
References: <Pine.LNX.4.58.0407101826040.19771@shell1.speakeasy.net>
In-Reply-To: <Pine.LNX.4.58.0407101826040.19771@shell1.speakeasy.net>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I believe that terminating the thread executing main() terminates the
program.

vlobanov wrote:
| Hi,
|
| I have a quick question about a supposed scenario.
|
| Suppose you have two pthreads - a main pthread and a utility pthread -
| both running in the same application. The utility pthread is currently
| in the middle of doing a recv() call on a network socket. At the same
time,
| the main pthread decides that it's time to exit, and either returns or
| does a series of fork()/execv() calls. Is the behavior of the utility
| pthread in such a case deterministic, and if so, what is it?
|
| Thanks in advance for the help.
|
| -Vadim Lobanov
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/
|
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA8KFkhDd4aOud5P8RAgr6AJ9wxIQzbxQfsuucbVT/362Mjaz+NgCgjYYd
VCJKlbnXyAAjQhOlZeqypwM=
=Ys+h
-----END PGP SIGNATURE-----
