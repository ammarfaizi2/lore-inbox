Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264104AbTEWR2h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 13:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264105AbTEWR2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 13:28:37 -0400
Received: from mrw.demon.co.uk ([194.222.96.226]:1408 "EHLO rebecca")
	by vger.kernel.org with ESMTP id S264104AbTEWR2g convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 13:28:36 -0400
Content-Type: text/plain; charset=US-ASCII
From: Mark Watts <m.watts@mrw.demon.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: "Latitude with broken BIOS" ?
Date: Fri, 23 May 2003 18:41:37 +0100
User-Agent: KMail/1.4.3
References: <200305231055.14872.brouard@ined.fr>
In-Reply-To: <200305231055.14872.brouard@ined.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200305231841.41650.m.watts@mrw.demon.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Friday 23 May 2003 9:55 am, Brouard Nicolas wrote:
> I am not well aware of what APIC is but I was running Mandrake 8.2 on my
> Linux partition of a Dell Pentium III latitude 550 MHz and I don't remember
> such a dmesg message. But when I upgraded to Mandrake 9.1 here it is. The
> problem I have is that I can't have any suspend mode any more neither
> battery indicators and /etc/rc.d/init.d/apm start claims that apm is no
> more in the kernel. Is it linked to that APIC problem and this BIOS
> problem, why did it work earlier? Do you think that if I found a new bios
> from Dell it will help?
>
> Any information will be greatly appreciated (I am sorry no to be able to
> change my laptop so frequently...)

On my Latitute C610, I have to boot with ACPI=off under Mandrake 9.1 otherwise 
nothing power related works. This allows the kernel to revery back to APM and 
you get battery status things et al.

Mark.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+zl1Va0XO123WNagRAuCFAJ49frC2WTjqEPyGUlD0RkUe3gULPQCfd0bY
caCqMvILiCxP8I3eEcs3pOU=
=0nu8
-----END PGP SIGNATURE-----

