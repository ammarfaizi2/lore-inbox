Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267276AbSKTBe3>; Tue, 19 Nov 2002 20:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267288AbSKTBe3>; Tue, 19 Nov 2002 20:34:29 -0500
Received: from out001pub.verizon.net ([206.46.170.140]:6355 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP
	id <S267276AbSKTBe1>; Tue, 19 Nov 2002 20:34:27 -0500
Message-ID: <3DDAE846.6080503@lemur.sytes.net>
Date: Tue, 19 Nov 2002 20:41:26 -0500
From: Mathias Kretschmer <mathias@lemur.sytes.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en, zh-tw
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE:  PATCH: Recognize Tualatin cache size in 2.4.x
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at out001.verizon.net from [151.198.132.245] at Tue, 19 Nov 2002 19:41:27 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > > I tested it in a Compaq Proliant 330ML-G2 (P3 1.4) and a kernel
 > compilation is 100% faster if the patch is applied.

 > <raises eyebrows>. The SMP weighting used by various parts of the
 > kernel will be slightly off, but I'd be amazed if it made *that much*
 > difference.

I just patched my 2.4.20rc2 kernel. Now, it reports
512K cache for my 2 Tualatin 1.26 GHz CPUs.

'time make -j4 bzImage' went down from 3:30 to 3:04.
Not too bad.

Cheers,

Mathias

