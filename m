Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261803AbVAIVQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261803AbVAIVQb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 16:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbVAIVQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 16:16:30 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:48785 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261803AbVAIVQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 16:16:24 -0500
Message-ID: <41E19F21.20001@comcast.net>
Date: Sun, 09 Jan 2005 16:16:17 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andre Tomt <andre@tomt.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: printf() overhead
References: <41E18522.7060004@comcast.net> <41E188FE.7010609@tomt.net>
In-Reply-To: <41E188FE.7010609@tomt.net>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Andre Tomt wrote:
| John Richard Moser wrote:
|
|> using strace to run a program takes aeons.  Redirecting the output to a
|> file can be a hundred times faster sometimes.  This raises question.
|>
|> I understand that output to the screen is I/O.  What exactly causes it
|> to be slow, and is there a possible way to accelerate the process?
|
|
| The terminal is a major factor; gnome-terminal for example can be
| *extremely* slow.
|

Is there a way to give the data to the terminal and let the program go
while that happens?  Or is there an execution path (i.e. terminal says
"WTF NO") that can be missed that way?

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB4Z8hhDd4aOud5P8RAnhBAJ40RgKIcXdCvhnuHlfZyK60xswjGwCdFef2
rmwEL/yAR74Q96VkpEV6Z2s=
=bpD8
-----END PGP SIGNATURE-----
