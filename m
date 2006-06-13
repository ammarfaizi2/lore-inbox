Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751210AbWFMWvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbWFMWvY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 18:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWFMWvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 18:51:24 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:59039 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751210AbWFMWvX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 18:51:23 -0400
Date: Wed, 14 Jun 2006 00:51:17 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Markus Biermaier <mbier@office-m.at>
cc: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
Subject: Re: Can't Mount CF-Card on boot of 2.6.15 Kernel on EPIA - VFS:
 Cannot open root device
In-Reply-To: <1A2AB079-32AC-40F2-AFB4-422A9FF2E86B@office-m.at>
Message-ID: <Pine.LNX.4.61.0606140050240.30304@yvahk01.tjqt.qr>
References: <6137A58D-963C-4379-A836-DCD28C3E88EE@office-m.at>
 <20060613142229.5072b657.rdunlap@xenotime.net> <1A2AB079-32AC-40F2-AFB4-422A9FF2E86B@office-m.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> echo 0x3301 > /proc/sys/kernel/real-root-dev

What a hack. initramfsses of current distros seem to do it a better way 
using run-init (pivot_root?).


Jan Engelhardt
-- 
