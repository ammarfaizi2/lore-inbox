Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262455AbUKBOOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262455AbUKBOOL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 09:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262448AbUKBOOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 09:14:08 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:13525 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S262577AbUKBOHK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 09:07:10 -0500
Message-ID: <41879488.10601@g-house.de>
Date: Tue, 02 Nov 2004 15:07:04 +0100
From: Christian <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.6+ (Windows/20041008)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: 5 compile errors for 2.4-BK
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

every day my scripts compile several kernel from the latest -BK tree,
since oct, 30. there are 5 compile errors shown in:

make[3]: [neighbour.o] Error 1 (ignored)
make[3]: [core.o] Error 1 (ignored)
make[3]: [arp.o] Error 1 (ignored)
make[3]: [ipv4.o] Error 1 (ignored)
make[1]: [first_rule] Error 2 (ignored)

[and that's why these 2 occur too:]

make: [vmlinux] Error 1 (ignored)
make: [zImage] Error 2 (ignored)

full make logs, configs here:
http://www.nerdbynature.de/bits/sheep/latest-kernel/
  - make-2.4-i386-BK.log
  - make-2.4-ppc-BK.log
  - errors-2.4-i386-BK.log
  - errors-2.4-ppc-BK.log
  - config-i386-2.4.28-rc1
  - config-ppc-2.4.28-rc1

this is all with debian/unstable, using gcc-3.4.2, binutils-2.15 (both 
for native i386-compiler and cross-compiler)

maybe someone may find this useful...

thanks,
Christian.
-- 
BOFH excuse #303:

fractal radiation jamming the backbone
