Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbVGNOqG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbVGNOqG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 10:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbVGNOqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 10:46:06 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:41711 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261416AbVGNOqF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 10:46:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=r3FzwxfGcaZ8dL6qbrzI1AtldyXEdZeiUCmBywzeXqOD/ZHG61Gn7rSe8hq2h4dfnydpRrekMbPAZ1VFDZ7p+mo7rcyKAeVxhsiXUIQIDmSqAwRqtK1eJkolZpzzRZg+ondvjm595vnv+7PO64Q/vFC1fHy2tc1TbnBqTduXNXg=
Message-ID: <60868aed050714074550e0adcf@mail.gmail.com>
Date: Thu, 14 Jul 2005 17:45:15 +0300
From: Yura Pakhuchiy <pakhuchiy@gmail.com>
Reply-To: Yura Pakhuchiy <pakhuchiy@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: XFS corruption on move from xscale to i686
Cc: Nathan Scott <nathans@sgi.com>, linux-xfs@oss.sgi.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       tibor@altlinux.ru
In-Reply-To: <20050714143830.GA17842@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1120756552.5298.10.camel@pc299.sam-solutions.net>
	 <20050708042146.GA1679@frodo>
	 <60868aed0507130822c2e9e97@mail.gmail.com>
	 <20050714012048.GB937@frodo>
	 <60868aed050714065047e3aaec@mail.gmail.com>
	 <20050714143830.GA17842@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/7/14, Christoph Hellwig <hch@infradead.org>:
> On Thu, Jul 14, 2005 at 04:50:01PM +0300, Yura Pakhuchiy wrote:
> > 2005/7/14, Nathan Scott <nathans@sgi.com>:
> > > On Wed, Jul 13, 2005 at 06:22:28PM +0300, Yura Pakhuchiy wrote:
> > > > I found patch by Greg Ungreger to fix this problem, but why it's still
> > > > not in mainline? Or it's a gcc problem and should be fixed by gcc folks?
> > >
> > > Yes, IIRC the patch was incorrect for other platforms, and it sure
> > > looked like an arm-specific gcc problem (this was ages back, so
> > > perhaps its fixed by now).
> >
> > AFAIR gcc-3.4.3 was released after this conversation take place at linux-xfs,
> > maybe add something like this:
> >
> > #ifdef XSCALE
> >     /* We need this because some gcc versions for xscale are broken. */
> >     [patched version here]
> > #else
> >     [original version here]
> > #endif
> 
> no, just fix your compiler or let the gcc folks do it.  Did anyone of
> the arm folks ever open a PR at the gcc bugzilla with a reproduced
> testcase?  You're never get your compiler fixed with that attitude.

Yes, but a lof of people use older versions of compilers and suffer
from this bug.
I personally was very unhappy when lost my data.

Best regards,
        Yura
