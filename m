Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265288AbUGCXqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265288AbUGCXqy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 19:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265289AbUGCXqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 19:46:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5538 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265288AbUGCXqw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 19:46:52 -0400
Date: Sat, 3 Jul 2004 20:21:05 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.27-rc3
Message-ID: <20040703232105.GA14159@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

Here goes -rc3, the number of changes this time is pretty small.

It includes network update from davem, PPC fcc enet driver
fix, and most importantly, the missing chown() security 
checks which allowed users to change the group affiliation of
arbitrary files on the system.

Detailed changelog for more details

Summary of changes from v2.4.27-rc2 to v2.4.27-rc3
============================================

Adrian Bunk:
  o add missing USB Gadget Configure.help entries

Christoph Hellwig:
  o [NETLINK]: Fix NLMSG_OK/RTA_OK length checking

David S. Miller:
  o [NET]: Fix SO_{RCV,SND}TIMEO getsockopt handling

Jan-Benedict Glaw:
  o [NETFILTER]: ip_fw_compat_masq.c needs net/ip.h

Marcelo Tosatti:
  o Thomas Biege: Fix missing DAC check on sys_chown
  o Changed EXTRAVERSION to -rc3
  o Add missing bracket to inode_change_ok() fix

Stephen Hemminger:
  o [BRIDGE]: Bridge STP message age

Tom Rini:
  o Li Yang: PQII FCC Ethernet driver: transmit buffer leak

