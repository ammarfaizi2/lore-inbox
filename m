Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263676AbTFTRmg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 13:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263705AbTFTRmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 13:42:36 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:23408 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263676AbTFTRme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 13:42:34 -0400
Date: Fri, 20 Jun 2003 10:56:40 -0700
From: Andrew Morton <akpm@digeo.com>
To: Andi Kleen <ak@suse.de>
Cc: clemens-dated-1056963973.bf26@endorphin.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Initial Vector Fix for loop.c.
Message-Id: <20030620105640.10ab68a4.akpm@digeo.com>
In-Reply-To: <p73u1al3xlw.fsf@oldwotan.suse.de>
References: <20030620090612.GA1322@ghanima.endorphin.org.suse.lists.linux.kernel>
	<p73u1al3xlw.fsf@oldwotan.suse.de>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Jun 2003 17:56:35.0998 (UTC) FILETIME=[4A9BD3E0:01C33755]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> > So go for it. Fix it before 2.6.x is out and we're stuck with this crap
>  > again. 
> 
>  This will break existing crypto loop installations, making
>  the existing encrypted image unreadable.

I think we should just live with that breakage Andi.  You're suggesting
that we retain compatibility with something which was never merged into the
kernel.  That is asking too much.

I'd prefer to see a good, clean, solid implementation of cryptoloop. 
Presumably migration tools from old to new will turn up.


