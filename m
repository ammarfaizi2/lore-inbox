Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261357AbUJZRoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbUJZRoZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 13:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbUJZRoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 13:44:25 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:48045 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261357AbUJZRnf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 13:43:35 -0400
Message-ID: <417E8CC4.4010706@comcast.net>
Date: Tue, 26 Oct 2004 13:43:32 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041022)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jason Baron <jbaron@redhat.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix altsysrq deadlock
References: <Pine.LNX.4.44.0410261325120.12088-100000@dhcp83-105.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0410261325120.12088-100000@dhcp83-105.boston.redhat.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Jason Baron wrote:
| hi,
|

HI!  ^_^

[...]

|  An
| altsyrq that produces no output might seem troublesome, but it is
| primarily used as a debugging tool, so trying it again seems reasonable.

Actually, I use sysrq as if it's just another feature.  It should (I
think it does. . . not sure) only work on the console directly, for
security reasons; but it's great when things like X misbehave, or when
I've damaged something and the system doesn't want to shut down.  AS-E
AS-I AS-U AS-S AS-O.  :)  I actually tried making an N sysrq, for
"semi-Normal shutdown."  It would send TERM, wait 5S, send KILL, wait
5S, unmount, sync, reboot.

Just thought it might be interesting to point out that magic-sysrq can
be a helpful feature for someone not hacking the kernel.

[...]
- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBfozEhDd4aOud5P8RAo/xAJ9sumPFUpGkwIf4ipR2+6g0bmwUYQCdGQ+U
SPvEFbVzUCx+8zdNQqnT8F8=
=OQrV
-----END PGP SIGNATURE-----
