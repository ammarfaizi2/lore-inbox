Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263319AbTJESUu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 14:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263316AbTJESUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 14:20:49 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:57736 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S263319AbTJESUs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 14:20:48 -0400
Date: Sun, 5 Oct 2003 19:16:30 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Krzysztof Benedyczak <golbi@mat.uni.torun.pl>,
       linux-kernel@vger.kernel.org, Manfred Spraul <manfred@colorfullife.com>,
       pwaechtler@mac.com, Michal Wronski <wrona@mat.uni.torun.pl>
Subject: Re: POSIX message queues
Message-ID: <20031005181630.GA26958@mail.shareable.org>
References: <Pine.GSO.4.58.0310051047560.12323@ultra60> <3F80484A.3030105@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F80484A.3030105@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> > In another words: is our implementation in the position
> > of NGPT or better? ;-)
> 
> I don't understand.  Why NGPT and what about "position"?

He is asking if the work will be wasted effort that is dismissed or
superceded, like NGPT was.

> If you mean
> including a solution in the runtime (librt), sure, this will happen.
> But not before I see a solution in the official kernel.

Speaking of librt - I should not have to link in pthreads and the
run-time overhead associated with it (locking stdio etc.) just so I
can use shm_open().  Any chance of fixing this?

-- Jamie
