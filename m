Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265316AbUETXzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265316AbUETXzy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 19:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265323AbUETXzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 19:55:54 -0400
Received: from mail.autoweb.net ([198.172.237.26]:59908 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S265316AbUETXzv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 19:55:51 -0400
Date: Thu, 20 May 2004 19:54:38 -0400
From: Ryan Anderson <ryan@michonline.com>
To: Larry McVoy <lm@work.bitmover.com>,
       Davidlohr Bueso A <dbueso@linuxchile.cl>, linux-kernel@vger.kernel.org,
       '@ravnborg.org
Subject: Re: bk repository
Message-ID: <20040520235438.GB18544@michonline.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Davidlohr Bueso A <dbueso@linuxchile.cl>,
	linux-kernel@vger.kernel.org, '@ravnborg.org
References: <1085025662.1032.10.camel@offworld> <20040520073951.GA2210@mars.ravnborg.org> <20040520152543.GB10634@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040520152543.GB10634@work.bitmover.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2004 at 08:25:43AM -0700, Larry McVoy wrote:
> On Thu, May 20, 2004 at 09:39:51AM +0200, Sam Ravnborg wrote:
> > On Thu, May 20, 2004 at 12:01:02AM -0400, Davidlohr Bueso A wrote:
> > > When will the 2.6 branch be added to the bitkeeper resository?
> > It's alrweady there, but with a bit mis-leading name.
> > bk://linux.bkbits.net/linux-2.5

[...]

> > To my knowledge there is no possibility to symlink two repositories, so
> > both names could live in parrallel for a while??
> 
> Sure there is and it's done.
> 
> root@hostme:/repos/l/linux# ls -l
> total 20
> drwxrwxr-x   17 linux    1000         4096 May 20 05:29 linux-2.4
> drwxrwxr-x   20 linux    1000         4096 May 20 07:27 linux-2.5
> lrwxrwxrwx    1 root     root            9 May 20 08:24 linux-2.6 -> linux-2.5
> drwxrwxr-x   20 root     root         4096 May 10 17:40 lm
> drwxrwxr-x   16 linux    root         4096 Apr 16 23:43 vger
> drwxrwxr-x    5 linux.ad 1000         4096 Mar 28  2002 www

Wouldn't it make sense to avoid the need to do this in the future?

Specifically, make a tree named "linux" available - that's always the
Linus tree.

Create linux-2.6/2.8/3.0/3.2 etc as they are handed off to maintainers
*other* than Linus?

Or some combination that makes sense.  It just seems weird to me to need
to continually change the name of the main development tree.


-- 

Ryan Anderson
  sometimes Pug Majere
