Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964974AbVJEVG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964974AbVJEVG4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 17:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965010AbVJEVG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 17:06:56 -0400
Received: from mailhub.lss.emc.com ([168.159.2.31]:53312 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP id S965009AbVJEVGz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 17:06:55 -0400
From: Brett Russ <russb@emc.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Pasi Pirhonen <upi@papat.org>,
       Michael Madore <Michael.Madore@aslab.com>,
       Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>,
       "Mr. Berkley Shands" <bshands@exegy.com>,
       Jim Edwards <jim@networkdesigning.com>,
       scott olson <scotto701@yahoo.com>,
       Lars Magne Ingebrigtsen <larsi@gnus.org>,
       Evgeny Rodichev <er@sai.msu.su>
Subject: [PATCH 2.6.14-rc2 0/2] libata: Marvell SATA support (v0.23-0.24)
Message-Id: <20051005210610.EC31826369@lns1058.lss.emc.com>
Date: Wed,  5 Oct 2005 17:06:10 -0400 (EDT)
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.1.0.0, Antispam-Data: 2005.10.5.26
X-PerlMx-Spam: Gauge=, SPAM=7%, Reasons='__HAS_MSGID 0, __MIME_TEXT_ONLY 0, __SANE_MSGID 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series should fix up lockups that people were seeing due to
improper spinlock placement (nested==bad).  Additionally, there are
other changes to simplify things (complex=bad).  The second patch adds
comment headers to functions that need it.

Thanks,
BR
