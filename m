Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbVBQXWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbVBQXWe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 18:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbVBQXVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 18:21:17 -0500
Received: from [195.32.84.175] ([195.32.84.175]:54445 "EHLO
	host01.pcaserver.com") by vger.kernel.org with ESMTP
	id S261234AbVBQXTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 18:19:18 -0500
To: Pavel Machek <pavel@suse.cz>
Cc: ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>, seife@suse.de, rjw@sisk.pl
Subject: Re: [ACPI] Call for help: list of machines with working S3
References: <20050214211105.GA12808@elf.ucw.cz>
From: Luca Capello <luca@pca.it>
Date: Fri, 18 Feb 2005 00:19:08 +0100
In-Reply-To: <20050214211105.GA12808@elf.ucw.cz> (Pavel Machek's message of
 "Mon, 14 Feb 2005 22:11:05 +0100")
Message-ID: <87ekfe7p1v.fsf@gismo.pca.it>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hello Pavel!

On Mon 14 Feb 2005 22:11, Pavel Machek wrote:
> Stefan provided me initial list of machines where S3 works (including
> video). If you have machine that is not on the list, please send me a
> diff. If you have eMachines... I'd like you to try playing with

Sorry, but a diff of what? Of the list?

> Table of known working systems:
>
> Model                           hack (or "how to do it")
> ------------------------------------------------------------------------------
IBM ThinkPad T42p (2373-GTG [1])  acpi_sleep=s3_bios (2)

More info available upon request, but in general:

- Debian unstable
- vanilla kernel 2.6.10
- ACPI patch 20050125
- BlueZ patch -mh4
- IBM trackpoint patch [2]
- radeonfb
- radeon XFree86 4.3.0.dfsg.1-11
- all modules my laptop support installed (and loaded ;-) )
- I used a script that switch to vc1 and stop mysql (this is a known
  problem [3] [4]), then "echo -n [mem|disk] > /sys/power/state"

I've a working S4 with the same configuration, too. But it seems I
still suffer a problem about hwclock I already reported with another
laptop [5] [6]. In this case, the command proposed seems not working
anymore (I should test more deeply, just a question of time ;-) ).

Anyway, this laptop works very well!

I've also a docking station [7], I'll test with it ASAP.

Thx, bye,
Gismo / Luca

[1] http://www5.pc.ibm.com/ch/products.nsf/$wwwPartNumLookup/_UC2GTSE?OpenDocument
[2] http://people.clarkson.edu/~evanchsa/
[3] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=259745
[4] http://bugs.mysql.com/bug.php?id=4596
[5] http://sourceforge.net/mailarchive/message.php?msg_id=9844751
[6] http://sourceforge.net/mailarchive/message.php?msg_id=9864402
[7] http://www5.pc.ibm.com/ch/products.nsf/$wwwPartNumLookup/_74P6733?OpenDocument

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCFSZuVAp7Xm10JmkRAsdJAJ9a7akid+HSKOlG9jbI1JQSDWeGkgCZAdWN
HOQAbgLCYlzk+gFYkoBQux0=
=zCko
-----END PGP SIGNATURE-----
--=-=-=--
