Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261833AbTILUz0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 16:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbTILUz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 16:55:26 -0400
Received: from smtp2.globo.com ([200.208.9.169]:43219 "EHLO mail.globo.com")
	by vger.kernel.org with ESMTP id S261833AbTILUzW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 16:55:22 -0400
From: Marcelo Penna Guerra <eu@marcelopenna.org>
To: linux-kernel@vger.kernel.org
Subject: Re: SII SATA request size limit
Date: Fri, 12 Sep 2003 17:55:06 -0300
User-Agent: KMail/1.5.9
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200309121755.20746.eu@marcelopenna.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Witold Krecicki escreveu:

> I've lost some of mails about siimage on LKML, but Im' getting more and more 
> confused about 'hangs' probably caused by siimage driver. I was using 15 
> rqsize, now 128 - doesn't matter. It happens in random moments - sometimes 
at 
> boot time when drive is fscked, sometimes when I'm trying to copy large 
> amount of data and sometimes without any particular reason after several 
> hours. I've updated MB (a7n8x deluxe rev 2.0) BIOS but controller (which is 
> on-board) bios seems to be untouched (4.1.25 or so ). Is there any 
controller 
> BIOS update which I could miss? what can be other reason

Do you have APIC enabled? If you enable both ACPI and APIC you'll have 
problems with DMA, using the onboard nForce2 IDE or the SATA chip. I filled a 
bug report and will add some debug info as soon as I recompile my kernel with 
APIC and debug support again.

Marcelo Penna Guerra
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/YjK2D/U0kdg4PFoRAjWfAJ4qsWrGksxVzme3Nm1T14n6/ocVRQCgkdhS
0216vc1WSC+ercfYTLkDJxQ=
=pLvp
-----END PGP SIGNATURE-----
