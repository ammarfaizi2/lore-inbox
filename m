Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263221AbTLMDXh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 22:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263258AbTLMDXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 22:23:36 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:56457 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S263221AbTLMDXf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 22:23:35 -0500
Date: Fri, 12 Dec 2003 19:23:30 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Rik van Riel <riel@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: More questions about 2.6 /proc/meminfo was: (Mem: and Swap: lines in /proc/meminfo)
Message-ID: <20031213032330.GA1769@matchmail.com>
Mail-Followup-To: Rik van Riel <riel@redhat.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0312120658001.17287-100000@chimarrao.boston.redhat.com> <20031212181206.GL15401@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031212181206.GL15401@matchmail.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

VmallocUsed is being reported in /proc/meminfo in 2.6 now.

Is VmallocUsed contained within any of the other memory reported below?

How can I get VmallocUsed from userspace in earlier kernels (2.[024])?

And the same questions with PageTables too. :)

Are Dirty: and Writeback: counted in Inactive: or are they seperate?

Does Mapped: include all files mmap()ed, or only the executable ones?

MemTotal:       514880 kB
MemFree:        268440 kB
Buffers:         10736 kB
Cached:          98064 kB
SwapCached:          0 kB
Active:         161732 kB
Inactive:        54756 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       514880 kB
LowFree:        268440 kB
SwapTotal:      627024 kB
SwapFree:       627024 kB
Dirty:              48 kB
Writeback:           0 kB
Mapped:         155292 kB
Slab:            16712 kB
Committed_AS:   288808 kB
PageTables:       1816 kB
VmallocTotal:   507896 kB
VmallocUsed:     26472 kB
VmallocChunk:   481176 kB

