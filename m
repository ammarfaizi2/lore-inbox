Return-Path: <linux-kernel-owner+w=401wt.eu-S1762531AbWLKUFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762531AbWLKUFQ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 15:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763043AbWLKUFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 15:05:16 -0500
Received: from postman.alphatrade.com ([216.187.101.74]:38649 "EHLO
	postman.alphatrade.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762531AbWLKUFP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 15:05:15 -0500
Message-ID: <457DB9AB.1030109@alphatrade.com>
Date: Mon, 11 Dec 2006 12:03:55 -0800
From: Teunis Peters <teunis@alphatrade.com>
User-Agent: Icedove 1.5.0.8 (X11/20061128)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.19 kernel series, SATA, wodim (cd recording), synaptics update,
 CPU speed + Yonah, outside drivers: ipw3945 and ATI video.  Help?
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Currently: 2.6.19-git6
2.6.19-git17 still shows some problems, as well:
	ipw3945 driver did not compile (not sure why) - possibly can solve on
my own though.
		(primary laptop is Acer with ipw2200)
	ATI driver did not compile (showstopper)

synaptics driver: - untested in 2.6.19-git17 as ATI driver necessary.
	- still breaks down - over a couple of days - on 2.6.19-git6.  Suspect
timing problem - and also suspect hardware problem.  Breaks down in
about an hour or two if kernel is at 1000Hz timer.

CD recording : recorder no longer detected by "wodim" software set in
2.6.19.   I suspect it's a bug in the software...  but don't know where
to look for changes.   2.6.19-rc5 worked.
hardware: IDE MATSHITADVD-RAM UJ-820S
(2.6.19-git6 also fails with external LiteON USB DVD burner)

SATA: 2.6.19-git6: long delay booting up (up to 30 seconds!!!).  Intel
945G hardware.   These laptops (HP/Compaq nx6310) will not boot with any
kernel below 2.6.19.  They also use Intel 3945 wireless drivers.
(we're shipping this model with linux - and haven't found a comparable
model price and feature-wise that does not use the same chipset)
These also are Pentium M Yonah CPUS - not properly supported by
cpuspeed.   Not sure how much that's affecting things either.

SATA units use a flash hard drive.   This may be a factor as well.

Any help at all in solving these would be appreciated.

Any suggested kernel patchlevels?   Any specific areas to test?
Configuration settings that matter?

for the ATI driver: it's not for distribution but for my primary work
computer - so anything goes.  I just want it to work.
Everything else here however is quite important.
	- Teunis
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFfbmqbFT/SAfwLKMRAsgsAKCFtNR2Mv0oEkHOYxLqS4KYNn+OEQCeISJ7
skLNYjYMpBMymifreKapmJ0=
=6iVb
-----END PGP SIGNATURE-----
