Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261710AbVAIT2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbVAIT2I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 14:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261726AbVAIT2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 14:28:07 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:52441 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261710AbVAITZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 14:25:17 -0500
Message-ID: <41E18522.7060004@comcast.net>
Date: Sun, 09 Jan 2005 14:25:22 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: printf() overhead
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

using strace to run a program takes aeons.  Redirecting the output to a
file can be a hundred times faster sometimes.  This raises question.

I understand that output to the screen is I/O.  What exactly causes it
to be slow, and is there a possible way to accelerate the process?
- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB4YUhhDd4aOud5P8RAonuAJ0ejEn1+oaiZnJIAGp2kFUyd8pgSwCdFaco
JgKsWYZfEcemGO3mZvL+KZY=
=vWqA
-----END PGP SIGNATURE-----
