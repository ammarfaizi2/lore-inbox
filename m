Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262593AbUKLSX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262593AbUKLSX3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 13:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262600AbUKLSX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 13:23:29 -0500
Received: from main.gmane.org ([80.91.229.2]:7848 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262593AbUKLSXX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 13:23:23 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Alexander Fieroch <Fieroch@web.de>
Subject: Re: SNES gamepad doesn't work with kernel 2.6.x
Date: Fri, 12 Nov 2004 19:23:18 +0100
Message-ID: <4194FF96.4030106@web.de>
References: <cn044e$nnk$1@sea.gmane.org>	 <8ecd274304111108404f3ecd2c@mail.gmail.com>	 <cn0pvt$mcv$1@sea.gmane.org> <8ecd27430411120227411e865f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: osten.wh.uni-dortmund.de
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: de-de, en-us, en
In-Reply-To: <8ecd27430411120227411e865f@mail.gmail.com>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Aristeu Sergio Rozanski Filho wrote:
| could you send the output of 'dmesg' command? it may give a hint of
| what's going on.

hm, when I try to start the module with

# modprobe gamecon gamecon.map=0,1,0,0,0,0

or

# modprobe gamecon gc=0,1,0,0,0,0

I get "gamecon: Unknown parameter `gamecon.map'" in /var/log/syslog and
dmesg.
Just trying to load it with

# modprobe gamecon

returns the error again and no message in /var/log/syslog or dmesg.

# modprobe gamecon
FATAL: Error inserting gamecon
(/lib/modules/2.6.9/kernel/drivers/input/joystick/gamecon.ko): No such
device

So there are no further hints... :-/
How do you load the module? just with "modprobe gamecon" or any parameters?

Greetings,
Alexander

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBlP+WlLqZutoTiOMRAi0/AKCL0LfSeWZRZcSD58oUbwgP6IhYxgCfUAdz
/oYUH19Oyd9RVKTEhm/lzhg=
=kf+m
-----END PGP SIGNATURE-----

