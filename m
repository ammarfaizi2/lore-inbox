Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750869AbWD2BVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbWD2BVy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 21:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbWD2BVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 21:21:53 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:62922 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750869AbWD2BVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 21:21:32 -0400
Message-Id: <20060429011827.502138000@localhost.localdomain>
Date: Sat, 29 Apr 2006 03:18:27 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org,
       cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] NUMA support for spufs
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current version of spufs breaks upon boot when NUMA support is enabled.
I'd like to fix that before 2.6.17 so we can use the same kernel image
on Cell that we use on other powerpc systems using NUMA.

This series has four patches, the first two are required to make it work
at all, the other two are there for a somewhat cleaner solution.

The second patch (sparsemem-interaction-with-memory-add-bug-fixes.patch)
actually comes from 2.6.17-rc2-mm1, but in order to make this work,
we need it included in mainline along with the others.

	Arnd <><
--

