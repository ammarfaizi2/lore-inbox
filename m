Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261392AbTCJSN7>; Mon, 10 Mar 2003 13:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261393AbTCJSN7>; Mon, 10 Mar 2003 13:13:59 -0500
Received: from c9-rba-216.absamail.co.za ([196.39.55.216]:24580 "EHLO
	mail.codefountain.com") by vger.kernel.org with ESMTP
	id <S261392AbTCJSN6>; Mon, 10 Mar 2003 13:13:58 -0500
Date: Mon, 10 Mar 2003 20:28:04 +0200
From: Craig Schlenter <craig.schlenter@absamail.co.za>
To: Patrick Mochel <mochel@osdl.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel bug in dcache.h:266; 2.5.64, EIP at sysfs_remove_dir
Message-ID: <20030310182804.GB2289@codefountain.com>
References: <Pine.LNX.4.33.0303091604530.994-100000@localhost.localdomain> <1047251674.1418.1.camel@ixodes.goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1047251674.1418.1.camel@ixodes.goop.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 09, 2003 at 03:14:34PM -0800, Jeremy Fitzhardinge wrote:
> On Sun, 2003-03-09 at 14:06, Patrick Mochel wrote:
> > Bah, we're accidentally dropping the refcount on the directory one too 
> > many times, which is a different, though slightly related, problem to the 
> > one the previous patch fixed. 
> > 
> > Please try this patch (after removing the previous one).
> 
> That looks like it fixed it.

I've been unable to reproduce my sysfs/ppp BUG with this 
patch applied. Magic.

Thank you!

--Craig
