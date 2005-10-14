Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbVJNGiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbVJNGiG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 02:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbVJNGiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 02:38:05 -0400
Received: from www.tuxrocks.com ([64.62.190.123]:25361 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S1750757AbVJNGiE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 02:38:04 -0400
Message-ID: <434F5247.2040007@tuxrocks.com>
Date: Fri, 14 Oct 2005 00:37:59 -0600
From: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
Subject: Kconfig Dependencies for CONFIG_NET_CLS_RSVP6
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I noticed that I can still select "Special RSVP classifier for IPv6"
even if "The IPv6 protocol" isn't selected.  Should CONFIG_NET_CLS_RSVP6
depend on or select IPV6?

Currently:
Depends on: NET && NET_CLS && NET_QOS


Thanks,
Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDT1JHaI0dwg4A47wRAhgRAJ0WKH6/S1DjKKRZDSwiLOpIMYJ8cgCgyIld
xXUJRsvCO1TJsCfpSCMj7/A=
=gqzH
-----END PGP SIGNATURE-----
