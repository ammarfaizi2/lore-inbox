Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261737AbVA3RHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261737AbVA3RHn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 12:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbVA3RFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 12:05:34 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:15879 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S261734AbVA3RE7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 12:04:59 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.6.10: SPARC64 mapped figure goes unsignedly negative...
From: Nix <nix@esperi.org.uk>
X-Emacs: because you deserve a brk today.
Date: Sun, 30 Jan 2005 17:04:53 +0000
Message-ID: <87sm4izw3u.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

/proc/meminfo on my UltraSPARC IIi:

MemTotal:       512816 kB
MemFree:         14208 kB
Buffers:         51328 kB
Cached:         163056 kB
SwapCached:          0 kB
Active:         142160 kB
Inactive:       304712 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       512816 kB
LowFree:         14208 kB
SwapTotal:     1557264 kB
SwapFree:      1557176 kB
Dirty:            5256 kB
Writeback:           0 kB
Mapped:       18446744073687883208 kB
Slab:            43928 kB
CommitLimit:   1813672 kB
Committed_AS:   342712 kB
PageTables:       1728 kB
VmallocTotal:  3145728 kB
VmallocUsed:       456 kB
VmallocChunk:  3145272 kB

That Mapped figure looks somewhat inaccurate, being about negative
19Gb. The other figures are pretty much right, as far as I can tell.


(This kernel is compiled with GCC-3.4.3, which might be relevant.)

-- 
`Blish is clearly in love with language. Unfortunately,
 language dislikes him intensely.' --- Russ Allbery
