Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbTLCW2w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 17:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbTLCW2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 17:28:52 -0500
Received: from scrye.com ([216.17.180.1]:31411 "EHLO mail.scrye.com")
	by vger.kernel.org with ESMTP id S262009AbTLCW2o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 17:28:44 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Wed, 3 Dec 2003 15:28:38 -0700
From: Kevin Fenzi <kevin@tummy.com>
To: Mark Haverkamp <markh@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux aacraid devel <linux-aacraid-devel@dell.com>
Subject: Re: aacraid and large memory problem (2.6.0-test11)
In-Reply-To: <1070488662.21904.6.camel@markh1.pdx.osdl.net>
References: <20031202193520.74481F7CC8@voldemort.scrye.com>
	<1070396482.16903.11.camel@markh1.pdx.osdl.net>
	<20031203205141.EB67EF7C86@voldemort.scrye.com>
	<1070488662.21904.6.camel@markh1.pdx.osdl.net>
X-Mailer: VM 7.17 under 21.4 (patch 14) "Reasonable Discussion" XEmacs Lucid
Message-Id: <20031203222840.6A4E6F7C86@voldemort.scrye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>>>>> "Mark" == Mark Haverkamp <markh@osdl.org> writes:

Mark> I set up my machine to boot on the aacraid disk and it booted OK
Mark> for me.  Maybe its a problem with a particular model?

Mark> lspci on mine says:

Mark> 02:04.0 RAID bus controller: Digital Equipment Corporation
Mark> DECchip 21554 (rev 01) Subsystem: Adaptec Adaptec 5400S

This one says: 

05:01.0 RAID bus controller: Adaptec AAC-RAID (rev 01)
        Subsystem: Adaptec AAC-RAID
        Flags: bus master, fast Back2Back, 66Mhz, slow devsel, latency 64, IRQ 96
        Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [80] Power Management version 2

It's a 2200S controller. 
bios version 6008

Mark> -- Mark Haverkamp <markh@osdl.org>

kevin
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQE/zmOY3imCezTjY0ERAtOeAKCCCos81FiV0oy89ojnJQiTCK212QCgkO8/
1rARggxxE7xP8YVggM2f6vI=
=+t3d
-----END PGP SIGNATURE-----
