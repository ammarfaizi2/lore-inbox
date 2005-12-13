Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964957AbVLMOd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964957AbVLMOd7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 09:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964951AbVLMOd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 09:33:59 -0500
Received: from rtr.ca ([64.26.128.89]:45245 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S964950AbVLMOd6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 09:33:58 -0500
Message-ID: <439EDBC9.5000304@rtr.ca>
Date: Tue, 13 Dec 2005 09:33:45 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: Andi Kleen <ak@suse.de>, Arjan van de Ven <arjan@infradead.org>,
       Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       torvalds@osdl.org, hch@infradead.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
References: <dhowells1134431145@warthog.cambridge.redhat.com> <20051212161944.3185a3f9.akpm@osdl.org> <20051213075441.GB6765@elte.hu> <1134460804.2866.17.camel@laptopd505.fenrus.org> <20051213090349.GE10088@elte.hu> <20051213090917.GC15804@wotan.suse.de> <20051213093427.GA26097@elte.hu>
In-Reply-To: <20051213093427.GA26097@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >'struct compat_semaphore'

I really think this data type needs a better name,
one that reflects what it does.

Something like 'struct binary_semaphore' or something.

Cheers
