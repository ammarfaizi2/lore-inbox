Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752137AbWFWWbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752137AbWFWWbH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 18:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752138AbWFWWbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 18:31:07 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:13869 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S1752137AbWFWWbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 18:31:06 -0400
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       David Howells <dhowells@redhat.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
Date: Sat, 24 Jun 2006 00:31:03 +0200
Message-Id: <20060623223103.11513.50991.sendpatchset@lappy>
Subject: [PATCH 0/5] mm: tracking dirty pages -v11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I hope to have addressed all Hugh's latest comments in this version.
Its against 2.6.17-mm1, however I wasted most of the day trying to 
test it on that kernel. But due to various circumstances that failed.

So I've tested something like this against something 2.6.17'ish and 
respun against the -mm lineup.

I've taken Hugh's msync changes too, looks a lot better and does indeed
fix some boundary cases.

Peter
