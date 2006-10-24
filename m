Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422798AbWJXXDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422798AbWJXXDg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 19:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422799AbWJXXDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 19:03:36 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:42932 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1422798AbWJXXDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 19:03:34 -0400
Subject: Re: [PATCH] Use extents for recording what swap is allocated.
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20061024224731.GA31091@infradead.org>
References: <1161576857.3466.9.camel@nigel.suspend2.net>
	 <20061024204239.GA15689@infradead.org>
	 <1161727596.22729.11.camel@nigel.suspend2.net>
	 <20061024224731.GA31091@infradead.org>
Content-Type: text/plain
Date: Wed, 25 Oct 2006 09:03:33 +1000
Message-Id: <1161731013.22729.40.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2006-10-24 at 23:47 +0100, Christoph Hellwig wrote:
> On Wed, Oct 25, 2006 at 08:06:36AM +1000, Nigel Cunningham wrote:
> > IIRC, I avoided list.h because I only wanted a singly linked list (it
> > never gets traversed backwards). List.h looks to me like all doubly
> > linked lists. Do you know if there are any other singly linked list
> > implementations I could piggy-back?
> > 
> > That said, since there's normally not that many extents, I could switch
> > quite easily and it wouldn't normally waste much memory.
> 
> If the overhead doesn't matter for you (and I doubt it does) I'd say just
> use list.h.    Reusing existing code that doesn't need to be debugged and
> is idiomatically readable to everyone is very helpfull.

Ok.

Regards,

Nigel

