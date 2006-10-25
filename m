Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423183AbWJYKH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423183AbWJYKH4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 06:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423189AbWJYKH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 06:07:56 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:52941 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1423183AbWJYKHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 06:07:55 -0400
Subject: Re: [PATCH] Use extents for recording what swap is allocated.
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20061025091702.GT4281@kernel.dk>
References: <1161576857.3466.9.camel@nigel.suspend2.net>
	 <20061024204239.GA15689@infradead.org>
	 <1161727596.22729.11.camel@nigel.suspend2.net>
	 <20061025091702.GT4281@kernel.dk>
Content-Type: text/plain
Date: Wed, 25 Oct 2006 20:07:53 +1000
Message-Id: <1161770873.22729.120.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-25 at 11:17 +0200, Jens Axboe wrote:
> On Wed, Oct 25 2006, Nigel Cunningham wrote:
> > IIRC, I avoided list.h because I only wanted a singly linked list (it
> > never gets traversed backwards). List.h looks to me like all doubly
> > linked lists. Do you know if there are any other singly linked list
> > implementations I could piggy-back?
> 
> Look closer in list.h, more specifically at the hlist_ entries.

Thanks for the pointer. I did look at it, but unless I'm misreading,
it's still doubly linked. No matter. I'll use the doubly linked list.

Regards,

Nigel

