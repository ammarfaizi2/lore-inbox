Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262246AbTHaOeF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 10:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262255AbTHaOeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 10:34:05 -0400
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:23257 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262246AbTHaOeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 10:34:02 -0400
Date: Sun, 31 Aug 2003 16:33:59 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: HEADS UP lk-changelog/shortlog: security announcement
Message-ID: <20030831143359.GD30252@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Anyone who uses lk-changelog.pl or shortlog
(YES THIS COMPRISES YOU, MARCELO ;-) 
with these option combinations:

- --mode=terse AND NOT --noobfuscate

- --mode=oneline AND NOT --noobfuscate

please be aware that address obfuscation of unknown addresses does not
work (I'll consider that an information leak given that addresses and
logs are web accessible through archives and are actually harvested by
those saboteurs that call themselves direct advertisers), so you may get
lines like:

  o example change log entry (user@example.org)

Rather than

  o example change log entry (user:example.org)

The issue was fixed in 0.166; 0.167 is the latest release version.

Get it from:

BK:  bk://129.217.163.1   (NO trailing slash, bkd -xcd there!)

Once Linus pulls these changes, it will also become available at the

official repository: bk://kernel.bkbits.net/torvalds/tools/

WWW: http://mandree.home.pages.de/linux/kernel/
this site carries releases and GnuPG signatures

(Yes, the GPG signing key has changed recently,
the days of PGP 2.x are passing...)

- -- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/UgdOvmGDOQUufZURAkqTAJ9PlcQHCeNcC0CbM6fnEzIub6l1RwCfV3Jn
1cyDzwKTReYEIwEyxtMsjPM=
=e3ZP
-----END PGP SIGNATURE-----
