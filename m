Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266301AbUBLHqR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 02:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266298AbUBLHqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 02:46:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:56779 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266301AbUBLHqP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 02:46:15 -0500
Date: Wed, 11 Feb 2004 23:46:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, chris@k-rad.org
Subject: Re: Problem with 3c59x, WOL and Intel 440LX/EX or 430TX
Message-Id: <20040211234622.4a5bce7a.akpm@osdl.org>
In-Reply-To: <20040211170727.GC18571@smtp.west.cox.net>
References: <20040211170727.GC18571@smtp.west.cox.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini <trini@kernel.crashing.org> wrote:
>
> Hello.  I believe I have tracked down a problem with the WOL support in
>  the 3c59x driver (2.6 varriant only right now).  The problem has been
>  seen I belive by a few people:
>  (my own reports)
>  http://marc.theaimsgroup.com/?l=linux-kernel&m=106297008218993&w=2
>  http://lkml.org/lkml/2003/9/2/167

I have a suspicion that this may be a bug in the driver's PM handling but I
don't really have time to reacquaint myself with the driver.  Or it could
be a BIOS bug.

I've put the enable_wol module parameter back.
