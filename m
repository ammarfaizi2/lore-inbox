Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262606AbUERADA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262606AbUERADA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 20:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262605AbUERAC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 20:02:59 -0400
Received: from cantor.suse.de ([195.135.220.2]:34441 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262585AbUERACv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 20:02:51 -0400
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s &&
	s->tree' failed: The saga continues.)
From: Chris Mason <mason@suse.com>
To: Steven Cole <elenstev@mesatop.com>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, lm@bitmover.com,
       wli@holomorphy.com, hugh@veritas.com, adi@bitmover.com,
       support@bitmover.com, linux-kernel@vger.kernel.org
In-Reply-To: <200405171752.08400.elenstev@mesatop.com>
References: <200405132232.01484.elenstev@mesatop.com>
	 <1084828124.26340.22.camel@spc0.esa.lanl.gov>
	 <20040517142946.571a3e91.akpm@osdl.org>
	 <200405171752.08400.elenstev@mesatop.com>
Content-Type: text/plain
Message-Id: <1084838627.20437.612.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 17 May 2004 20:03:47 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-05-17 at 19:52, Steven Cole wrote:
>  
> OK, applied your one-liner above with PREEMPT.
> Found null start 0xfb259a end 0xfb3000 len 0xa66 line 478846
> 
> The above was on reiserfs and happened on the very first pull.
> 
His one liner won't change any reiserfs code paths.  If you're testing
on ext3, now, just keep going there.

-chris


