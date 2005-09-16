Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161070AbVIPHBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161070AbVIPHBL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 03:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161072AbVIPHBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 03:01:10 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:54244 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1161070AbVIPHBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 03:01:10 -0400
Message-Id: <20050916121646.387617000@localhost>
Date: Fri, 16 Sep 2005 08:16:46 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: ppc64-dev <linuxppc64-dev@ozlabs.org>
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       jordi_caubet@es.ibm.com, Hiroyuki Machida <machida@sm.sony.co.jp>,
       Geoff Levand <geoffrey.levand@am.sony.com>
Subject: [patch 00/11] spufs: latest spufs snapshot for 2.6.14-rc1
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an updated version of the SPU file system. Sorry for
the long delay in this, I wanted to get it out much earlier.
In this release, we have many new features, most of all a
scheduler for running an arbitrary number of SPU threads.

This release should still maintain backwards compatibility
with earlier releases, unless the last patch is applied,
which actually removes some of those interfaces.

The next version will no longer contain these interfaces at
all. Since the interfaces and the code are slowly stabilizing
now, I'd like to get this into -mm soon, probably the next
spufs release after this one.
The next release should also move to some location under
arch/powerpc rather than fs/spufs, as suggested by Pekka
Engberg.

	Arnd <><

