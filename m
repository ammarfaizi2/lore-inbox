Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751354AbWGLQxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbWGLQxW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 12:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbWGLQxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 12:53:22 -0400
Received: from smtp-out.google.com ([216.239.33.17]:27815 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751354AbWGLQxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 12:53:22 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
	b=sZC0WTGvTHO927UxoENeRujc2K7tcnj4ggdwbGCxrMzeqmQN2mnO2chrKyDuqAtjy
	BQqt8fIX5IF9RMek4qqsw==
Message-ID: <44B528F4.6080409@google.com>
Date: Wed, 12 Jul 2006 09:53:08 -0700
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>
Subject: 2.6.18-rc1-git4 and 2.6.18-rc1-mm1 OOM's on boot
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-git3 was fine
(bootlog for git3: http://test.kernel.org/abat/40748/debug/console.log)

-mm1 has the same issue

Slightly different manifestations across 2 boots

http://test.kernel.org/abat/40760/debug/console.log
http://test.kernel.org/abat/40837/debug/console.log

32GB NUMA-Q system w/16 processors.


Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 0kB
Total swap = 0kB
Free swap:            0kB
8321024 pages of RAM
8159232 pages of HIGHMEM
133127 reserved pages
3739 pages shared
0 pages swap cached
208 pages dirty
0 pages writeback
1135 pages mapped
24266 pages slab
76 pages pagetables
Out of Memory: Kill process 1 (init) score 0 and children.
No available memory (MPOL_BIND): Killed process 1267 (rc).
-- 0:conmux-control -- time-stamp -- Jul/12/06  2:00:36 --
-- 0:conmux-control -- time-stamp -- Jul/12/06  2:09:55 --
(bot:conmon-payload) disconnected
