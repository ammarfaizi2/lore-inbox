Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263415AbUDGBex (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 21:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263419AbUDGBex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 21:34:53 -0400
Received: from web40512.mail.yahoo.com ([66.218.78.129]:10637 "HELO
	web40512.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263415AbUDGBev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 21:34:51 -0400
Message-ID: <20040407013450.84365.qmail@web40512.mail.yahoo.com>
Date: Tue, 6 Apr 2004 18:34:50 -0700 (PDT)
From: Sergiy Lozovsky <serge_lozovsky@yahoo.com>
Subject: Re: kernel stack challenge 
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200404070102.i3712nDe002647@eeyore.valparaiso.cl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
> Sergiy Lozovsky <serge_lozovsky@yahoo.com> said:
> 
> Why do you think it has been 2 pages (8KiB) for as
> long as I remember
> (essentially forever in Linux), and it has taken a
> _lot_ of work to shrink
> it to 4KiB (- size of *current)?

I described the possible solution (virtual stack)
which can easily take care of this problem for some
subsystems, or am I wrong. If code doesn't allocate
big buffers in stack my solution can make conversion
of existing code possible without _lot_ of work. (I'm
lazy - remember :-)

What do you think about my solution? Despite some
additional overhead, but I don't think that it is
significant.

Serge.

__________________________________
Do you Yahoo!?
Yahoo! Small Business $15K Web Design Giveaway 
http://promotions.yahoo.com/design_giveaway/
