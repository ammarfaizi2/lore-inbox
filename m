Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267388AbTAOV4v>; Wed, 15 Jan 2003 16:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267389AbTAOV4u>; Wed, 15 Jan 2003 16:56:50 -0500
Received: from adsl-67-114-19-186.dsl.pltn13.pacbell.net ([67.114.19.186]:61368
	"HELO adsl-63-202-77-221.dsl.snfc21.pacbell.net") by vger.kernel.org
	with SMTP id <S267387AbTAOV4t>; Wed, 15 Jan 2003 16:56:49 -0500
Message-ID: <3E25DB37.2040806@tupshin.com>
Date: Wed, 15 Jan 2003 14:05:43 -0800
From: Tupshin Harper <tupshin@tupshin.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Unable to handle kernel NULL pointer kernel 2.4.21-pre3-ac4
References: <3E24DBAA.4060701@tupshin.com> <3E2508EB.70600@tupshin.com>
In-Reply-To: <3E2508EB.70600@tupshin.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK....this definitely(well 99.5% chance) seems to be a problem that is 
in 2.4.21-pre3-ac4, but is not in 2.4.21-pre3, or in linus' bk tree. 
Also, this problem is not caused by the device-mapper patch which is the 
only reason I was trying the ac tree in the first place.

So, it's an ac specific problem separate from the device-mapper code:

Another (possibly related) hint is that at bootup, I get many(measured 
in the hundreds) reports of "ide: no cache flush required" which is in 
ide_cacheflush_p in drivers/ide/ide-disk.c, and is only present in the 
ac tree.

Does this seem like a likely culprit?

Hello...is this thing on...can anyone hear me? ;-)

-Tupshin

