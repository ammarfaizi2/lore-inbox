Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261165AbVDYUms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbVDYUms (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 16:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbVDYUms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 16:42:48 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:34507 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S261192AbVDYUk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 16:40:26 -0400
Date: Mon, 25 Apr 2005 13:39:52 -0700
From: Wim Coekaerts <wim.coekaerts@oracle.com>
To: David Teigland <teigland@redhat.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 0/7] dlm: overview
Message-ID: <20050425203952.GE25002@ca-server1.us.oracle.com>
References: <20050425151136.GA6826@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050425151136.GA6826@redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is a distributed lock manager (dlm) that we'd like to see added to
> the kernel.  The dlm programming api is very similar to that found on
> other operating systems, but this is modeled most closely after that in
> VMS.

do you have any performance data at all on this ? I like to see a dlm
but I like to see something that will also perform well. My main concern
is that I have not seen anything relying on this code do "reasonably
well". eg can you show gfs numbers w/ number of nodes and scalability ?

I think it's time we submit ocfs2 w/ it's cluster stack so that folks
can compare (including actual data/numbers), we have been waiting to
stabilize everything but I guess there is this preemptive strike going
on so we might just as well. at least we have had hch and folks comment,
before sending to submit code.

Andrew - we will submit ocfs2 so you can have a look, compare and move
on.  we will work with any stack that eventuslly gets accepted, just want 
to see the choice out there and an educated decision.

hopefully tomorrow, including data comparing single node and multinode
performance.

Wim

