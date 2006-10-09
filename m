Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964852AbWJIU61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbWJIU61 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 16:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964855AbWJIU61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 16:58:27 -0400
Received: from gate.crashing.org ([63.228.1.57]:30409 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964852AbWJIU60 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 16:58:26 -0400
Subject: Re: [rfc] 2.6.19-rc1-git5: consolidation of file backed fault
	handlers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Hugh Dickins <hugh@veritas.com>,
       Linux Memory Management <linux-mm@kvack.org>,
       Andrew Morton <akpm@osdl.org>, Jes Sorensen <jes@sgi.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20061009140354.13840.71273.sendpatchset@linux.site>
References: <20061009140354.13840.71273.sendpatchset@linux.site>
Content-Type: text/plain
Date: Tue, 10 Oct 2006 06:57:52 +1000
Message-Id: <1160427472.7752.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-09 at 18:12 +0200, Nick Piggin wrote:
> OK, I've cleaned up and further improved this patchset, removed duplication
> while retaining legacy nopage handling, restored page_mkwrite to the ->fault
> path (due to lack of users upstream to attempt a conversion), converted the
> rest of the filesystems to use ->fault, restored MAP_POPULATE and population
> of remap_file_pages pages, replaced nopfn completely, and removed
> NOPAGE_REFAULT because that can be done easily with ->fault.

What is the replacement ?

Ben.


