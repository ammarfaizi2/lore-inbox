Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262605AbUERAMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbUERAMg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 20:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262744AbUERAMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 20:12:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:35717 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262605AbUERAM3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 20:12:29 -0400
Date: Mon, 17 May 2004 17:15:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chris Mason <mason@suse.com>
Cc: elenstev@mesatop.com, torvalds@osdl.org, lm@bitmover.com,
       wli@holomorphy.com, hugh@veritas.com, adi@bitmover.com,
       support@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s &&
 s->tree' failed: The saga continues.)
Message-Id: <20040517171502.352228b7.akpm@osdl.org>
In-Reply-To: <1084838627.20437.612.camel@watt.suse.com>
References: <200405132232.01484.elenstev@mesatop.com>
	<1084828124.26340.22.camel@spc0.esa.lanl.gov>
	<20040517142946.571a3e91.akpm@osdl.org>
	<200405171752.08400.elenstev@mesatop.com>
	<1084838627.20437.612.camel@watt.suse.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason <mason@suse.com> wrote:
>
> On Mon, 2004-05-17 at 19:52, Steven Cole wrote:
> >  
> > OK, applied your one-liner above with PREEMPT.
> > Found null start 0xfb259a end 0xfb3000 len 0xa66 line 478846
> > 
> > The above was on reiserfs and happened on the very first pull.
> > 
> His one liner won't change any reiserfs code paths.  If you're testing
> on ext3, now, just keep going there.
> 

Good point.
