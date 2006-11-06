Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753783AbWKFUv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753783AbWKFUv4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 15:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753793AbWKFUv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 15:51:56 -0500
Received: from mx1.redhat.com ([66.187.233.31]:13997 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1753783AbWKFUvz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 15:51:55 -0500
Date: Mon, 6 Nov 2006 15:40:59 -0500 (EST)
From: Jason Baron <jbaron@redhat.com>
X-X-Sender: jbaron@dhcp83-20.boston.redhat.com
To: Roland Dreier <rdreier@cisco.com>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       arjan@infradead.org
Subject: Re: locking hierarchy based on lockdep
In-Reply-To: <ada8xiol3a3.fsf@cisco.com>
Message-ID: <Pine.LNX.4.64.0611061539400.29750@dhcp83-20.boston.redhat.com>
References: <Pine.LNX.4.64.0611061315380.29750@dhcp83-20.boston.redhat.com>
 <20061106200529.GA15370@elte.hu> <adapsc0l40x.fsf@cisco.com>
 <Pine.LNX.4.64.0611061519220.29750@dhcp83-20.boston.redhat.com>
 <ada8xiol3a3.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 6 Nov 2006, Roland Dreier wrote:

>  > interesting...perhaps if we layered say the directory structure on the 
>  > list too like by the top level kernel directories drivers, kernel, mm, 
>  > net, etc. it might be more readable.
> 
> I'm not sure that you need to do something manual or ad hoc like that,
> although it might be necessary in the end.  I'd be curious to see how
> the list of locks partitions up if you just divide it up into groups
> of locks that have some relationship.  I guess the question is, if you
> draw the graph whose nodes are locks and whose edges connect locks
> that are held together, how many connected pieces does that graph have?
> 
>  - R.
> 

ok, so grouping the list by sections of connected components-that's a nice 
idea, and would probably make for an interesting list.

-jason
