Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261663AbVAYG0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261663AbVAYG0W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 01:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbVAYG0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 01:26:22 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:29932 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261663AbVAYG0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 01:26:08 -0500
Message-ID: <41F5E686.1080205@comcast.net>
Date: Tue, 25 Jan 2005 01:26:14 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Complex logging in the kernel
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

What systems exist for complex logging and security auditing in the kernel?

For example, let's say I wanted to register my specific code (i.e. a
security module) to log, and adjust to log level N.  I also want another
module to log at log level L, which is lower than N.  I want to print
logs at log level N..+2 and below to the console, but silently log all
log messages >N+2 to the syslog.

Anything?

If there's nothing, I'll write one.  Shouldn't be too hard.
- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB9eaGhDd4aOud5P8RAlacAKCBztJpKckHnYHrfyiUxiHOdIBqXACgjuoA
Wk8hEbKRKWSWGsLZ1WGqKto=
=zYCD
-----END PGP SIGNATURE-----
