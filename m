Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267876AbUHKCIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267876AbUHKCIN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 22:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267877AbUHKCIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 22:08:13 -0400
Received: from mx1.redhat.com ([66.187.233.31]:65413 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267876AbUHKCIK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 22:08:10 -0400
Date: Tue, 10 Aug 2004 22:08:09 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@dhcp83-102.boston.redhat.com
To: John Richard Moser <nigelenki@comcast.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Locking scheme to block less
In-Reply-To: <41183EFA.5090600@comcast.net>
Message-ID: <Pine.LNX.4.44.0408102207470.23161-100000@dhcp83-102.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Aug 2004, John Richard Moser wrote:
> Rik van Riel wrote:
> > On Mon, 9 Aug 2004, John Richard Moser wrote:

> >>Currently, the kernel uses only spin_locks,
> > 
> > Oh ?   Haven't you seen the read/write locks in
> > include/linux/spinlock.h or the lockless synchronisation
> > provided by include/linux/rcu.h ?
> 
> No, last I looked was in 2.4, and it was a passing glance long ago.

We've had read write locks since 2.2...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

