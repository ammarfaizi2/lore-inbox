Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292527AbSCFUax>; Wed, 6 Mar 2002 15:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310162AbSCFUae>; Wed, 6 Mar 2002 15:30:34 -0500
Received: from ns01.netrox.net ([64.118.231.130]:36534 "EHLO smtp01.netrox.net")
	by vger.kernel.org with ESMTP id <S292527AbSCFUaY>;
	Wed, 6 Mar 2002 15:30:24 -0500
Subject: Re: [STATUS 2.5]  March 6, 2002
From: Robert Love <rml@tech9.net>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: linux-kernel@vger.kernel.org, boissiere@attbi.com
In-Reply-To: <20020306190249.GB342@matchmail.com>
In-Reply-To: <3C861CE4.6284.237C28E4@localhost> 
	<20020306190249.GB342@matchmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 06 Mar 2002 15:30:12 -0500
Message-Id: <1015446625.1482.11.camel@icbm>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-03-06 at 14:02, Mike Fedyk wrote:

> > o Beta        Fix long-held locks for low scheduling latency  (Andrew Morton, 
> > etc.)
> 
> IIRC, LL isn't compatible with preempt, so maybe this item should be removed?

Agreed.  It isn't "incompatible" per se but it is certainly not the
intention anymore.  With kernel preemption, we plan to cleanly tackle
the lock hold times.

But maybe that is what the above means ... not "low-latency" per se but
the general reduction in lock hold times and improvement of algorithms. 
This is something Andrew, myself, and others are working on.  It is the
follow up work to preempt-kernel.

	Robert Love	

