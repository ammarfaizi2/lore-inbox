Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbTEDVK3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 17:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbTEDVK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 17:10:29 -0400
Received: from covert.black-ring.iadfw.net ([209.196.123.142]:13319 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id S261741AbTEDVK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 17:10:28 -0400
Date: Sun, 4 May 2003 16:22:56 -0500
From: Art Haas <ahaas@airmail.net>
To: linux-kernel@vger.kernel.org
Subject: Latest GCC-3.3 is much quieter about sign/unsigned comparisons
Message-ID: <20030504212256.GE24907@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This change ...

2003-05-02  Zack Weinberg  <zack@codesourcery.com>

	PR c/10604
	* c-opts.c (c_common_decode_option <OPT_Wall>): Set
	warn_sign_compare for C++ only.
	* doc/invoke.texi: Clarify documentation of -Wsign-compare.

... has eliminated all the warnings that GCC-3.3 by default printed
with regards to signed/unsigned comparisons. A build of today's BK
with this compiler is much quieter than those previously done
with the 3.3 snapshots.

Art Haas
-- 
To announce that there must be no criticism of the President, or that we
are to stand by the President, right or wrong, is not only unpatriotic
and servile, but is morally treasonable to the American public.
 -- Theodore Roosevelt, Kansas City Star, 1918
