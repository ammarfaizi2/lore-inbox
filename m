Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272397AbTHIPGe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 11:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272401AbTHIPGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 11:06:34 -0400
Received: from fep02-mail.bloor.is.net.cable.rogers.com ([66.185.86.72]:34653
	"EHLO fep02-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S272397AbTHIPGc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 11:06:32 -0400
Message-ID: <3F351104.4070302@rogers.com>
Date: Sat, 09 Aug 2003 11:19:32 -0400
From: gaxt <gaxt@rogers.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030727 Thunderbird/0.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: DVD Problems 2.6.0-test3 & 2.6.0-test2-mm5
References: <3F34D0EA.8040006@rogers.com> <Pine.LNX.4.56.0308091030590.16795@filesrv1.baby-dragons.com> <3F3509C0.9050403@rogers.com> <Pine.LNX.4.56.0308091036190.16795@filesrv1.baby-dragons.com>
In-Reply-To: <Pine.LNX.4.56.0308091036190.16795@filesrv1.baby-dragons.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at fep02-mail.bloor.is.net.cable.rogers.com from [24.102.238.105] using ID <dw2price@rogers.com> at Sat, 9 Aug 2003 11:05:38 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DVDs play fine in 2.4.21 but will not play in 2.6.0-test2-mm5 or 
2.6.0-test3. With ogle, this is what spits out:

dave@localhost dave $ ogle
libdvdread: Using libdvdcss version 1.2.6 for DVD access
libdvdread: Using libdvdcss version 1.2.6 for DVD access

libdvdread: Attempting to retrieve all CSS keys
libdvdread: This can take a _long_ time, please be patient

libdvdread: Get key for /VIDEO_TS/VTS_01_0.VOB at 0x00000182
libdvdread: Error cracking CSS key for /VIDEO_TS/VTS_01_0.VOB (0x00000182)
libdvdread: Elapsed time 0
libdvdread: Get key for /VIDEO_TS/VTS_01_1.VOB at 0x00020316
libdvdread: Error cracking CSS key for /VIDEO_TS/VTS_01_1.VOB (0x00020316)!!
libdvdread: Elapsed time 0
libdvdread: Found 1 VTS's
libdvdread: Elapsed time 0
FATAL[ogle_mpeg_ps]: dvdreadblocks failed
dave@localhost dave $

I tried several DVDs and three gave the above error and one worked but I 
suspect the working one had no copy-protection encoding (low budget 
release unlike the two others: Jeeves & Wooster and Blackadder and Dirty 
Harry).

Unfortunately, I never tested DVD with the other 2.6.0 kernel releases.

