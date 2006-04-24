Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751342AbWDXWjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbWDXWjy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 18:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbWDXWjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 18:39:54 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:13579 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751342AbWDXWjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 18:39:53 -0400
Date: Tue, 25 Apr 2006 00:39:44 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>, Martin Mares <mj@ucw.cz>,
       Gary Poppitz <poppitzg@iomega.com>, linux-kernel@vger.kernel.org
Subject: Re: C++ pushback
Message-ID: <20060424223943.GC13027@w.ods.org>
References: <4024F493-F668-4F03-9EB7-B334F312A558@iomega.com> <mj+md-20060424.201044.18351.atrey@ucw.cz> <444D44F2.8090300@wolfmountaingroup.com> <1145915533.1635.60.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145915533.1635.60.camel@localhost.localdomain>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2006 at 10:52:12PM +0100, Alan Cox wrote:
> On Llu, 2006-04-24 at 15:36 -0600, Jeff V. Merkey wrote:
> > C++ in the kernel is a BAD IDEA. C++ code can be written in such a 
> > convoluted manner as to be unmaintainable and unreadable.
> 
> So can C. 
> 
> > All of the hidden memory allocations from constructor/destructor 
> > operatings can and do KILL OS PERFORMANCE. 
> 
> This is one area of concern. Just as big a problem for the OS case is
> that the hidden constructors/destructors may fail. You can write C++
> code carefully to avoid these things but it can be hard to see where the
> problem is when you miss one.

Not counting the compiler bugs. When you see how the kernel tends to
trigger gcc bugs on which people spend a lot of time, I wouldn't want
to be the guy trying to identify bad code generation in C++...

Cheers,
Willy

