Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265019AbTFCOKG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 10:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265020AbTFCOKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 10:10:06 -0400
Received: from camus.xss.co.at ([194.152.162.19]:51464 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id S265019AbTFCOKE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 10:10:04 -0400
Message-ID: <3EDCAF61.3060202@xss.co.at>
Date: Tue, 03 Jun 2003 16:23:29 +0200
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: system clock speed too high?
References: <3EDBA83B.5050406@xss.co.at>	 <1054582573.7494.51.camel@dhcp22.swansea.linux.org.uk>	 <3EDC7052.9060109@xss.co.at> <3EDC8DC0.7090009@xss.co.at>	 <3EDC96EA.5020906@xss.co.at> <1054645247.9359.12.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1054645247.9359.12.camel@dhcp22.swansea.linux.org.uk>
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi!

Alan Cox wrote:
> USB legacy generates SMI events. It could be that something
> the BIOS SMI magic is doing is disrupting the system clock
> or causing extra interrupts
>
Thanks for your support.

The "USB legacy support" settings slipped through when
I was preparing the system. I was too much concentrated
on the ACPI/Fusion MPT problems...

But something must be wrong in this area, as the kernel prints
this "..MP-BIOS bug: 8254 timer not connected to IO-APIC"
message when USB legacy support is disabled.

Anyway, I'll have this system available for tests in the
next few days (it is to be installed as production server
next week), and it _will_ suffer a lot from the stress tests
I've planned... ;-)

So if you want me to test anything (ACPI patches, perhaps?)
you're very welcome!

- - andreas

- --
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+3K9fxJmyeGcXPhERAsqfAJkBJS/W5DxjPLYh2f7795j9Xx2pDACfcFXG
rAKbPhQrxpGnAW3xFv1G3u4=
=J0bc
-----END PGP SIGNATURE-----

