Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265510AbUAPOWV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 09:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265513AbUAPOWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 09:22:21 -0500
Received: from intra.cyclades.com ([64.186.161.6]:38289 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S265510AbUAPOWN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 09:22:13 -0500
Date: Fri, 16 Jan 2004 12:11:58 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.25-pre6
Message-ID: <Pine.LNX.4.58L.0401161207000.28357@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Here goes -pre6.

This release came out so quickly because -pre5 contains a deadly mistake
in one of the fs patches.

It contains SPARC/x86-64 updates, networking and crypto updates, amongst
others.

Summary of changes from v2.4.25-pre5 to v2.4.25-pre6
============================================

<jmorris:redhat.com>:
  o [CRYPTO]: Clean up tcrypt module and allow it to be unloaded

<kartik_me:hotmail.com>:
  o [CRYPTO]: Add CAST6 (CAST-256) algorithm

<marcelo:logos.cnet>:
  o Changed EXTRAVERSION to -pre6

<my:utfors.se>:
  o [CRYPTO]: Move ivsize from algorithm to tfm

Andi Kleen:
  o x86-64 update

Chas Williams:
  o [ATM]: br2684 incorrectly handles frames recvd with FCS (by Alex Zeffertt <ajz@cambridgebroadband.com>)
  o [ATM]: [nicstar] convert to new style pci module (by "Jorge Boncompte [DTI2]" <jorge@dti2.net>)
  o [ATM]: better behavior for sendmsg/recvmsg during async closes
  o [ATM]: refcount atm sockets

David S. Miller:
  o [SPARC64]: In early bootup, BUG() if cannot find TLB entry for remapping
  o [SPARC64]: Disable PCI ROM address OBP sanity check for now
  o [IPV4]: Print correct source addr in invalid ICMP msgs, from Dennis Jorgensen

David Stevens:
  o [IPV4/IPV6]: In MLD, add new filter first, then delete old one

David Woodhouse:
  o Do not leave inodes with stale waitqueue on slab cache

Harald Welte:
  o [NETFILTER]: Add config help texts for IP_NF_ARP{TABLES,FILTER}

Jean Tourrilhes:
  o NSC '39x support
  o VIA IrDA driver

Kurt Garloff:
  o [NETFILTER]: Align nulldevname properly in ip_tables

Marcel Holtmann:
  o [Bluetooth] Use R2 for default value of pscan_rep_mode
  o [Bluetooth] Set disconnect timer for incoming ACL links
  o [Bluetooth] Start inquiry if cache is empty
  o [Bluetooth] Change maintainer role of the Bluetooth subsystem

