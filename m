Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964979AbVLMOp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964979AbVLMOp1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 09:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964977AbVLMOp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 09:45:27 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:24244 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964974AbVLMOpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 09:45:25 -0500
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
From: Arjan van de Ven <arjan@infradead.org>
To: Mark Lord <lkml@rtr.ca>
Cc: Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       torvalds@osdl.org, hch@infradead.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
In-Reply-To: <439EDBC9.5000304@rtr.ca>
References: <dhowells1134431145@warthog.cambridge.redhat.com>
	 <20051212161944.3185a3f9.akpm@osdl.org> <20051213075441.GB6765@elte.hu>
	 <1134460804.2866.17.camel@laptopd505.fenrus.org>
	 <20051213090349.GE10088@elte.hu> <20051213090917.GC15804@wotan.suse.de>
	 <20051213093427.GA26097@elte.hu>  <439EDBC9.5000304@rtr.ca>
Content-Type: text/plain
Date: Tue, 13 Dec 2005 15:45:08 +0100
Message-Id: <1134485109.9814.2.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-13 at 09:33 -0500, Mark Lord wrote:
>  >'struct compat_semaphore'
> 
> I really think this data type needs a better name,
> one that reflects what it does.
> 
> Something like 'struct binary_semaphore' or something.

see the thing is.. this is the counting one ;)
the -rt naming is just too confusing (but done to keep patch maintenance
reasonable, which is fair enough for that purpose, but not good enough
for kernel.org)

