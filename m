Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965019AbVITSXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965019AbVITSXw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 14:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965021AbVITSXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 14:23:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20679 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965019AbVITSXv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 14:23:51 -0400
Date: Tue, 20 Sep 2005 14:23:30 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@cuia.boston.redhat.com
To: Blaisorblade <blaisorblade@yahoo.it>
cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: Remap_file_pages, RSS limits, security implications (was: Re:
 [uml-devel] Re: [RFC] [patch 0/18] remap_file_pages protection support (for
 UML), try 3)
In-Reply-To: <200509201706.06852.blaisorblade@yahoo.it>
Message-ID: <Pine.LNX.4.63.0509201422460.1724@cuia.boston.redhat.com>
References: <200508262023.29170.blaisorblade@yahoo.it>
 <200509042110.01968.blaisorblade@yahoo.it> <Pine.LNX.4.61.0509071259380.17612@goblin.wat.veritas.com>
 <200509201706.06852.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Sep 2005, Blaisorblade wrote:

> And the RLIMIT_RSS is totally unused - I bet Rik's patch didn't manage 
> to go in, or it's me missing something?

It never went into the kernel, because Andrew did not find
a workload where the code provided benefits.  Sounds fair
to me ;)

-- 
All Rights Reversed
