Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266221AbUHBCnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266221AbUHBCnh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 22:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266223AbUHBCne
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 22:43:34 -0400
Received: from ncc1701.cistron.net ([62.216.30.38]:60597 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP id S266220AbUHBCnG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 22:43:06 -0400
From: dth@ncc1701.cistron.net (Danny ter Haar)
Subject: upgrade from 2.6.8-rc2 -> rc2-bk11: orinoco not working
Date: Mon, 2 Aug 2004 02:43:05 +0000 (UTC)
Organization: Cistron
Message-ID: <cek9np$uch$1@news.cistron.nl>
X-Trace: ncc1701.cistron.net 1091414585 31121 62.216.30.38 (2 Aug 2004 02:43:05 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@ncc1701.cistron.net (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When i upgraded my laptop from 2.6.8-rc2 -> rc2-bk11 using
old .config and "make oldconfig" etc everything seemed fine.
After reboot i suddenly didn't have networking and my
orinoco_cs couldn't be found. It turned out that i had 
to enable hermes in PCI first to get an pcmcia modules.

That seems like a bug to me!

just thought i would mention it here

Danny
-- 
"If Microsoft had been the innovative company that it calls itself, it 
would have taken the opportunity to take a radical leap beyond the Mac, 
instead of producing a feeble, me-too implementation." - Douglas Adams -

