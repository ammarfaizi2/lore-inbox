Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265931AbUAULMQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 06:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265932AbUAULMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 06:12:16 -0500
Received: from dsl-213-023-011-163.arcor-ip.net ([213.23.11.163]:60365 "EHLO
	fusebox.fsfeurope.org") by vger.kernel.org with ESMTP
	id S265931AbUAULML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 06:12:11 -0500
To: linux-kernel@vger.kernel.org
Cc: Martin Loschwitz <madkiss@madkiss.org>
Subject: PROBLEM: ACPI freezes 2.6.1 on boot
From: "Georg C. F. Greve" <greve@gnu.org>
Organisation: Free Software Foundation Europe - GNU Project
X-PGP-Fingerprint: 2D68 D553 70E5 CCF9 75F4 9CC9 6EF8 AFC2 8657 4ACA
X-PGP-Affinity: will accept encrypted messages for GNU Privacy Guard
X-Home-Page: http://gnuhh.org
X-Accept-Language: en, de
Date: Wed, 21 Jan 2004 12:12:05 +0100
Message-ID: <m3isj5a73u.fsf@reason.gnu-hamburg>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="==-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==-=-=
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=

Hi all,

I've seen the mail by Martin Loschwitz of January 1st 2004, in which
he reported:

 > I'm writing this mail as I'm discovering ACPI related problems on
 > my Acer TravelMate 800LCi notebook with Linux 2.6.1-rc1-mm1.

 > While the system boots up fine with Linux 2.6.1-rc1, with
 > 2.6.1-rc1-mm1 it hangs while booting. The last message printed to
 > screen is "ACPI: IRQ 9 was Edge Triggered, setting to Level
 > Triggerd". This is fully reproducable with a Linux 2.6.0 kernel
 > which has the ACPI20031203 patch applied.

I'm now seeing the _exact same problem_ on an ASUS M2400N [*] with a
Linux 2.6.1 (unpatched) kernel. The kernel freezes after printing 

 "ACPI: IRQ 9 was Edge Triggered, setting to Level Triggerd" 

(yes, the typo is in the kernel, it seems)

I've seen no reply to his mail. Has the problem been solved or is it
still a known bug(tm)?

Martin? Were you successful in resolving that problem?

Regards,
Georg


[*] Pentium 4 M Centrino, 1.6, 512MB, Intel 855GM chipset

-- 
Georg C. F. Greve                                       <greve@gnu.org>
Free Software Foundation Europe	                 (http://fsfeurope.org)
Brave GNU World	                           (http://brave-gnu-world.org)

--=-=-=--
--==-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP MESSAGE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQFADl6FbvivwoZXSsoRAlD3AJ0VLWeE14eQ4w1z8BJL6XrYAvI8lwCeIe2T
BRdEmqj36rd9gG9kq390lGg=
=smyZ
-----END PGP MESSAGE-----
--==-=-=--
