Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129836AbRBVCFu>; Wed, 21 Feb 2001 21:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130127AbRBVCFk>; Wed, 21 Feb 2001 21:05:40 -0500
Received: from asbestos.linuxcare.com.au ([203.17.0.30]:15099 "EHLO halfway")
	by vger.kernel.org with ESMTP id <S129836AbRBVCFW>;
	Wed, 21 Feb 2001 21:05:22 -0500
From: Rusty Russell <rusty@linuxcare.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: prumpf@mandrakesoft.com (Philipp Rumpf), linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.1-ac15 
In-Reply-To: Your message of "Wed, 21 Feb 2001 12:01:26 BST."
             <E14VXxY-0001wy-00@the-village.bc.nu> 
Date: Thu, 22 Feb 2001 13:05:04 +1100
Message-Id: <E14Vl7y-0001FG-00@halfway>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <E14VXxY-0001wy-00@the-village.bc.nu> you write:
> > This is a while back, but I thought the solution Philipp and I came up
> > with was to simply used a rw semaphore for this, which was taken (read
> > only) on page fault if we have to scan the exception table.
> 
> We can take page faults in interrupt handlers in 2.4 so I had to use a 
> spinlock, but that sounds the same

We can?  Woah, please explain.

Rusty.
--
Premature optmztion is rt of all evl. --DK
