Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317108AbSEXMVz>; Fri, 24 May 2002 08:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317132AbSEXMVy>; Fri, 24 May 2002 08:21:54 -0400
Received: from imladris.infradead.org ([194.205.184.45]:35335 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S317108AbSEXMVx>; Fri, 24 May 2002 08:21:53 -0400
Date: Fri, 24 May 2002 13:20:59 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ed Tomlinson <tomlins@cam.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH] using page aging to shrink caches (pre8-ac5)
Message-ID: <20020524132059.A11342@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ed Tomlinson <tomlins@cam.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
In-Reply-To: <200205180010.51382.tomlins@cam.org> <200205240728.45558.tomlins@cam.org> <20020524123535.A9618@infradead.org> <200205240814.25293.tomlins@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2002 at 08:14:25AM -0400, Ed Tomlinson wrote:
> On May 24, 2002 07:35 am, Christoph Hellwig wrote:
> > On Fri, May 24, 2002 at 07:28:45AM -0400, Ed Tomlinson wrote:
> > > Comments, questions and feedback very welcome,
> >
> > Just from a short look:
> >
> > What about doing mark_page_accessed in kmem_touch_page?
> 
> mark_page_accessed expects a page struct.  kmem_touch_page takes an
> address in the page, converts it to a kernel address and then marks the page.

Of course after the virt_to_page..

