Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261760AbVAYAkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbVAYAkO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 19:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbVAYAcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 19:32:50 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:46571 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S261729AbVAYAaP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 19:30:15 -0500
Cc: linux-kernel@vger.kernel.org, js@linuxtv.org
In-Reply-To: 
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Tue, 25 Jan 2005 01:31:38 +0100
Message-Id: <11066130981300@linuxtv.org>
Mime-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
From: Johannes Stezenbach <js@linuxtv.org>
X-SA-Exim-Connect-IP: 217.86.181.249
Subject: [PATCH 0/4] 2.6.11-rc2-bk2 DVB fixes
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

the following patches correct a few bugs which were found
shortly after submission of the previous patchset :-(
(except 03-core-more-cards which I just submit while I'm at it)

01-dibusb-le16		follow USB __le16 changes
02-core-fe-release	fix access to freed memory on module unload
03-core-more-cards	support up to six DVB cards (instead of just four)
04-frontends		cleanup some confusing firmware loading printks

I also saw that there is a large amount of whitespace/indentation
corruption throughout the DVB subsystem (some of it shows through
in the 04-frontends patch), which was not introduced
by the latest patchset but already exists in linux-2.6.10-rc2 at least.
I will try to sort this out over the next few days.

Johannes

