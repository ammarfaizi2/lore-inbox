Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966580AbWKOEYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966580AbWKOEYt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 23:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966583AbWKOEYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 23:24:48 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:60006 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S966582AbWKOEYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 23:24:47 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
X-Message-Flag: Warning: May contain useful information
References: <200611150059.kAF0xBTl009796@hera.kernel.org>
	<455A6EBF.7060200@garzik.org>
	<Pine.LNX.4.64.0611141747490.3349@woody.osdl.org>
	<455A7E21.7020701@garzik.org>
	<Pine.LNX.4.64.0611141846190.3349@woody.osdl.org>
	<1163563491.5940.209.camel@localhost.localdomain>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 14 Nov 2006 20:24:46 -0800
In-Reply-To: <1163563491.5940.209.camel@localhost.localdomain> (Benjamin Herrenschmidt's message of "Wed, 15 Nov 2006 15:04:51 +1100")
Message-ID: <adad57pz69d.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 15 Nov 2006 04:24:46.0670 (UTC) FILETIME=[FB7736E0:01C7086D]
Authentication-Results: sj-dkim-5; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim5002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > and I've heard of devices doing that too (yeah, that's weird, they
 > wouldn't work in windows I suppose).

for example the QLogic PCIe InfiniBand adapter (drivers/infiniband/hw/ipath)
can't generate legacy INTx interrupts...
