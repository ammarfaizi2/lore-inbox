Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266560AbUHBPad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266560AbUHBPad (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 11:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266561AbUHBPad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 11:30:33 -0400
Received: from scrye.com ([216.17.180.1]:59599 "EHLO mail.scrye.com")
	by vger.kernel.org with ESMTP id S266560AbUHBPa0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 11:30:26 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Mon, 2 Aug 2004 09:30:17 -0600
From: Kevin Fenzi <kevin-kernel@scrye.com>
To: linux-kernel@vger.kernel.org
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Subject: Re: -mm swsusp: do not default to platform/firmware
X-Draft-From: ("scrye.linux.kernel" 53687)
References: <20040728222445.GA18210@elf.ucw.cz>
	<Pine.LNX.4.50.0408012313350.4359-100000@monsoon.he.net>
Message-Id: <20040802153021.354C9AF200@voldemort.scrye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>>>>> "Patrick" == Patrick Mochel <mochel@digitalimplant.org> writes:

Patrick> On Thu, 29 Jul 2004, Pavel Machek wrote:

>> -mm swsusp now defaults to platform/firmware suspend... That's
>> certainly unexpected, changes behaviour from previous version, and
>> only works on one of three machines I have here. I'd like the
>> default to be changed back. Please apply,

Patrick> I'd rather leave it, and put pressure on the platform
Patrick> implementations to be made to work. If you want to shutdown,
Patrick> then specify it on the command line before you suspend (or
Patrick> add it to the suspend script).

Does _anyone_ have a machine where platform works?

I can't recally anyone posted on the acpi/swsusp2/kernel lists that
they had a platform implementation that worked. 

Perhaps they had no reason to post? Anyone out there with a laptop
with a suspend to disk in formware/platform using ACPI that works?
I'd love to be proven wrong... 

kevin
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQFBDl4M3imCezTjY0ERAtIWAJ4osBFokXGmgWc+gUhiCkJxS1yLLgCgiLaj
LhbFqFSpmWzjWKkblsFIpqU=
=3GnI
-----END PGP SIGNATURE-----
