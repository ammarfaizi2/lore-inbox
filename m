Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030260AbWF0S2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030260AbWF0S2J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 14:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030263AbWF0S2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 14:28:08 -0400
Received: from amsfep19-int.chello.nl ([213.46.243.16]:30557 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S1030260AbWF0S2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 14:28:07 -0400
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       David Howells <dhowells@redhat.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
Date: Tue, 27 Jun 2006 20:28:01 +0200
Message-Id: <20060627182801.20891.11456.sendpatchset@lappy>
Subject: [PATCH 0/5] mm: tracking dirty pages -v13
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Hopefully the last version. 
Patches are against mainline again.

The 'big' change since last, is that I added a flags parameter to
vma_wants_writenotify(). These flags allow to skip some tests.
This cleans up the subtlety in mprotect_fixup().

Peter
