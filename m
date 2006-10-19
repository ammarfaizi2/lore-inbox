Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161382AbWJSK0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161382AbWJSK0e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 06:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161394AbWJSKZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 06:25:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:1989 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161382AbWJSKZd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 06:25:33 -0400
Message-Id: <20061019101722.805147000@chello.nl>
User-Agent: quilt/0.45-1
Date: Thu, 19 Oct 2006 12:17:22 +0200
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Cc: Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@osdl.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [RFC][PATCH 0/4] on do_page_fault() and *copy*_inatomic
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In light of the recent work on fault handlers and generic_file_buffered_write()
I've gone over some of the arch specific stuff that supports this work.

The following four patches are the result...

Peter

