Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932230AbVHXVIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbVHXVIt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 17:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbVHXVIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 17:08:49 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:58509 "EHLO
	ogre.sisk.pl") by vger.kernel.org with ESMTP id S932230AbVHXVIr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 17:08:47 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Memory problem w/ recent kernels on 2x Opteron with 12 GB RAM
Date: Wed, 24 Aug 2005 23:08:54 +0200
User-Agent: KMail/1.8.2
Cc: discuss@x86-64.org, Andi Kleen <ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508242308.55433.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm currently seeing a memory problem on a NUMA-enabled dual-Opteron 250 box
with the 2.6.12.5 and 2.6.13-rc* (up to 7) kernels.  Namely, the box has 12 GB of
RAM, 8 GB of which is installed on the first node.  The whole memory is detected
but then only the first 8 GB of it is made available (minus some hardware-related
holes), as though the memory on the second node were discarded for some
reason.

I have observed that the latest Fedora Core 3 kernel (based on 2.6.12) is also
affected by this issue, but the "out-of-the-box" FC3 kernel, based on 2.6.9, is not.

The motherboard is a Tyan S2882-D with the out-of-the-box BIOS, which is not
the latest one.  Should I upgrade it?

Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
