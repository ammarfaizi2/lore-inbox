Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262197AbTFBLy6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 07:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbTFBLy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 07:54:58 -0400
Received: from holomorphy.com ([66.224.33.161]:20126 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262197AbTFBLy5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 07:54:57 -0400
Date: Mon, 2 Jun 2003 05:07:53 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Subject: pgcl-2.5.70-bk7-1
Message-ID: <20030602120753.GE20413@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some oddities in and around arch/i386/kernel/srat.c, with some
cleanups attached.

Otherwise a brute-force merge to 2.5.70-bk7. Also available as an
incremental diff against pgcl-2.5.70-bk6-1 as pgcl-2.5.70-bk6-2.

Testers, especially x440-based testers, please update to this release.

Still hunting for the sysenter bug. There's also a report of an LTP
regression the tester didn't send in an oops for. Things like fsx would
also be helpful, e.g. on fs's with blocksize > 4KB with MMUPAGES_SIZE
== 4KB, especially with aio and direct io involved.

Unified anonymizing fault handling is also scheduled to happen "soon",
at which point the core performance code should be finalized, modulo
stability regressions to be fixed up as needed and tuning. Then things
should move on to drivers/ and fs/ sweeps.

As usual, available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/wli/vm/pgcl/


-- wli
