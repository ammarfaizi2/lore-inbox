Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288248AbSAHTAF>; Tue, 8 Jan 2002 14:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288253AbSAHS74>; Tue, 8 Jan 2002 13:59:56 -0500
Received: from ns.caldera.de ([212.34.180.1]:2537 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S288248AbSAHS7r>;
	Tue, 8 Jan 2002 13:59:47 -0500
Date: Tue, 8 Jan 2002 19:59:21 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Robert Love <rml@tech9.net>
Cc: David Howells <dhowells@redhat.com>, torvalds@transmeta.com,
        arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] preempt abstraction
Message-ID: <20020108195920.A14642@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Robert Love <rml@tech9.net>, David Howells <dhowells@redhat.com>,
	torvalds@transmeta.com, arjanv@redhat.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <10940.1010511619@warthog.cambridge.redhat.com> <1010516250.3229.21.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1010516250.3229.21.camel@phantasy>; from rml@tech9.net on Tue, Jan 08, 2002 at 01:57:28PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2002 at 01:57:28PM -0500, Robert Love wrote:
> Why not use the more commonly named conditional_schedule instead of
> preempt() ?  In addition to being more in-use (low-latency, lock-break,
> and Andrea's aa patch all use it) I think it better conveys its meaning,
> which is a schedule() but only conditionally.

I think the choice is very subjective, but I prefer preempt().
It's nicely short to type (!) and similar in spirit to Ingo's yield()..

	Christoph

