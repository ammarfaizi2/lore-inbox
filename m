Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbTKHASm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 19:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbTKGWH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:07:56 -0500
Received: from b107150.adsl.hansenet.de ([62.109.107.150]:40323 "EHLO ds666")
	by vger.kernel.org with ESMTP id S264108AbTKGMOd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 07:14:33 -0500
Message-ID: <3FAB8CA1.7040105@portrix.net>
Date: Fri, 07 Nov 2003 13:14:25 +0100
From: Jan Dittmer <j.dittmer@portrix.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031013 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: test9: suspend no go
References: <3F9BCF7A.7000403@portrix.net> <20031107100609.GA5088@elf.ucw.cz>
In-Reply-To: <20031107100609.GA5088@elf.ucw.cz>
X-Enigmail-Version: 0.81.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Pavel Machek wrote:
| Hi!
|
|
|
|>A little contribution to the ongoing suspend saga. This is a Sony Vaio
|>SRX51P Laptop (P3 Mobile CPU, i820 chipset).
|
|
|
| Few tips:
|
| If you want to trick swsusp/S3 into working, you might want to try:
|
| * go with minimal config, turn off drivers like USB you don't really
| need
|

Tried it with minimal config. Base problem is, that after suspending,
I've no way to wake up the laptop again, but power cycling.
That means:
~  "mem": after power cycling it is doing a 'normal' reboot. (okay memory
contents is lost, so this is somewhat expected)
~  "disk": hey, after power cycling it indeed resumes to the previous
state. so I tried to compile in some more stuff. What breaks it is AGP
support :-(. Are there any patches around which may fix this?

Any idea, why the laptop is not powering on again after suspend? I can
hold down the power switch as long as I want to, but the laptop doesn't
do a thing.

Thanks,

Jan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQE/q4yhLqMJRclVKIYRAhh4AJwNu4a2oTInCYYdCc2NaTBn95hD5ACdE1Yy
Tk9bBATbxBs2+NE7eLvNTmg=
=nih5
-----END PGP SIGNATURE-----

