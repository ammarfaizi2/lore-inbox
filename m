Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbTKCRAN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 12:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262149AbTKCRAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 12:00:13 -0500
Received: from b107150.adsl.hansenet.de ([62.109.107.150]:27520 "EHLO ds666")
	by vger.kernel.org with ESMTP id S262139AbTKCRAI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 12:00:08 -0500
Message-ID: <3FA6898D.3050603@portrix.net>
Date: Mon, 03 Nov 2003 17:59:57 +0100
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
|
|
| Have a look at /proc/cpuinfo. Possibly your processor numbers are not
linear ...
|

Ah, sorry, on boot they are numbered differently:

(from dmesg)

ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 Pentium 4(tm) XEON(tm) APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x06] enabled)
Processor #6 Pentium 4(tm) XEON(tm) APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] enabled)
Processor #1 Pentium 4(tm) XEON(tm) APIC version 20
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x07] enabled)
Processor #7 Pentium 4(tm) XEON(tm) APIC version 20

So thanks again and sorry for the noise,

Jan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQE/pomNLqMJRclVKIYRAhWyAJ9yfFPC/Liumt19sswdDK2PCaC7tgCdH9rT
VyQ0a2d0OX+OZZCMeMVje54=
=FMDH
-----END PGP SIGNATURE-----

