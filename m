Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275806AbRJNRRW>; Sun, 14 Oct 2001 13:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275790AbRJNRRN>; Sun, 14 Oct 2001 13:17:13 -0400
Received: from cogito.cam.org ([198.168.100.2]:29190 "EHLO cogito.cam.org")
	by vger.kernel.org with ESMTP id <S275789AbRJNRQ4>;
	Sun, 14 Oct 2001 13:16:56 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@CAM.ORG>
Organization: me
To: Chris Mason <mason@suse.com>
Subject: Re: mount hanging 2.4.12
Date: Sun, 14 Oct 2001 10:23:58 -0400
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.GSO.4.21.0110140133580.3903-100000@weyl.math.psu.edu> <2101790000.1003067296@tiny>
In-Reply-To: <2101790000.1003067296@tiny>
Cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011014142359.727C324D52@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On October 14, 2001 09:48 am, you wrote:
> On Sunday, October 14, 2001 01:46:19 AM -0400 Alexander Viro
>
> <viro@math.psu.edu> wrote:
> > On Sun, 14 Oct 2001, Alexander Viro wrote:
> >> 	Deadlocks on lock_super().  I don't see any changes in that
> >> area, though...
> >
> > Erm, wait...  What patches do you have applied?  After a second look
> > at your objdump it seems that you've got spinlocks turned into
> > semaphores. What the hell is going on there?
>
> Ed, does this hang happen without the new reiserfs snapshot locking patch
> applied?

I have not tried it Chris,  Al seem puzzled about what was locking.
Then I remembers you seeming a little leary of using a sem in the vfs 
locking stuff...

I will backout the vfs locking stuff and see what happens.

Ed
