Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751278AbVI2AvD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbVI2AvD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 20:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbVI2AvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 20:51:03 -0400
Received: from www.tuxrocks.com ([64.62.190.123]:272 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S1751278AbVI2AvB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 20:51:01 -0400
Message-ID: <433B3A52.30803@tuxrocks.com>
Date: Wed, 28 Sep 2005 18:50:26 -0600
From: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Frank Sorenson <frank@tuxrocks.com>
CC: tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@elte.hu,
       akpm@osdl.org, george@mvista.com, johnstul@us.ibm.com,
       paulmck@us.ibm.com, hch@infradead.org, oleg@tv-sign.ru,
       zippel@linux-m68k.org, tim.bird@am.sony.com
Subject: Re: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
References: <20050928224419.1.patchmail@tglx.tec.linutronix.de> <433B2E62.5050201@tuxrocks.com>
In-Reply-To: <433B2E62.5050201@tuxrocks.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Frank Sorenson wrote:
> I get this kernel panic on boot (serial capture) with the latest
> git tree (2.6.14-rc2++) plus this version of ktimers:

Here's a little more information.  I've narrowed the panic down to ntpd
startup.  Without ntpd, the system seems to run okay, but panics the
moment I startup ntpd.

Hope this helps,

Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDOzpSaI0dwg4A47wRAipFAJ0c6/2tif49xVEhDZCH2drgpJXQmACgoY+G
tT9LkOWmS67SyX5Vekrl024=
=f/qY
-----END PGP SIGNATURE-----
