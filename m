Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264447AbRFOQlg>; Fri, 15 Jun 2001 12:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264446AbRFOQl2>; Fri, 15 Jun 2001 12:41:28 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:55718 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S264440AbRFOQlM>;
	Fri, 15 Jun 2001 12:41:12 -0400
Date: Fri, 15 Jun 2001 12:41:08 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Matthew Wilcox <matthew@wil.cx>
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [Final call for testers][PATCH] superblock handling changes
 (2.4.6-pre3)
In-Reply-To: <Pine.GSO.4.21.0106151221190.8909-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0106151237150.9091-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 15 Jun 2001, Alexander Viro wrote:

> > > +	list_add (&s->s_list, super_blocks.prev);
> > 
> > I'd use list_add_tail(&s->s_list, super_blocks);
> 
> Umm... Why? I've no problems with either variant, but I really see no
> clear win (or loss) in list_add_tail here. If there is some code that

OK, my fault - I shouldn't post before the first cup of coffee. Sorry -
I've missed the point here. Yes, list_add_tail() would be OK here.

