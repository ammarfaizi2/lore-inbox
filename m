Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265161AbUFROnf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265161AbUFROnf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 10:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265200AbUFROnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 10:43:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:13770 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265161AbUFROnc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 10:43:32 -0400
Date: Fri, 18 Jun 2004 10:43:19 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Jens Axboe <axboe@suse.de>
cc: Andrew Morton <akpm@osdl.org>, 4Front Technologies <dev@opensound.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Stop the Linux kernel madness
In-Reply-To: <20040618082708.GD12881@suse.de>
Message-ID: <Pine.LNX.4.44.0406181037180.8065-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2004, Jens Axboe wrote:
> On Thu, Jun 17 2004, Andrew Morton wrote:

> > Hopefully we'll be seeing more patches from them soon.

> The last thing anyone wants is the situation we had/have with
> (basically all) 2.4 vendor kernels.

Absolutely agreed.  Nobody likes maintaining hundreds of
patches for multiple versions of a distribution, especially
not the companies that pay the salary of the programmers
tied up doing that kind of work ;)

There are sound economic reasons why Linux companies should
merge their stuff back into the upstream kernel;  or better 
yet, develop the functionality in the upstream kernel before
merging it into the distribution tree (eg. NPTL, selinux
enhancements, O(1) scheduler).

Maintaining a patch for one version of the distribution, in
order to get a feature to customers sooner, is perfectly
doable and may make economic sense.

Maintaining an out-of-tree patch forever because you didn't
get around to merging it into the upstream kernel doesn't.
It is nothing but a waste of effort, doing the same work
over and over again for every version of the product, instead
of doing the work once and then focussing your engineers on
implementing new functionality.

Yes, this is a hint at certain embedded developers.  You
know who you are and chances are you also know what you would
like to develop if you no longer had to spend your time porting
the same old patches from one version of the product to the next.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

