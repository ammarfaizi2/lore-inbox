Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266757AbUFYPSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266757AbUFYPSs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 11:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266758AbUFYPSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 11:18:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38843 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266757AbUFYPSq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 11:18:46 -0400
Date: Fri, 25 Jun 2004 11:18:42 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [oom]: [0/4] fix OOM deadlock running OAST
In-Reply-To: <20040623230730.GJ1552@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0406251118070.9066-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jun 2004, William Lee Irwin III wrote:
> On Wed, Jun 23, 2004 at 03:37:58PM -0700, Andrew Morton wrote:
> > What about zone->all_unreclaimable?
> 
> It's unclear which zones must be checked for this to be of use.

It's perfectly obvious, try_to_free_pages() gets a zone list
as one of its arguments (at least, it did last time I looked).


-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

