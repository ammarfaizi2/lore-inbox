Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263614AbTCUM3O>; Fri, 21 Mar 2003 07:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263615AbTCUM3O>; Fri, 21 Mar 2003 07:29:14 -0500
Received: from holomorphy.com ([66.224.33.161]:28556 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S263614AbTCUM3O>;
	Fri, 21 Mar 2003 07:29:14 -0500
Date: Fri, 21 Mar 2003 04:39:59 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: pgcl-2.5.65-2
Message-ID: <20030321123959.GG1350@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Implement Hugh's 2nd heuristic and scan around neighboring PTE's on the
same L3 pagetable for PTE's to map pieces of anonymous pages with.

Tested on NUMA-Q with 32K PAGE_SIZE.

As usual, available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/wli/vm/pgcl/

Incremental atop pgcl-2.5.65-1


-- wli
