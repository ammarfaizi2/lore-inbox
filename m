Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316175AbSE3CQu>; Wed, 29 May 2002 22:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316172AbSE3CQt>; Wed, 29 May 2002 22:16:49 -0400
Received: from [202.108.36.216] ([202.108.36.216]:24006 "HELO smtp.netease.com")
	by vger.kernel.org with SMTP id <S316156AbSE3CQs>;
	Wed, 29 May 2002 22:16:48 -0400
Date: Thu, 30 May 2002 10:22:50 +0800
From: coody <coody@netease.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Unresolved Symbols :Samp_ApicClearPerfLvtintMask / Samp_ApicSetPerfLvtintMask
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Message-Id: <20020530021647.21D2F1C4CABB3@smtp.netease.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

When I tried to run VTune, it said such error messages:

====================================================
[root@Linux system]# ./insmod-vtune.sh

Executing: insmod /opt/intel/vtune60/system/vtune_drv-2.4.4up.o
/opt/intel/vtune60/system/vtune_drv-2.4.4up.o: unresolved symbol Samp_ApicClearPerfLvtintMask
/opt/intel/vtune60/system/vtune_drv-2.4.4up.o: unresolved symbol Samp_ApicSetPerfLvtintMask
Error: sampling driver failed to load!

[root@Linux system]#
====================================================

It's strange that I found nothing when searching the kernel source tree of 2.4.4/2.4.16 with keyworks: ApicClear/ApicSet.

Does any one have any ideas ?

Best wishes,

Coody



