Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274985AbTHLCS7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 22:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274987AbTHLCS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 22:18:59 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:18170 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S274985AbTHLCS5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 22:18:57 -0400
Subject: Re: C99 Initialisers
From: Robert Love <rml@tech9.net>
To: CaT <cat@zip.com.au>
Cc: linux-kernel@vger.kernel.org, kernel-janitor-discuss@lists.sourceforge.net
In-Reply-To: <20030812020226.GA4688@zip.com.au>
References: <20030812020226.GA4688@zip.com.au>
Content-Type: text/plain
Message-Id: <1060654733.684.267.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-3) 
Date: Mon, 11 Aug 2003 19:18:53 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-08-11 at 19:02, CaT wrote:
> Is there any interest ins omeone 'fixing up' as many structs in the
> kernel from the form:

Yes, indeed, especially for 2.6. There has been a lot of work already in
this direction -- not too much should be left.

> And if so, what form should I feed it back in? Big patches? 1 patch
> per file? 1 per dir?

Whatever makes most sense. One per directory is probably OK for most
things.

> Main reaosn I'm asking is that it's slowly being done but isn't in
> the janitor list of things to do yet. If it were I'd just do it. ;)

It should be in the list.

Convert GNU-style to C99-style.  I think converting unnamed initializers
to named initializers is a Good Thing, too.

	Robert Love


