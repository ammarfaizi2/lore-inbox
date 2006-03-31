Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbWCaNbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbWCaNbM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 08:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbWCaNbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 08:31:12 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:2906 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932105AbWCaNbL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 08:31:11 -0500
Date: Fri, 31 Mar 2006 15:31:12 +0200
From: Jens Axboe <axboe@suse.de>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] splice exports
Message-ID: <20060331133111.GX14022@suse.de>
References: <20060331040613.GA23511@havoc.gtf.org> <20060331132856.GA12208@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060331132856.GA12208@mars.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31 2006, Sam Ravnborg wrote:
> On Thu, Mar 30, 2006 at 11:06:13PM -0500, Jeff Garzik wrote:
>   /*
> >   * Passed to the actors
> > @@ -567,6 +568,9 @@ ssize_t generic_splice_sendpage(struct i
> >  	return move_from_pipe(inode, out, len, flags, pipe_to_sendpage);
> >  }
> >  
> > +EXPORT_SYMBOL(generic_file_splice_write);
> > +EXPORT_SYMBOL(generic_file_splice_read);
> Can we please have them right after the closing brace of the function
> defining these function instead.

http://brick.kernel.dk/git/?p=linux-2.6-block.git;a=commitdiff;h=ef9f6c8461ec21ab5ce02890e1d522e300e2703e

-- 
Jens Axboe

