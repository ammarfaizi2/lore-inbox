Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262627AbUKLVsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262627AbUKLVsr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 16:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262632AbUKLVrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 16:47:41 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7600 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262627AbUKLVpt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 16:45:49 -0500
Date: Fri, 12 Nov 2004 16:00:52 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.28-rc3
Message-ID: <20041112180052.GE23215@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here goes the third release candidate.

It contains a v2.6 backport of the binfmt_elf potential vulnerabilities 
disclosed this week, an enhanced smbfs client overflow fix, an ACPI update 
fixing a couple of nasty bugs, a NFS client bugfix and a network update
from Davem.



Summary of changes from v2.4.28-rc2 to v2.4.28-rc3
============================================

Aaron Grothe:
  o [CRYPTO]: Add Anubis support

Chris Wright:
  o binfmt_elf: handle partial reads gracefully

David S. Miller:
  o [TG3]: Use ioremap_nocache()
  o [TG3]: Bump driver version and reldate
  o Cset exclude: davem@nuts.davemloft.net|ChangeSet|20040831000448|00808
  o Cset exclude: pablo@eurodev.net|ChangeSet|20040831000223|00117
  o [ATM]: Put back mistakedly removed LEC procfs code

Herbert Xu:
  o [NET]: Fix tbl->entries race

Len Brown:
  o [ACPI] fix ASUS boot crash http://bugzilla.kernel.org/show_bug.cgi?id=2755
  o [ACPI] fix poweroff regression backport from 2.6 and ACPICA 20040427 http://bugzilla.kernel.org/show_bug.cgi?id=2109

Marcelo Tosatti:
  o Changed EXTRAVERSION to -rc3

Mike Miller:
  o cleans up warnings in 32/64-bit conversions

Mike Waychison:
  o [TG3]: Fix fiber hw autoneg bounces

Patrick McHardy:
  o [PKT_SCHED]: Don't try to destroy builtin qdiscs

Stefan Esser:
  o Improved smbfs client overflow fix

Thomas Graf:
  o [NET]: Fix neighbour/arp build
  o [PKT_SCHED]: break is not enough to stop walking

Trond Myklebust:
  o NFS: Always wake up tasks that are waiting on the sillyrenamed file to complete

Wensong Zhang:
  o [IPVS]: Update version to 1.2.1

