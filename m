Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932251AbVK1W0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbVK1W0P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 17:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbVK1W0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 17:26:15 -0500
Received: from hell.sks3.muni.cz ([147.251.210.189]:56241 "EHLO
	anubis.fi.muni.cz") by vger.kernel.org with ESMTP id S932243AbVK1W0O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 17:26:14 -0500
Date: Mon, 28 Nov 2005 23:25:58 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: Too many disks in system? (RAID5)
Message-ID: <20051128222558.GN2529@mail.muni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have system with attached SATA array which contains 24 disks. I wanted to run
software RAID 5, but 24 disks means, that I would need /dev/sda to /dev/sdx
devices with major 8 and last minor 384. Minor seems to be limited to 8 bits.
Is there any chance to run software array using all 24 disks?

My test was with mknod v. 5.2.1 and kernel 2.6.14.3

-- 
Luká¹ Hejtmánek
