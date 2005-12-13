Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030288AbVLMWZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030288AbVLMWZs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 17:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030284AbVLMWZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 17:25:48 -0500
Received: from cantor2.suse.de ([195.135.220.15]:19363 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030272AbVLMWZr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 17:25:47 -0500
Date: Tue, 13 Dec 2005 23:25:43 +0100
From: Andi Kleen <ak@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>, mingo@elte.hu,
       dhowells@redhat.com, torvalds@osdl.org, hch@infradead.org,
       arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051213222543.GY23384@wotan.suse.de>
References: <dhowells1134431145@warthog.cambridge.redhat.com> <20051212161944.3185a3f9.akpm@osdl.org> <20051213075441.GB6765@elte.hu> <20051213075835.GZ15804@wotan.suse.de> <20051213004257.0f87d814.akpm@osdl.org> <20051213084926.GN23384@wotan.suse.de> <20051213010126.0832356d.akpm@osdl.org> <20051213090517.GQ23384@wotan.suse.de> <20051213221810.GU23349@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051213221810.GU23349@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 3.2+ would be better than 3.1+
> 
> Remember that 3.2 would have been named 3.1.2 if there wasn't the C++
> ABI change, and I don't remember any big Linux distribution actually 
> using gcc 3.1 as default compiler.

Yes, but the kernel doesn't use C++ and afaik other than that there were only
a few minor bugfixes between 3.1 and 3.2. So it doesn't make any
difference for this special case.

-Andi
