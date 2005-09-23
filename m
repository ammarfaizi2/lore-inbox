Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751154AbVIWSwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbVIWSwl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 14:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbVIWSwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 14:52:41 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:61832 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751154AbVIWSwk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 14:52:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BNv2ZQcHjcj8td3xueYRnBh2nQYSPg1rre8Gke+P0MAevlOeZd7DojdXKUMg+FNi8lMfC3GFtMXX+kd9/CLUw/OqGj6QZSDJ2TxALWoQ8L0if2mzboq2or7naQww+b4UKGV5s5NCyiZCIBXX/3pK/hR0UxLY1IywJ3FRkCYOOXo=
Message-ID: <1e62d1370509231152ac90f99@mail.gmail.com>
Date: Fri, 23 Sep 2005 23:52:37 +0500
From: Fawad Lateef <fawadlateef@gmail.com>
Reply-To: Fawad Lateef <fawadlateef@gmail.com>
To: Jens Axboe <axboe@suse.de>
Subject: Re: Trapping Block I/O
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050923184342.GJ22655@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <64c7635405092305433356bd17@mail.gmail.com>
	 <1e62d137050923103843058e92@mail.gmail.com>
	 <20050923180407.GG22655@suse.de>
	 <1e62d137050923111046d0b762@mail.gmail.com>
	 <20050923181435.GI22655@suse.de>
	 <1e62d13705092311306853e7d0@mail.gmail.com>
	 <20050923184342.GJ22655@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/05, Jens Axboe <axboe@suse.de> wrote:
> > Ya, I looked at it and its looking very good tool to tracing block I/O
> > layer, but this tracing requires recompilation of the kernel and have
> > to use on kernel directly from kernel.org but its not a big deal, I
> > hope it will get into the main kernel soon ....
>
> That is true, I plan on submitting it for 2.6.15. The goal was to get
> relayfs pushed in first and that did happen for 2.6.14.
>

That will be nice ....

>
> There are certainly a lot of ways to get the data out to user space, by
> far the bulk of the code is in the monitoring application. blktrace
> should be pretty fast though, one of the goals was to make sure it would
> be very light weight on the kernel side (which it is) and very fast on
> getting the data out (also achieved, relayfs works very well). The
> xprobe approach does have certain advantages, the main one being that
> you can easily modify it.
>

I will test/use it soon and will let you know if find any bug/problem :)


--
Fawad Lateef
