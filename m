Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262101AbVAVRc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbVAVRc5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 12:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262402AbVAVRc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 12:32:57 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:978 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262101AbVAVRcy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 12:32:54 -0500
Cc: linux-kernel@vger.kernel.org, js@linuxtv.org
In-Reply-To: 
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Sat, 22 Jan 2005 18:34:26 +0100
Message-Id: <1106415266247@linuxtv.org>
Mime-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
From: Johannes Stezenbach <js@linuxtv.org>
X-SA-Exim-Connect-IP: 217.231.47.99
Subject: [PATCH 0/9] 2.6.11-rc2 DVB update
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

this is the usual batch of DVB updates from linuxtv.org CVS.
The patches were prepared by Michael Hunold, I just rediffed
them to apply cleanly against 2.6.11-rc2, and submit
them on his behalf this time.

I realize it is actually a bit late in the 2.6.11 release
cycle but I hope they can be included in 2.6.11 anyway, as
they don't touch anything outside the DVB subsystem.
If not I will factor out the important bug fixes and
resubmit them.

1 saa7146	fix possible RPS init race
2 bt8xx		support pinnacle pctv-sat, clean-ups
3 dibusb	refactoring, support Yakumo/HAMA/Typhoon/HanfTek clones
4 misc		support nxt2002 frontend, misc skystar2 fixes
5 dvb-core	add ATSC support, misc fixes
6 dib3000	refactoring
7 frontends	nxt2002: add ATSC support, misc fixes
8 ttpci		dvb-ttpci: fix SMP race, budget: fix init race, misc fixes

Johannes

