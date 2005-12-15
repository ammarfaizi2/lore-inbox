Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750956AbVLOT3j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbVLOT3j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 14:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750953AbVLOT3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 14:29:39 -0500
Received: from smtp.osdl.org ([65.172.181.4]:49094 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750946AbVLOT3i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 14:29:38 -0500
Date: Thu, 15 Dec 2005 11:28:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: lkml@rtr.ca, tglx@linutronix.de, dhowells@redhat.com,
       alan@lxorguk.ukuu.org.uk, pj@sgi.com, mingo@elte.hu, hch@infradead.org,
       torvalds@osdl.org, arjan@infradead.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-Id: <20051215112855.31669dc1.akpm@osdl.org>
In-Reply-To: <4336.1134661053@warthog.cambridge.redhat.com>
References: <20051214155432.320f2950.akpm@osdl.org>
	<1134559121.25663.14.camel@localhost.localdomain>
	<13820.1134558138@warthog.cambridge.redhat.com>
	<20051213143147.d2a57fb3.pj@sgi.com>
	<20051213094053.33284360.pj@sgi.com>
	<dhowells1134431145@warthog.cambridge.redhat.com>
	<20051212161944.3185a3f9.akpm@osdl.org>
	<20051213075441.GB6765@elte.hu>
	<20051213090219.GA27857@infradead.org>
	<20051213093949.GC26097@elte.hu>
	<20051213100015.GA32194@elte.hu>
	<6281.1134498864@warthog.cambridge.redhat.com>
	<14242.1134558772@warthog.cambridge.redhat.com>
	<16315.1134563707@warthog.cambridge.redhat.com>
	<1134568731.4275.4.camel@tglx.tec.linutronix.de>
	<43A0AD54.6050109@rtr.ca>
	<4336.1134661053@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> So... Would you then object to an implementation of a mutex appearing in the
>  tree which semaphores that are being used as strict mutexes can be migrated
>  over to as the opportunity arises?

That would be sane.  The semaphore->completion migration didn't hurt.
