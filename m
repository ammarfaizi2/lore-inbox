Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932285AbWHAIxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbWHAIxi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 04:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbWHAIxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 04:53:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2753 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932285AbWHAIxh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 04:53:37 -0400
Date: Tue, 1 Aug 2006 01:53:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@muc.de>
Cc: samel@mail.cz, linux-kernel@vger.kernel.org
Subject: Re: too low MAX_MP_BUSSES
Message-Id: <20060801015329.9ffa5b86.akpm@osdl.org>
In-Reply-To: <20060801084637.GB21698@muc.de>
References: <20060731115545.GA3292@pc11.op.pod.cz>
	<20060801013826.09c9324d.akpm@osdl.org>
	<20060801084637.GB21698@muc.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 Aug 2006 10:46:37 +0200
Andi Kleen <ak@muc.de> wrote:

> > mach-default uses 32 and mach-generic uses 260, so I doubt if there's a big
> > downside to increasing mach-default.  I expect distros ship with
> > mach-generic, so you're a rare case.
> > 
> > <tries to remember who works on this and fails>
> > 
> > Andi?  Can you see any problems with increasing the mach-default setting?
> 
> No, except for wasting a bit of memory (maybe make it dependent on CONFIG_TINY?)

Sounds sane, thanks.  I'll do a patch.
