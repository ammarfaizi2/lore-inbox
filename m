Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270227AbTG1QM5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 12:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270272AbTG1QM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 12:12:57 -0400
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:32521 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S270227AbTG1QMy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 12:12:54 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: "Hen, Shmulik" <shmulik.hen@intel.com>
Subject: Re: Ethernet falls into deep sleep.
Date: Mon, 28 Jul 2003 18:28:02 +0200
User-Agent: KMail/1.5.2
References: <E791C176A6139242A988ABA8B3D9B38A014C942C@hasmsx403.iil.intel.com>
In-Reply-To: <E791C176A6139242A988ABA8B3D9B38A014C942C@hasmsx403.iil.intel.com>
Cc: "linux kernel mailing list" <linux-kernel@vger.kernel.org>,
       <linux-net@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200307281828.12143.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Monday 28 July 2003 13:39, Hen, Shmulik wrote:
> It sounds like an ACPI issue. If ACPI is configuring the NIC to do
> wake-on-lan on pattern matching (I believe it does that by default), than a
> simple arp "who-has" packet with the target machine's IP address will do.
> You can take one other machine and clear the arp entry of the specific
> machine you're trying to wake, and then do ping. The first thing your other
> machine will send is an arp request that should wake the server up.
>
> BTW, if this server is not supposed to be sleeping at all, you should
> consider turning ACPI (or maybe APM?) off.

Yes, that's a good point.
I'll compile a kernel without any powermanagement (the server-hardware
doesn't support it correctly, so it's no problem :) ).

I'll write back, if it still fails, but it may take a few days.

- -- 
Regards Michael Buesch
http://www.8ung.at/tuxsoft
Penguin on this machine:  Linux 2.4.21  - i386

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/JU8coxoigfggmSgRAtNFAJ0Qm/fCNUMlNyhQTRciHyQQLtgsAgCeLC4M
C3+mTDRkc8ZSgMBMHHOjuWg=
=lG5u
-----END PGP SIGNATURE-----

