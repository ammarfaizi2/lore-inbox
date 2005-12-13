Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932596AbVLMJYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932596AbVLMJYj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 04:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932592AbVLMJYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 04:24:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:39357 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932590AbVLMJYi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 04:24:38 -0500
Date: Tue, 13 Dec 2005 10:24:37 +0100
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, mingo@elte.hu, dhowells@redhat.com,
       torvalds@osdl.org, hch@infradead.org, arjan@infradead.org,
       matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051213092437.GS23384@wotan.suse.de>
References: <dhowells1134431145@warthog.cambridge.redhat.com> <20051212161944.3185a3f9.akpm@osdl.org> <20051213075441.GB6765@elte.hu> <20051213075835.GZ15804@wotan.suse.de> <20051213004257.0f87d814.akpm@osdl.org> <20051213084926.GN23384@wotan.suse.de> <20051213010126.0832356d.akpm@osdl.org> <20051213090517.GQ23384@wotan.suse.de> <20051213011540.3070176f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051213011540.3070176f.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Spose so - I don't know what people are using out there.

I don't think it was shipped in major distros at least (AFAIK) 
They all went from 2.95 to 3.1/3.2 

Perhaps stick an error for 3.0 in and wait if people are complaining? 

> 
> > AFAIK it has never been widely used. If we assume 3.1+ minimum it has the 
> > advantage that named assembly arguments work, which make
> > the inline assembly often a lot easier to read and maintain.
> 
> There are a few places in the tree which refuse to compile with 3.1 and 3.2.

Really? Which ones? 

Haven't seen that and I still use 3.2 occasionally (it's the default
compiler on SLES9 and I believe on RHEL3 too)  

-Andi

