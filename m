Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261947AbUFQTeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbUFQTeW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 15:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262766AbUFQTeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 15:34:22 -0400
Received: from ms-1.rz.RWTH-Aachen.DE ([134.130.3.130]:58321 "EHLO
	ms-dienst.rz.rwth-aachen.de") by vger.kernel.org with ESMTP
	id S261947AbUFQTeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 15:34:20 -0400
Date: Thu, 17 Jun 2004 21:23:33 +0200
From: Alexander Gran <alex@zodiac.dnsalias.org>
Subject: Re: ACPI S3 - USB resume problem (kernel 2.6.7)
In-reply-to: <200406171744.29244.cr7@os.inf.tu-dresden.de>
To: Carsten Rietzschel <cr7@os.inf.tu-dresden.de>
Cc: linux-kernel@vger.kernel.org
Message-id: <200406172123.38043@zodiac.zodiac.dnsalias.org>
MIME-version: 1.0
Content-type: Text/Plain; charset=iso-8859-15
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.6.2
X-Ignorant-User: yes
References: <200406171744.29244.cr7@os.inf.tu-dresden.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am Donnerstag, 17. Juni 2004 17:44 schrieb Carsten Rietzschel:
> Noticed that in /proc/interrupts the values for uhci_hcd are not
> incremented after resume. So are no IRQs where received (is that right ?).
> What could be reason ?

No Idea. I also tried to get this working, without success (And no more time 
at the moment to dig deeper). The e1000 driver has the same problem. No 
Interrupts on RX. Someone suggested to "Hook the driver to the timer 
interrupt and see if that works at least somehow", however I'm unsure how to 
do that ;)

regards
Alex

- -- 
Encrypted Mails welcome.
PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA0e+4/aHb+2190pERAseiAJ9vtdew4kLYFdeGUu735Cb7As8afwCff9qN
VVtwNWQpVIWz3yLR5P/O7m8=
=BA0Z
-----END PGP SIGNATURE-----

