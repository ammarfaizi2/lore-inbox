Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269690AbUICNg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269690AbUICNg2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 09:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269696AbUICNfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 09:35:51 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:5365 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S269690AbUICNfj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 09:35:39 -0400
Subject: Re: The argument for fs assistance in handling archives (was:
	silent semantic changes with reiser4)
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Spam <spam@tnonline.net>
Cc: Paul Jakma <paul@clubi.ie>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jamie Lokier <jamie@shareable.org>, Linus Torvalds <torvalds@osdl.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <642078516.20040903151619@tnonline.net>
References: <20040826150202.GE5733@mail.shareable.org>
	 <200408282314.i7SNErYv003270@localhost.localdomain>
	 <20040901200806.GC31934@mail.shareable.org>
	 <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org>
	 <1094118362.4847.23.camel@localhost.localdomain>
	 <20040902161130.GA24932@mail.shareable.org>
	 <Pine.LNX.4.61.0409030028510.23011@fogarty.jakma.org>
	 <1835526621.20040903014915@tnonline.net>
	 <1094165736.6170.19.camel@localhost.localdomain>
	 <32810200.20040903020308@tnonline.net>
	 <Pine.LNX.4.61.0409030112080.23011@fogarty.jakma.org>
	 <142794710.20040903023906@tnonline.net>
	 <1094216718.2679.30.camel@shaggy.austin.ibm.com>
	 <642078516.20040903151619@tnonline.net>
Content-Type: text/plain
Message-Id: <1094218380.2678.43.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 03 Sep 2004 08:33:00 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-03 at 08:16, Spam wrote:
> > You're missing the point.  We don't need transparency in all apps.  You
> > can write an application to be as transparent as you want, but you don't
> > need every app to to understand every file format.
> 
>   No, but not every user "can write an application" either, or even
>   have the skills to apply patches. What I was talking about wasn't
>   just tar, which itself isn't the best example anyway,

That was one of the examples you gave, that and .jpg.  I believe they
are both ridiculous.

>  but the idea
>   that users can load plugins that will extend the functionality of
>   their filesystems. That idea seem to be to be _much_ better than
>   trying to teach every user how to write applications or patch
>   existing ones.

If I understand Hans' plugins, they are not user-loadable, but rather a
statically built part of the kernel.

> 
>   No, but if I wanted to have an encryption plugin active for some of
>   my files or directories then why should I not be able to? I still
>   want to edit, view and save my encrypted files.

I would not argue against an encryption plugin.

>   Again, this was just an example of what could be done with plugins.
>   It is not said that every conceivable plugin will be written, nor
>   loaded per default.

This I agree with.

>  Even though plugins cannot today be dynamically
>   used, they will be eventually. Reiser4 is still very young.

As kernel modules, this would make sense.  I don't see just any
unprivileged user being able to add code into the file system, though.

>   Please separate your thoughts for specific plugins from those of the
>   idea to have plugins at all.

I'm not against reiser4 plugins.  I don't think file system code should
care about the type of data in a file, and do any interpretation based
on it.

Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

