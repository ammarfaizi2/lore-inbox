Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265251AbUAYVpl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 16:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265252AbUAYVpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 16:45:41 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:16368 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265251AbUAYVpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 16:45:39 -0500
Date: Sun, 25 Jan 2004 22:45:31 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [0/3] fix brown paperbag bug in pentium-m-support.patch
Message-ID: <20040125214530.GN513@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

there's a brown paperbag bug in pentium-m-support.patch.

The first patch fixes this issue, thw other two patches are rediffs of 
amd-elan-is-a-different-subarch and better-i386-cpu-selection.

Please revert the patches in the following direction:

i386-default-to-n.patch
cpu-options-default-to-y.patch
better-i386-cpu-selection.patch
add-config-for-mregparm-3-ng-fixes.patch
add-config-for-mregparm-3-ng.patch
amd-elan-is-a-different-subarch.patch
pentium-m-support.patch


Then apply in the following direction:

[1/3] Pentium M: fix brown paperbag bug
[2/3] AMD Elan patch: rediffed
add-config-for-mregparm-3-ng.patch
add-config-for-mregparm-3-ng-fixes.patch
[3/3] CPU patch rediffed, includes the contents of:
      - better-i386-cpu-selection.patch
      - cpu-options-default-to-y.patch
      - i386-default-to-n.patch


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

