Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261499AbVBAAxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261499AbVBAAxS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 19:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbVBAAvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 19:51:43 -0500
Received: from topsns.toshiba-tops.co.jp ([202.230.225.5]:60957 "HELO
	topsns.toshiba-tops.co.jp") by vger.kernel.org with SMTP
	id S261485AbVBAAuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 19:50:18 -0500
Date: Tue, 01 Feb 2005 09:50:08 +0900 (JST)
Message-Id: <20050201.095008.74752930.nemoto@toshiba-tops.co.jp>
To: arnd@arndb.de
Cc: ralf@linux-mips.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       bunk@stusta.de
Subject: Re: [PATCH] Fix SERIAL_TXX9 dependencies
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <200501312123.11451.arnd@arndb.de>
References: <200501301645.14069.arnd@arndb.de>
	<20050130165839.GB27703@linux-mips.org>
	<200501312123.11451.arnd@arndb.de>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 31 Jan 2005 21:23:10 +0100, Arnd Bergmann <arnd@arndb.de> said:
arnd> I just found that the version in -mm2 does not add the Makefile
arnd> change, so you need this patchlet on top. If you haven't redone
arnd> the patch yet, it might be better still to rename the file to
arnd> txx9.o, as serial/serial_* is a bit redundant.

Thank you for Makefile fix.

As for renaming, I think serial/serial_* is not so bad.  If you rename
it and compile as a module, then the module will be called "txx9.ko"
which seems too ambiguous.

---
Atsushi Nemoto
