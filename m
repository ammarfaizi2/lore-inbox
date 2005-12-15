Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161116AbVLOFYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161116AbVLOFYp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 00:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161115AbVLOFYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 00:24:45 -0500
Received: from mgate02.necel.com ([203.180.232.82]:27794 "EHLO
	mgate02.necel.com") by vger.kernel.org with ESMTP id S1161111AbVLOFYo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 00:24:44 -0500
To: David Howells <dhowells@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@osdl.org, akpm@osdl.org,
       hch@infradead.org, arjan@infradead.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
References: <1134482408.11732.30.camel@localhost.localdomain>
	<1134479118.11732.14.camel@localhost.localdomain>
	<dhowells1134431145@warthog.cambridge.redhat.com>
	<3874.1134480759@warthog.cambridge.redhat.com>
	<14796.1134487414@warthog.cambridge.redhat.com>
From: Miles Bader <miles.bader@necel.com>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
Date: Thu, 15 Dec 2005 14:24:08 +0900
In-Reply-To: <14796.1134487414@warthog.cambridge.redhat.com> (David Howells's message of "Tue, 13 Dec 2005 15:23:34 +0000")
Message-Id: <buo7ja76ih3.fsf@dhapc248.dev.necel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> writes:
>> Is there a reason you didnt answer the comment about down/up being the
>> usual way computing refers to the operations on counting semaphores but
>> just deleted it ?
>
> up/down is also used in conjunction with mutexes and R/W semaphores, so
> counting semaphores do not have exclusive rights to the terminology.

I suspect that is only the case where the author of the mutex was
accustomed to using semaphores as mutexes before-hand; "up/down" are
rather poor names for mutex operations otherwise.  lock/unlock are much
better.

-Miles
-- 
Next to fried food, the South has suffered most from oratory.
  			-- Walter Hines Page
