Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264238AbUGFRte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264238AbUGFRte (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 13:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbUGFRte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 13:49:34 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:36553 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S264238AbUGFRtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 13:49:32 -0400
Message-ID: <40EAE62D.8090800@comcast.net>
Date: Tue, 06 Jul 2004 13:49:33 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040630)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@gmx.de>
CC: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: post 2.6.7 BK change breaks Java?
References: <20040705231131.GA5958@merlin.emma.line.org> <40EACB64.2010503@comcast.net> <20040706161451.GA26925@merlin.emma.line.org>
In-Reply-To: <20040706161451.GA26925@merlin.emma.line.org>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Matthias Andree wrote:
| On Tue, 06 Jul 2004, John Richard Moser wrote:
|
| I've been pointed to the NX feature off-list and investigated, my CPU
| (AMD Athlon XP 2500+ Model 10 "Barton") doesn't support the noexec flag,

Your CPU doesn't need to support an NX flag.  See
http://en.wikipedia.net/wiki/PaX for two ways to mimic the same
functionality.  I'm not sure if any noexec patches other than PaX can do
this though; the thing IS about 3 years old.

Anyway, it was just a longshot.  I've got nothing else to offer on the
subject of java dying because of in-kernel issues.

| and dmesg does not contain any output that MX was enabled, and the Java
| "Killed" problem persists when the kernel is booted with noexec=off.
|
| It must have entered the tree between v2.6.7 and revision 1.1757 in
| Linus' tree.
|
| BTW, how do I tell BitKeeper "pull up to revision..."?  bk pull and bk
| undo -aREV is a way, but it's wasteful.
|
Dunno.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA6uYrhDd4aOud5P8RAsDwAKCANubhFZRy8cMywXF+/VFzX+sNNgCfY5l9
0u+mKXtBIimd4xQSEVIplJE=
=RXue
-----END PGP SIGNATURE-----
