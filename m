Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964917AbVLMJpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964917AbVLMJpU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 04:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964913AbVLMJpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 04:45:20 -0500
Received: from smtp.osdl.org ([65.172.181.4]:30186 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964780AbVLMJpT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 04:45:19 -0500
Date: Tue, 13 Dec 2005 01:44:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: ak@suse.de, mingo@elte.hu, dhowells@redhat.com, torvalds@osdl.org,
       hch@infradead.org, arjan@infradead.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-Id: <20051213014437.6954d26c.akpm@osdl.org>
In-Reply-To: <20051213092437.GS23384@wotan.suse.de>
References: <dhowells1134431145@warthog.cambridge.redhat.com>
	<20051212161944.3185a3f9.akpm@osdl.org>
	<20051213075441.GB6765@elte.hu>
	<20051213075835.GZ15804@wotan.suse.de>
	<20051213004257.0f87d814.akpm@osdl.org>
	<20051213084926.GN23384@wotan.suse.de>
	<20051213010126.0832356d.akpm@osdl.org>
	<20051213090517.GQ23384@wotan.suse.de>
	<20051213011540.3070176f.akpm@osdl.org>
	<20051213092437.GS23384@wotan.suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> > There are a few places in the tree which refuse to compile with 3.1 and 3.2.
> 
>  Really? Which ones? 

grep for __GNUC_MINOR__
