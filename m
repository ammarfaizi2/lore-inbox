Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269665AbUICRL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269665AbUICRL1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 13:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269533AbUICRKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 13:10:41 -0400
Received: from dialin-212-144-166-117.arcor-ip.net ([212.144.166.117]:30882
	"EHLO karin.de.interearth.com") by vger.kernel.org with ESMTP
	id S269527AbUICRJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 13:09:03 -0400
In-Reply-To: <1094220474.7975.11.camel@localhost.localdomain>
References: <1094216504.41386b383000b@rmc60-231.urz.tu-dresden.de> <1094220474.7975.11.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-25--44567937"
Message-Id: <42467D64-FDC1-11D8-9FA0-000A958E35DC@fhm.edu>
Content-Transfer-Encoding: 7bit
Cc: Hendrik Fehr <s4248297@rcs.urz.tu-dresden.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Daniel Egger <degger@fhm.edu>
Subject: Re: PROBLEM: Full CPU-usage on sis5513-chipset disc input/output-operations
Date: Fri, 3 Sep 2004 17:52:28 +0200
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
X-Pgp-Agent: GPGMail 1.0.2
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-25--44567937
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed

On 03.09.2004, at 16:07, Alan Cox wrote:

> For uniprocessor machines you should avoid building with APIC support 
> in
> general anyway. A lot of systems simply don't work with APIC
> uniprocessor because nobody used to use the APIC in such a
> configuration.

This statement I don't understand. Wouldn't it be pretty stupid
not to use the APIC of modern systems if available to get all
the benefits, like additional interrupts? At least my Asus A7V600
refuses to (net-)boot at all without a somewhat recent kernel *and*
APIC enabled in BIOS and kernel because the interrupt routing is
completely messed up. I'd rather let all users who have APIC
problems report on the list and wait until someone fixes the
issue instead of having them shut up and use less advanced
techniques instead unless you want to get those "but it works in
Windows" discussions going...

Servus,
       Daniel

--Apple-Mail-25--44567937
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iQEVAwUBQTiTPTBkNMiD99JrAQKqIgf9ELpgDSP7OmQpduV+KV6gv+a4qmbiYQfL
tYxL8s/LiN8TALLNCxdVDCjukXns34Gs0dRqriJ7yyfIWaT1G7qJmOtq7esKkeZq
QOxwn50my2XbNs/iWNpIIbGUJq/tCOcnOYEd5vluIpODbpdysj227mb8mSjcdXBQ
L1beoGUSY7c79VO13yh2AWqbv6Fq2cGBWTmVmVN2iuj/lZEdEGCSWzgvhZkzBlCP
BKA1P9Lt3ZGt2TPOe6d6FnKX6BIk0FzvrClupR4z9YFDlx+2b3ZV3JB7iRt0OvCw
8LjRV2zQqb41C1JzLllZ636D2uBxGxZxgqMeJcytFMqPS25wX75LNA==
=j1jB
-----END PGP SIGNATURE-----

--Apple-Mail-25--44567937--

