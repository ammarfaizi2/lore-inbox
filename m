Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264679AbTGBWne (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 18:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264740AbTGBWne
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 18:43:34 -0400
Received: from hera.cwi.nl ([192.16.191.8]:45256 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S264679AbTGBWnc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 18:43:32 -0400
From: Andries.Brouwer@cwi.nl
Date: Thu, 3 Jul 2003 00:57:54 +0200 (MEST)
Message-Id: <UTC200307022257.h62Mvsl26040.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, akpm@digeo.com
Subject: Re: [PATCH] cryptoloop
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From Andrew.Morton@digeo.com  Wed Jul  2 23:36:40 2003

    > Now suppose one wants a large dev_t. Some people do.

    <thumps table> 2.6 will support a large dev_t.

    We need to make this happen.

Very well.

    > Then several steps are needed. One of these steps
    > is the addition of the mknod64 system call.
    > That is a nice small isolated step - part of the necessary
    > user space interface. It can be done independently of any
    > other steps. It was submitted, but is not in the present
    > kernel. Why not? I do not recall anybody pointing out problems.

    This precisely illustrates my point.

    mknod64() and several other dev_t patches (ext2 and ext3 support,
    especially) have stalled in -mm for months.  The reason why I have not
    moved ahead with them is that I am waiting to see the rest of the work.

That is what they call a deadlock.
You asked a few times what parts could be submitted and I answered.

    Because it could be that Al has different ideas, or that someone else gets
    down and completes the work and wants to do it differently.  I simply do
    not know.

Neither do I. I just wait and see.

Andries
