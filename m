Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265526AbUBPNbI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 08:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265532AbUBPNbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 08:31:07 -0500
Received: from intra.cyclades.com ([64.186.161.6]:27115 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S265526AbUBPNbD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 08:31:03 -0500
Date: Mon, 16 Feb 2004 10:18:23 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.25-rc3
Message-ID: <Pine.LNX.4.58L.0402161014180.4334@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Here goes the third 2.4.25 release candidate.

This release includes a few important net fixes, amongst others.

Detailed changelog below

Summary of changes from v2.4.25-rc2 to v2.4.25-rc3
============================================

<brazilnut:us.ibm.com>:
  o [NET]: Fix ethtool oops if device support get but not set ringparam

<emoore:lsil.com>:
  o MPT Fusion: fix IOCTL interface on ia64/x86-64

<kas:informatics.muni.cz>:
  o [NET]: Do not send negative 2nd arg to skb_put()

<marcelo:logos.cnet>:
  o Changed EXTRAVERSION to -rc3
  o Cset exclude: sri@us.ibm.com|ChangeSet|20040213195328|09088
  o Cset exclude: sri@us.ibm.com|ChangeSet|20040213011231|09074
  o Cset exclude: sri@us.ibm.com|ChangeSet|20040213005510|09081
  o Cset exclude: sri@us.ibm.com|ChangeSet|20040213003759|09793
  o revert 2.6 sctp sync, readd sla1.h, sla1.c, hashdriver.c, adler32.c

<miguel:cetuc.puc-rio.br>:
  o [NET_SCHED]: Fix slot leakage in SFQ scheduler

<quade:hsnr.de>:
  o Warn if negative size is passed to [v]snprintf

Chas Williams:
  o [ATM]: prevent userspace compilation errors with glibc-kernheaders
  o [ATM]: [he] unconditionalize extra pci reads to flush posted writes

Herbert Xu:
  o off-by-one kmalloc in ntfs

