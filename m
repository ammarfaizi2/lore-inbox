Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbTKCQoe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 11:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbTKCQoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 11:44:34 -0500
Received: from b107150.adsl.hansenet.de ([62.109.107.150]:15233 "EHLO ds666")
	by vger.kernel.org with ESMTP id S262098AbTKCQod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 11:44:33 -0500
Message-ID: <3FA685E8.8090706@portrix.net>
Date: Mon, 03 Nov 2003 17:44:24 +0100
From: Jan Dittmer <j.dittmer@portrix.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031013 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephan von Krawczynski <skraw@ithnet.com>
CC: andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Clock skips (?) with 2.6 and games
References: <3FA62DD4.1020202@portrix.net>	<20031103110129.GF1772@x30.random>	<3FA63A57.8070606@portrix.net>	<20031103143656.GA6785@x30.random>	<3FA677D7.1000100@portrix.net> <20031103171101.12b2cb59.skraw@ithnet.com>
In-Reply-To: <20031103171101.12b2cb59.skraw@ithnet.com>
X-Enigmail-Version: 0.81.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stephan von Krawczynski wrote:
| On Mon, 03 Nov 2003 16:44:23 +0100
| Jan Dittmer <j.dittmer@portrix.net> wrote:
|
|>Strange, if I enable Highmem support and set CONFIG_NR_CPUS from 4 to 8,
|>4 penguins are showing up...
|>
|>Jan
|
|
| Have a look at /proc/cpuinfo. Possibly your processor numbers are not
linear ...
|

$ cat /proc/cpuinfo | grep processor
processor       : 0
processor       : 1
processor       : 2
processor       : 3

Quite linear it seems...

Jan

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQE/poXoLqMJRclVKIYRAl35AJ9dblZ5NdfxsKHC0PFnjrBaPRoQNwCdEeF+
HB1xqERdkZDSohEGv6wyhyU=
=NKVi
-----END PGP SIGNATURE-----

