Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265343AbUF2BqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265343AbUF2BqT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 21:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265349AbUF2BqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 21:46:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:44245 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265343AbUF2BqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 21:46:17 -0400
Date: Mon, 28 Jun 2004 18:46:15 -0700 (PDT)
From: Bryce Harrington <bryce@osdl.org>
To: <ltp-list@lists.sourceforge.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Recent changes in LTP test results
Message-ID: <Pine.LNX.4.33.0406281833380.13977-100000@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a listing of LTP results for the linux kernel.  For the 2.6.x
series LTP results have been pretty constant, but they've gotten
interesting lately:

Patch Name           TestReq#     CPU  PASS  FAIL  WARN  BROK  RunTime
----------------------------------------------------------------------
patch-2.4.27-rc2       294321  2-way  7226     6     3     6    69.0
linux-2.6.7            294027  2-way  7225     6     3     6    46.0
linux-2.6.7            294004  1-way  7225     6     3     6    42.2
patch-2.6.7-bk1        294069  2-way  7224     7     3     6    45.9
patch-2.6.7-bk2        294081  2-way  7224     7     3     6    45.9
patch-2.6.7-bk3        294103  2-way  7224     7     3     6    46.4
patch-2.6.7-bk4        294165  2-way  7187     7     3     6    48.7
patch-2.6.7-bk5        294181  2-way  7181     7     3     6    45.5
patch-2.6.7-bk6        294204  2-way  7224     7     3     6    47.1
patch-2.6.7-bk7        294228  2-way  7224     7     3     6    49.0
patch-2.6.7-bk8        294304  2-way  7223    10     3     7    47.5
patch-2.6.7-bk9        294333  2-way  7224     7     3     6    46.1
patch-2.6.7-bk10       294403  2-way  7223    10     3     7    42.9
patch-2.6.7-bk11       294423  2-way  7178    46     3     6    47.8
2.6.7-mm1              294146  2-way  7185    46     3     6    59.1
2.6.7-mm1              294126  1-way  7185    46     3     6    52.9
2.6.7-mm2              294271  2-way  7181    47     3     6    44.9
2.6.7-mm3              294363  1-way  7185    46     3     6    41.0
2.6.7-rc3-mm2          293949  2-way  7223     8     3     6    46.5

We usually always see 6-7 fails on the 2.6.x kernels, so the increase is
unusual.

I've generated some detailed LTP test result reports on a few of the
above runs, with specifics about the test runs and failures.  These are
available here:

    http://developer.osdl.org/bryce/ltp/

HTH,
Bryce



