Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271111AbUJVK4C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271111AbUJVK4C (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 06:56:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271118AbUJVK4C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 06:56:02 -0400
Received: from fw.osdl.org ([65.172.181.6]:62685 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271111AbUJVKz4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 06:55:56 -0400
Date: Fri, 22 Oct 2004 03:54:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-mm1
Message-Id: <20041022035400.28131d76.akpm@osdl.org>
In-Reply-To: <20041022103910.GB17526@infradead.org>
References: <20041022032039.730eb226.akpm@osdl.org>
	<20041022103910.GB17526@infradead.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> >   - reiser4: not sure, really.  The namespace extensions were disabled,
> >     although all the code for that is still present.  Linus's filesystem
> >     criterion used to be "once lots of people are using it, preferably when
> >     vendors are shipping it".  That's a bit of a chicken and egg thing though.
> >     Needs more discussion.
> 
> Your tree also has various rejected core changes for it still.

Which were they?

> > +add-simple_alloc_dentry-to-libfs.patch
> > 
> >  Code refactoring
> 
> I think this should go into fs/dcache.c and be called something
> like d_alloc_name or similar.

Yup, I changed it to do that.

> > +hfs-export-type-creator-via-xattr.patch
> 
> I haven't heard an answer on the comments on this on on -fsdevel yet..

To use the generic xattr code?  Yes, we're waiting to hear back on that.

> > +make-__sigqueue_alloc-a-general-helper.patch
> > 
> >  posix timer code tweaks
> 
> Any reason it's marked inline now?

It isn't any more ;)
