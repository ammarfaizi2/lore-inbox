Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbVAGV2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbVAGV2V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 16:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbVAGV11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 16:27:27 -0500
Received: from mail.suse.de ([195.135.220.2]:10669 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261618AbVAGVYx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 16:24:53 -0500
Date: Fri, 7 Jan 2005 22:24:38 +0100
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Nikita Danilov <nikita@clusterfs.com>, pmarques@grupopie.com,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org, hch@infradead.org
Subject: Re: [RFC] per thread page reservation patch
Message-ID: <20050107212438.GB13026@wotan.suse.de>
References: <20050103011113.6f6c8f44.akpm@osdl.org> <20050103114854.GA18408@infradead.org> <41DC2386.9010701@namesys.com> <1105019521.7074.79.camel@tribesman.namesys.com> <20050107144644.GA9606@infradead.org> <1105118217.3616.171.camel@tribesman.namesys.com> <41DEDF87.8080809@grupopie.com> <m1llb5q7qs.fsf@clusterfs.com> <20050107132459.033adc9f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050107132459.033adc9f.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And the whole idea is pretty flaky really - how can one precalculate how
> much memory an arbitrary md-on-dm-on-loop-on-md-on-NBD stack will want to
> use?  It really would be better if we could drop the whole patch and make
> reiser4 behave more sanely when its writepage is called with for_reclaim=1.

Or just preallocate into a private array. 

-Andi
