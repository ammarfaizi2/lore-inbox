Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263722AbTFKTnL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 15:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263752AbTFKTnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 15:43:11 -0400
Received: from 66-122-194-202.ded.pacbell.net ([66.122.194.202]:22704 "HELO
	mail.keyresearch.com") by vger.kernel.org with SMTP id S263722AbTFKTnJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 15:43:09 -0400
Subject: Re: [PATCH] New x86_64 time code for 2.5.70
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Andi Kleen <ak@suse.de>
Cc: vojtech@suse.cz, discuss@x86-64.org, linux-kernel@vger.kernel.org
In-Reply-To: <20030611191815.GA30411@wotan.suse.de>
References: <1055357432.17154.77.camel@serpentine.internal.keyresearch.com>
	 <20030611191815.GA30411@wotan.suse.de>
Content-Type: text/plain
Message-Id: <1055361411.17154.83.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 11 Jun 2003 12:56:52 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-11 at 12:18, Andi Kleen wrote:

> Does it only look this way or is your white space really broken?

I generated the patch with diff -b because my original changes fixed up
a lot of broken whitespace, which somewhat obscured the functional
changes.  I'll send the plain diff -u instead next time.

> On UP the sync_core is not really needed, but more reliable. May be worth
> it to stick into an #ifdef though.

OK.

> >  	}
> >   
> > +	call++;
> > +
> 
> What's that?

Oops - a piece of instrumentation that got left behind from trying to
fix an SMP deadlock.

	<b

