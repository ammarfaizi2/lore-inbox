Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266236AbUJAT7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266236AbUJAT7m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 15:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266245AbUJAT7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 15:59:42 -0400
Received: from scrye.com ([216.17.180.1]:51671 "EHLO mail.scrye.com")
	by vger.kernel.org with ESMTP id S266236AbUJAT6D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 15:58:03 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Fri, 1 Oct 2004 13:57:54 -0600
From: Kevin Fenzi <kevin-linux-kernel@scrye.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3 software suspend (pmdisk) stopped working
In-Reply-To: <200410012153.31376.rjw@sisk.pl>
References: <415C2633.3050802@0Bits.COM>
	<200410012055.29406.rjw@sisk.pl>
	<20041001192532.A0714A6017@voldemort.scrye.com>
	<200410012153.31376.rjw@sisk.pl>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Message-Id: <20041001195800.066582B131@voldemort.scrye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>>>>> "Rafael" == Rafael J Wysocki <rjw@sisk.pl> writes:

>> Do you have HIMEM enabled?

Rafael> I'm not sure what you mean.  It's an x86-64 system with 512 MB
Rafael> of RAM.

HIMEM is needed for various configs when you have 1GB of memory or
more. 

So, it shouldn't be set in your case it sounds like... 
You should have "NOHIGHMEM" set in your .config... 

>> Does the patch below make it more stable for you?

Rafael> I have this patch applied, but I get double faults sometimes
Rafael> anyway.

Can you post the exact messages? This seems diffrent than the reboot
issue I was seeing. 

Rafael> Greets, RJW

kevin

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQFBXbbH3imCezTjY0ERAjWNAJ9Hl5UTfelrR+7OAGgyYLFLd+xyEQCfRv0P
MmcUi6pOW28XLO1Mh6dLlmY=
=20rC
-----END PGP SIGNATURE-----
