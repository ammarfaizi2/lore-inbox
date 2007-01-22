Return-Path: <linux-kernel-owner+w=401wt.eu-S1751871AbXAVB4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751871AbXAVB4k (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 20:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751872AbXAVB4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 20:56:40 -0500
Received: from khc.piap.pl ([195.187.100.11]:51177 "EHLO khc.piap.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751871AbXAVB4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 20:56:40 -0500
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Heikki Orsila <shdl@zakalwe.fi>, Bodo Eggert <7eggert@gmx.de>,
       Tony Foiani <tkil@scrye.com>,
       Leon Woestenberg <leon.woestenberg@gmail.com>,
       linux-kernel@vger.kernel.org, David Schwartz <davids@webmaster.com>
Subject: Re: PROBLEM: KB->KiB, MB -> MiB, ... (IEC 60027-2)
References: <7FsPf-51s-9@gated-at.bofh.it> <7FxlV-3sb-1@gated-at.bofh.it>
	<7FyUF-5XD-21@gated-at.bofh.it> <E1H8a7s-0000at-Jx@be1.lrz>
	<20070121150618.GA11613@zakalwe.fi>
	<Pine.LNX.4.61.0701212223340.29213@yvahk01.tjqt.qr>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Mon, 22 Jan 2007 02:56:37 +0100
In-Reply-To: <Pine.LNX.4.61.0701212223340.29213@yvahk01.tjqt.qr> (Jan Engelhardt's message of "Sun, 21 Jan 2007 22:27:11 +0100 (MET)")
Message-ID: <m38xfvrfhm.fsf@maximus.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> writes:

> Bleh. Except for storage, base 1024 was used for almost everything
> I remember. 4 MB memory meant 4096 KB, and that's still the case today.
> Most likely the same for transfer rates.

Nope, transfer rates were initially 1000-based: 9.6 kbps = 9600 bps,
28.8 kbps = 28800 bps, 64 kbps = 64000 bps. Then it went 128, 256,
512 kbps = 512000 bps and 1 Mbps = 2 * 512 kbps = 1024000 bps.

But it's limited mostly to serial interfaces. Other networks use
10, 1000 etc. because they have nothing natural in (powers of) 2
so 1 Mbps may be 1000000 bps as well.

> It's just that storage vendors broke the computer rule and went with 1000.

1024 etc. is (should be) natural to disks because the sector size
is 512 B, 2048 B or something like that.
-- 
Krzysztof Halasa
