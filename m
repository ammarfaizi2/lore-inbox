Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbTFAHKJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 03:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbTFAHKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 03:10:09 -0400
Received: from stingr.net ([212.193.32.15]:55223 "EHLO hq.stingr.net")
	by vger.kernel.org with ESMTP id S261564AbTFAHKI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 03:10:08 -0400
Date: Sun, 1 Jun 2003 11:23:29 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: linux-kernel@vger.kernel.org
Subject: ACPI interrupt storm (was Re: Linux 2.4.21rc6-ac1)
Message-ID: <20030601072329.GB6067@stingr.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200305311153.h4VBrNi21640@devserv.devel.redhat.com> <3ED9158E.2080904@xss.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <3ED9158E.2080904@xss.co.at>
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Replying to Andreas Haumer:
> 2.) ACPI itself doesn't work right anymore and makes the system
>     unusable... :-(
>     It did work with the last AC kernel I tried (2.4.21-rc2-ac2)
> 
>     Symptoms are:
>     No ethernet, NIC (Intel eepro100) doesn't get interrupts,
>     ACPI interrupt "storm" (millions of IRQ in a few minutes)
> 
>     Booting with "acpi=off" makes the system work again, but without
>     ACPI, of course.
> 
>     Here are a few more infos from the running system:
> 
>     Asus P4B motherboard, P4 1.6GHz processor, 1.2GB RAM

I am here experiencing almost same behavior, but I didnt collected enough
data to isolate the problem
few points:
1. It is new acpi code, backported by alan in latest -ac. Previous (2.4)
acpi "works" (err, it's outdated and more but at least no interrupt storm).
I didnt tried running 2.5 on the target machine yet.

2. all other devices working fine. The only visible things are slow mouse
responsiveness and >60k interrupts per second at vmstat output

The box is p4-based fujitsu scenic. More information is available on request.
And I will try 2.5 on it soon.

- -- 
Paul P 'Stingray' Komkoff Jr // http://stingr.net/key <- my pgp key
 This message represents the official view of the voices in my head
-----BEGIN PGP SIGNATURE-----

iD8DBQE+2anlyMW8naS07KQRAgMpAJ9ZEMyG8EuRyAM/mis0lLK8/8Xw7QCgw0it
CZpTv8PL4In4Tn8iDn8oH1s=
=SvQM
-----END PGP SIGNATURE-----
