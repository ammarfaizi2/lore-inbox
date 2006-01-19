Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161235AbWASPeM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161235AbWASPeM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 10:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161242AbWASPeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 10:34:12 -0500
Received: from coriana6.CIS.McMaster.CA ([130.113.128.17]:55723 "EHLO
	coriana6.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S1161235AbWASPeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 10:34:10 -0500
Date: Thu, 19 Jan 2006 10:33:27 -0500 (EST)
From: Mark Hahn <hahn@physics.mcmaster.ca>
X-X-Sender: hahn@coffee.psychology.mcmaster.ca
To: Neil Brown <neilb@suse.de>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       "Lincoln Dale (ltd)" <ltd@cisco.com>, Michael Tokarev <mjt@tls.msk.ru>,
       <linux-raid@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: RE: [PATCH 000 of 5] md: Introduction
In-Reply-To: <17358.52476.290687.858954@cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.44.0601191031400.20928-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-PMX-Version-Mac: 4.7.1.128075, Antispam-Engine: 2.1.0.0, Antispam-Data: 2006.01.19.062605
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0'
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  Use either for raid0 (I don't think dm has particular advantages
>      for md or md over dm).

I measured this a few months ago, and was surprised to find that 
DM raid0 was very noticably slower than MD raid0.  same machine,
same disks/controller/kernel/settings/stripe-size.  I didn't try
to find out why, since I usually need redundancy...

regards, mark hahn.

