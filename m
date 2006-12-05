Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937424AbWLEOAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937424AbWLEOAG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 09:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937457AbWLEOAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 09:00:05 -0500
Received: from hera.kernel.org ([140.211.167.34]:43270 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937424AbWLEOAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 09:00:02 -0500
Date: Tue, 5 Dec 2006 14:00:00 +0000
From: Willy Tarreau <wtarreau@hera.kernel.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Linux 2.4.34-rc1
Message-ID: <20061205140000.GA350@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello !

Here comes kernel 2.4.34-rc1.
It contains a fix for CVE-2006-5871 (smbfs ignoring mount options).
Thanks to Dann Frazier for the backport of the fix. Other fixes are
mostly non-serious bugs, which constitute a good reason to produce
a release candidate.

Please test it and build it on several architectures if you can.
I'll only merge build fixes and critical fixes in forth-coming
-rc if any.

Regards,
Willy

Summary of changes from v2.4.34-pre6 to v2.4.34-rc1
============================================

dann frazier (1):
      smbfs : don't ignore uid/gid/mode mount opts w/ unix extensions

Jean Delvare (6):
      i2c cleanup : typos and whitespace
      i2c cleanup : dead code removal
      i2c cleanup : c99 struct init
      i2c cleanup : simplify code
      i2c cleanup : resync algo ids
      i2c cleanup : warning fix

Oliver Neukum (2):
      fix for transient error in usb printer driver
      task stte leak in pegasus usb driver

Ralf Baechle (1):
      Masking bug in 6pack driver

Shaohua Li (1):
      x86 microcode: dont check the size

Willy Tarreau (8):
      rio: typo in bitwise AND expression.
      flashpoint: use '!' instead of '~' with EE_SYNC_MASK
      jfs: incorrect use of "&&" instead of "&"
      arm: incorrect use of "&&" instead of "&"
      e100: incorrect use of "&&" instead of "&"
      ps2esdi: typo may cause premature timeout
      fbcon: incorrect use of "&&" instead of "&"
      Change VERSION to 2.4.34-rc1

