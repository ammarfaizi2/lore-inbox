Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261507AbULILIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbULILIq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 06:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbULILIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 06:08:46 -0500
Received: from mx3.informatik.uni-stuttgart.de ([129.69.211.42]:35044 "EHLO
	mx3.informatik.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id S261507AbULILIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 06:08:41 -0500
Date: Thu, 9 Dec 2004 12:08:40 +0100
From: lkml@Think-Future.de
To: Linux Kernel-Liste <linux-kernel@vger.kernel.org>
Subject: Re: ethX interface rx errors
Message-ID: <20041209120840.B16313@marvin.informatik.uni-stuttgart.de>
Reply-To: lkml@Think-Future.de
Mail-Followup-To: lkml@Think-Future.de,
	Linux Kernel-Liste <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Url: http://www.Think-Future.de
X-Editor: Vi it! http://www.vim.org
X-Bkp: p2mi
X-GnuPG-Key: gpg --keyserver search.keyserver.net --recv-keys 06232116
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


        Hi, 

 here is what iptraf gathers about iface stats:

 Packet Size (bytes)      Count     Packet Size (bytes)     Count x
 x     1 to   75:             877      751 to  825:               0 x
 x    76 to  150:             225      826 to  900:               0 x
 x   151 to  225:             661      901 to  975:               0 x
 x   226 to  300:               0      976 to 1050:               0 x
 x   301 to  375:               0     1051 to 1125:               0 x
 x   376 to  450:               0     1126 to 1200:               0 x
 x   451 to  525:               0     1201 to 1275:               0 x
 x   526 to  600:               0     1276 to 1350:               0 x
 x   601 to  675:               0     1351 to 1425:               0 x
 x   676 to  750:               1     1426 to 1500+:            430 x

This is the result of about 20 secs of gathering time.

The average throuput by scp is about 15kb/s. On a 100mbit switched net. 
BTW, the net itself is perfectly ok. ;-)

Thats alot, isn't it? (Horrible)


        Nils

PS: As soon as possible I will try to fix interrupts and iface-card
pci positions.
The thing about PCI edge is not a BIOS option.

