Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317101AbSEXLgF>; Fri, 24 May 2002 07:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317123AbSEXLgE>; Fri, 24 May 2002 07:36:04 -0400
Received: from imladris.infradead.org ([194.205.184.45]:1287 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S317101AbSEXLgE>; Fri, 24 May 2002 07:36:04 -0400
Date: Fri, 24 May 2002 12:35:35 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ed Tomlinson <tomlins@cam.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH] using page aging to shrink caches (pre8-ac5)
Message-ID: <20020524123535.A9618@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ed Tomlinson <tomlins@cam.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
In-Reply-To: <200205180010.51382.tomlins@cam.org> <20020521144759.B1153@redhat.com> <200205240728.45558.tomlins@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2002 at 07:28:45AM -0400, Ed Tomlinson wrote:
> Comments, questions and feedback very welcome,

Just from a short look:

What about doing mark_page_accessed in kmem_touch_page?
And please do a s/pruner_t/kmem_pruner_t/

