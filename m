Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750992AbWDJQNO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbWDJQNO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 12:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbWDJQNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 12:13:14 -0400
Received: from ms-smtp-02.texas.rr.com ([24.93.47.41]:1985 "EHLO
	ms-smtp-02.texas.rr.com") by vger.kernel.org with ESMTP
	id S1750992AbWDJQNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 12:13:14 -0400
Subject: [RFC/PATCH] Shared Page Tables [0/2]
From: Dave McCracken <dmccr@us.ibm.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Content-Type: text/plain
Date: Mon, 10 Apr 2006 11:13:08 -0500
Message-Id: <1144685588.570.35.camel@wildcat.int.mccr.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a new cut of the shared page table patch.  I divided it into
two patches.  The first one just fleshes out the
pxd_page/pxd_page_kernel macros across the architectures.  The
second one is the main patch.

This version of the patch should address the concerns Hugh raised.
Hugh, I'd appreciate your feedback again.  Did I get everything?

These patches apply against 2.6.17-rc1.

Dave McCracken


