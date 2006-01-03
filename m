Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932356AbWACRyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbWACRyv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 12:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbWACRyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 12:54:51 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:23608 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932356AbWACRys convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 12:54:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hRkzpsy8TjG4KXkD6Q2DN6vNoqQpMw8CH1h/c5fSq+SmCxNazWgaNBORB+8066GwP1J2hXU8G8n6/pq0jhTBYkTaoScGNgRlMjzA/dlS+646E/mGYa49VkDItxKEPHWFCAHg0NE+KFAVlkex5vu0znadtRba/aRClNWdynlDoMs=
Message-ID: <2ff216280601030954o3d2af726y6f564e7ae6d38a@mail.gmail.com>
Date: Tue, 3 Jan 2006 23:24:47 +0530
From: Abhijit Bhopatkar <bainonline@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 0/9] mutex subsystem, -V4
Cc: Nicolas Pitre <nico@cam.org>, hch@infradead.org, alan@lxorguk.ukuu.org.uk,
       arjan@infradead.org, mingo@elte.hu, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, arjanv@infradead.org, jes@trained-monkey.org,
       zwane@arm.linux.org.uk, oleg@tv-sign.ru, dhowells@redhat.com,
       bcrl@kvack.org, rostedt@goodmis.org, ak@suse.de,
       rmk+lkml@arm.linux.org.uk
In-Reply-To: <20051223065118.95738acc.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051222114147.GA18878@elte.hu>
	 <20051222050701.41b308f9.akpm@osdl.org>
	 <1135257829.2940.19.camel@laptopd505.fenrus.org>
	 <20051222054413.c1789c43.akpm@osdl.org>
	 <1135260709.10383.42.camel@localhost.localdomain>
	 <20051222153014.22f07e60.akpm@osdl.org>
	 <20051222233416.GA14182@infradead.org>
	 <20051222221311.2f6056ec.akpm@osdl.org>
	 <Pine.LNX.4.64.0512230912220.26663@localhost.localdomain>
	 <20051223065118.95738acc.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > How can't you get the fact that semaphores could _never_ be as simple as
> > mutexes?  This is a theoritical impossibility, which maybe turns out not
> > to be so true on x86, but which is damn true on ARM where the fast path
> > (the common case of a mutex) is significantly more efficient.
> >
>
> I did notice your comments.  I'll grant that mutexes will save some tens  of
> fastpath cycles on one minor architecture.  Sorry, but that doesn't seem
> very important.

Heh !! i can't find words so i will just spell the emotion....
COMPLAIN HARD
