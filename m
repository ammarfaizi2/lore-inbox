Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264968AbTFCLqg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 07:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264970AbTFCLqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 07:46:36 -0400
Received: from camus.xss.co.at ([194.152.162.19]:22802 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id S264968AbTFCLqf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 07:46:35 -0400
Message-ID: <3EDC8DC0.7090009@xss.co.at>
Date: Tue, 03 Jun 2003 14:00:00 +0200
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Haumer <andreas@xss.co.at>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: system clock speed too high?
References: <3EDBA83B.5050406@xss.co.at> <1054582573.7494.51.camel@dhcp22.swansea.linux.org.uk> <3EDC7052.9060109@xss.co.at>
In-Reply-To: <3EDC7052.9060109@xss.co.at>
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi!

I have some more information

6.) Kernel 2.4.19-ac4 (ACPI compiled as modules)
    a) no special kernel commandline option
       -> System does boot, fusion MTP driver finds the controller
       -> time runs 2.5 times too fast

    b) boot with "acpi=off"
       -> Same as 6a)

    c) boot with "acpi=off notsc"
       -> Same as 6a)

I tried also the following BIOS settings, but without
improving the situation:

*) Hyperthreading "disabled"
*) MPS 1.4 Support "disabled"
*) BIOS Update "disabled"
*) Plug & Play "yes" (this makes it even worse: linux crashes
               eventually as it gets confused by IRQ setting)

- - andreas

- --
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+3I2/xJmyeGcXPhERAjXOAKCc7lD6Y+oYUyvNtqVT/dj+HBpP+wCfcWI4
/Pfay3OP/7/XPxpIbBAE9X4=
=cIUN
-----END PGP SIGNATURE-----

