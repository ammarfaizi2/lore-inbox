Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbWF1URM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbWF1URM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 16:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbWF1URL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 16:17:11 -0400
Received: from amsfep19-int.chello.nl ([213.46.243.16]:9596 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S1751288AbWF1URK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 16:17:10 -0400
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       David Howells <dhowells@redhat.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
Date: Wed, 28 Jun 2006 22:17:02 +0200
Message-Id: <20060628201702.8792.69638.sendpatchset@lappy>
Subject: [PATCH 0/6] mm: tracking dirty pages -v14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Hopefully the last version (again!).

Hugh really didn't like my vma_wants_writenotify() flags, so I took
them out again.

Also added another patch to the end that corrects the do_wp_page()
COWing of anonymous pages.

Peter
