Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268369AbUHKXcq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268369AbUHKXcq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 19:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268345AbUHKXZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 19:25:29 -0400
Received: from fw.osdl.org ([65.172.181.6]:7596 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268308AbUHKXX3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 19:23:29 -0400
Date: Wed, 11 Aug 2004 16:23:28 -0700 (PDT)
From: Bryce Harrington <bryce@osdl.org>
To: <linux-kernel@vger.kernel.org>
cc: <ltp-list@lists.sourceforge.net>
Subject: LTP Results 2004-08-11
In-Reply-To: <Pine.LNX.4.33.0407152011220.10145-100000@osdlab.pdx.osdl.net>
Message-ID: <Pine.LNX.4.33.0408111621540.17292-100000@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's an update on the LTP test runs for the kernel.  Everything has
been looking pretty calm again since Daniel McNeil's fix to the mmap
issue last month.

Bryce

Patch Name           TestReq#    LTP Ver    CPU   PASS  FAIL  WARN  BROK RunTime
--------------------------------------------------------------------------------
patch-2.4.27-rc2       294321   20040506  2-way   7226     6     3     6    69.0
patch-2.4.27-rc3       294624   20040506  2-way   7226     6     3     6    69.0
linux-2.4.27           295880   20040707  2-way   7234     3     3     6    68.9
patch-2.6.7-bk9        294333   20040506  2-way   7224     7     3     6    46.1
patch-2.6.7-bk10       294403   20040506  2-way   7223    10     3     7    42.9
patch-2.6.7-bk11       294423   20040506  2-way   7178    46     3     6    47.8
patch-2.6.7-bk12       294442   20040506  2-way   7178    46     3     6    47.6
patch-2.6.7-bk13       294511   20040506  2-way   7178    46     3     6    44.4
patch-2.6.7-bk14       294573   20040506  2-way   7178    46     3     6    44.9
patch-2.6.7-bk15       294601   20040506  2-way   7178    46     3     6    48.7
patch-2.6.7-bk16       294614   20040506  2-way   7178    46     3     6    43.5
patch-2.6.7-bk17       294636   20040506  2-way   7178    46     3     6    41.3
patch-2.6.7-bk18       294648   20040506  2-way   7178    46     3     6    45.1
patch-2.6.7-bk19       294733   20040506  2-way   7178    46     3     6    42.6
patch-2.6.7-bk19       294761   20040603  2-way   7063    40     3     3   125.0
patch-2.6.7-bk20       294757   20040506  2-way   7185    46     3     6    46.2
patch-2.6.7-bk21       294926   20040506  2-way   7184    45     3     6    43.0
2.6.7-mm3              294383   20040506  2-way   7185    46     3     6    47.7
2.6.7-mm3              295809   20040707  2-way   7192    41     3     6    53.5
2.6.7-mm4              294485   20040506  2-way   7177    46     3     3   124.9
2.6.7-mm5              294554   20040506  2-way   7178    46     3     6    46.5
2.6.7-mm6              294691   20040506  2-way   7178    46     3     6    45.2
2.6.7-mm7              294831   20040506  2-way   7184    45     3     6    44.0
patch-2.6.8-rc1        294973   20040506  2-way   7184    45     3     6    47.3
patch-2.6.8-rc2        295222   20040707  2-way   7229     5     3     6    52.6
patch-2.6.8-rc3        295778   20040707  2-way   7229     5     3     6    47.4
patch-2.6.8-rc1-bk1    295008   20040707  2-way   7191    43     3     6    50.6
patch-2.6.8-rc1-bk2    295025   20040707  2-way   7191    41     3     3   125.1
patch-2.6.8-rc1-bk3    295100   20040707  2-way   7191    43     3     6    53.8
patch-2.6.8-rc1-bk4    295128   20040707  2-way   7191    43     3     6    53.5
patch-2.6.8-rc1-bk5    295147   20040707  2-way   7191    43     3     6    52.1
patch-2.6.8-rc1-bk6    295171   20040707  2-way   7229     5     3     6    49.6
patch-2.6.8-rc2-bk1    295239   20040707  2-way   7230     3     3     6    49.9
patch-2.6.8-rc2-bk1    295303   20040707  2-way   7301     2     3     3    44.8
patch-2.6.8-rc2-bk2    295334   20040707  2-way   7229     5     3     6    51.6
patch-2.6.8-rc2-bk3    295351   20040707  2-way   7229     5     3     6    55.9
patch-2.6.8-rc2-bk4    295363   20040707  2-way   7229     5     3     6    55.6
patch-2.6.8-rc2-bk5    295377   20040707  2-way   7229     5     3     6    52.5
patch-2.6.8-rc2-bk6    295427   20040707  2-way   7229     5     3     6    52.5
patch-2.6.8-rc2-bk7    295453   20040707  2-way   7229     5     3     6    53.0
patch-2.6.8-rc2-bk8    295515   20040707  2-way   7229     5     3     6    52.5
patch-2.6.8-rc2-bk9    295549   20040707  2-way   7229     5     3     6    47.6
patch-2.6.8-rc2-bk10   295586   20040707  2-way   7230     3     3     6    48.9
patch-2.6.8-rc2-bk11   295612   20040707  2-way   7229     5     3     6    49.9
patch-2.6.8-rc2-bk12   295635   20040707  2-way   7228     8     3     7    51.0
patch-2.6.8-rc2-bk13   295680   20040707  2-way   7229     5     3     6    47.9
patch-2.6.8-rc3-bk1    295798   20040707  2-way   7228     5     3     3   125.1
patch-2.6.8-rc3-bk2    295831   20040707  2-way   7229     5     3     6    51.6
osdl-2.6.7             294992   20040506  2-way   7223     5     3     3   124.9
2.6.8-rc1-mm1          295081   20040707  2-way   7192    41     3     6    48.6
2.6.8-rc2-mm1          295474   20040707  2-way   7229     5     3     6    49.5
--------------------------------------------------------------------------------

* Note:  When RunTime > 120 min, this usually indicates a test hung.

* For details on any particular test, please access it via

    http://khack.osdl.org/stp/$TestReq

* More info and search tools available at http://www.osdl.org/stp/

Bryce

