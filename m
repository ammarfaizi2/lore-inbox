Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263237AbVFXKxB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263237AbVFXKxB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 06:53:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263240AbVFXKxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 06:53:01 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:45536 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S263237AbVFXKw6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 06:52:58 -0400
Date: Fri, 24 Jun 2005 16:20:11 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] files: various updates
Message-ID: <20050624105011.GB4804@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Here is the set of update patches that fixes, changes and documents
various issues in the new fd management patchset in -mm1. The
first patch - fix-dupfd-reacquire-fdt.patch fixes bugme #4770
and the oopses people other than me were seeing.

I have tested this patchset with 2.6.12-mm1 in my lab, not sure
if it means anything, given bugme #4770 and my userland :-)
Please include these in -mm1 for testing.

Thanks
Dipankar
