Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262055AbUK3Mtf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbUK3Mtf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 07:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbUK3Mtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 07:49:35 -0500
Received: from blackhole.sk ([212.89.236.103]:53669 "EHLO
	blackhole.websupport.sk") by vger.kernel.org with ESMTP
	id S262055AbUK3Mtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 07:49:32 -0500
Date: Tue, 30 Nov 2004 13:48:01 +0100
From: stanojr@blackhole.websupport.sk
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: quota deadlock
Message-ID: <20041130124801.GB14551@blackhole.websupport.sk>
References: <20041112173118.GC17928@blackhole.websupport.sk> <20041129161801.23883a03.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041129161801.23883a03.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2004 at 04:18:01PM -0800, Andrew Morton wrote:
> stanojr@blackhole.websupport.sk wrote:
> >
> > heavy write access to partition with quota enabled causes deadlock. if
> >  processes try to access the deadlocked partition they                    
> >  simply have no response and cannot be killed with SIGKILL. i've been
> >  testing with reiserfs and ext2 on 2.6.9 kernel.
> 
> There are a bunch of patches in 2.6.10-rc2-mm3 which are designed to fix
> quota deadlocks.  Could you please test that (or a later -mm kernel) and
> let us know the result?
> 
> Thanks.
> 
hello
i tried mm3 patch and it was working fine. i havent encountered any problems.
thanks
