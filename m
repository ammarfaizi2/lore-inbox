Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261727AbVCSDO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbVCSDO4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 22:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261781AbVCSDO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 22:14:56 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8583 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261727AbVCSDOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 22:14:53 -0500
Date: Fri, 18 Mar 2005 18:55:13 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.30-rc1
Message-ID: <20050318215513.GA25936@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Here goes the first release candidate for v2.4.30. 

It contains a small number of fixes, including a fix for 
recently discovered ppp DoS (CAN-2005-0384).


Summary of changes from v2.4.30-pre3 to v2.4.30-rc1
============================================

<crn:netunix.com>:
  o [SPARC32]: Fix build dependencies for vmlinux.o
  o [SPARC32]: Fix sun4d sbus and current handling
  o [SPARC32]: sun4d needs ZS_WSYNC() zilog reg flushing too

<davem:northbeach.davemloft.net.davemloft.net>:
  o [SPARC64]: Fix semtimedop compat ipc code

<jacques_basson:myrealbox.com>:
  o Fix softdog no reboot on unexpected close

Alan Hourihane:
  o agpgart Intel i915GM ID's and tweaks

Andrea Arcangeli:
  o Write throttling should not take free highmem into account

Chris Wedgwood:
  o early boot code references check_acpi_pci()

Linus Torvalds:
  o Workaround possible pty line discipline race

Marcelo Tosatti:
  o Andrea Arcangeli: get_user_pages() shall not grab PG_reserved pages
  o Paul Mackerras: Remote Linux DoS on ppp servers (CAN-2005-0384)
  o Change VERSION to 2.4.30-rc1

Roland McGrath:
  o i386/x86_64 fpu: fix x87 tag word simulation using fxsave

Solar Designer:
  o Enable gcc warnings for vsprintf/vsnprintf with "format" attribute

Stephen Hemminger:
  o TCP BIC not binary searching correctly

Willy Tarreau:
  o acpi.h needs <linux/init.h>

