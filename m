Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262148AbUKQAuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262148AbUKQAuV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 19:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262147AbUKQAph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 19:45:37 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14979 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262093AbUKQApE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 19:45:04 -0500
Date: Tue, 16 Nov 2004 18:41:07 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.28-rc4
Message-ID: <20041116204107.GB16311@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

Here goes the fourth release candidate of 2.4.28.

A few small problems showed up in time for another -rc.

Missing exported symbols in the networking area, an ACPI poweroff bugfix, 
aic7xxx compile fix with -Werror, a binfmt_elf underflow enhancement, 
an SCTP fix, and a couple TG3 fixes.

This will become v2.4.28 final if nothing _really_ bad shows up.


Thanks to everybody who has been contributing to make this happen.


Summary of changes from v2.4.28-rc3 to v2.4.28-rc4
============================================

Adrian Bunk:
  o [NET]: neigh_for_each must be EXPORT_SYMBOL'ed

David S. Miller:
  o [AF_UNIX]: Serialize dgram read using semaphore just like stream
  o [NET]: Export __neigh_for_each_release to modules
  o [TG3]: Update driver version and reldate

Jakub Jelínek:
  o binfmt_elf: handle p_filesz == 0 on PT_INTERP section

Len Brown:
  o [ACPI] fix NMI during poweroff http://bugzilla.kernel.org/show_bug.cgi?id=1206

Marcelo Tosatti:
  o Changed EXTRAVERSION to -rc4

Michael Chan:
  o [TG3]: 5753 support and a bug fix

Patrick McHardy:
  o [SCTP]: Fix inetaddr notifier chain corruption

Willy Tarreau:
  o aic7xxx aic79xx_osm_pci.c compile fix with -Werror

