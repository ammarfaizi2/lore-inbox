Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264144AbTEaFBu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 01:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264145AbTEaFBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 01:01:50 -0400
Received: from holomorphy.com ([66.224.33.161]:17299 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264144AbTEaFBu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 01:01:50 -0400
Date: Fri, 30 May 2003 22:15:04 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Subject: pgcl-2.5.70-bk4-1
Message-ID: <20030531051504.GX15692@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(1) fix for fault_in_page_*() not faulting in enough mmupages.
(2) fix for bogus open-coded ptep_to_address()
(3) fix for iounmap() missing its targets

Unfortunately, none of these are the bug we're looking for.
(which is wrong pages landing on the LRU's)

A pgcl-2.5.70-2 patch with these changes incrementally atop
pgcl-2.5.70-1 is also available.

Available from the usual place:
ftp://ftp.kernel.org/pub/linux/kernel/people/wli/vm/pgcl/


-- wli
