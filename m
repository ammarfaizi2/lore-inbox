Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264150AbUDBV3n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 16:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264179AbUDBV3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 16:29:43 -0500
Received: from aef.wh.uni-dortmund.de ([129.217.129.132]:35002 "EHLO
	stan.ping.de") by vger.kernel.org with ESMTP id S264150AbUDBV3l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 16:29:41 -0500
X-IMAP-Sender: rene
Date: Fri, 2 Apr 2004 22:25:07 +0200
X-OfflineIMAP-x676639941-52656d6f7465-494e424f582e4f7574626f78: 1080941365-0909439951674
From: Rene Engelhard <rene@rene-engelhard.de>
To: linux-kernel@vger.kernel.org
Subject: immediate hibernate after resume!?
Message-ID: <20040402202507.GA4609@rene-engelhard.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; x-action=pgp-signed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Operating-System: Debian GNU/Linux
X-PGP-Key: 248AEB73
X-PGP-Fingerprint: 41FA F208 28D4 7CA5 19BB  7AD9 F859 90B0 248A EB73
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

[ please Cc me as I am not on l-k ]

Hi,

I use swsusp as it is in 2.6.x.

If I do a echo 4 > /proc/acpi/sleep the laptop hibernates and resumes
ok.

If I do a echo 3 > /proc/acpi/sleep then the laptop does suspend-to-ram
right, but the resume is a problem: it resumes fine, but after the
resume it _immediately and automatically_ starts to go into hibernation
mode!? This is annying since there are situations where I want the
laptop just suspend-to-ram instead of hibernate..

WTF is going on here? Any ideas?

Grüße/Regards,

René
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAbcwj+FmQsCSK63MRAv5nAJ99y2xbGzm/glndBqZ33IMaGyLvwQCdEl84
nqfyvBEuoG6SdA9XOPA1754=
=98du
-----END PGP SIGNATURE-----
