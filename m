Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265132AbUETP0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265132AbUETP0A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 11:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265152AbUETPZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 11:25:59 -0400
Received: from ipcop.bitmover.com ([192.132.92.15]:35563 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S265132AbUETPZ6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 11:25:58 -0400
Date: Thu, 20 May 2004 08:25:43 -0700
From: Larry McVoy <lm@bitmover.com>
To: Davidlohr Bueso A <dbueso@linuxchile.cl>, linux-kernel@vger.kernel.org,
       '@ravnborg.org
Subject: Re: bk repository
Message-ID: <20040520152543.GB10634@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Davidlohr Bueso A <dbueso@linuxchile.cl>,
	linux-kernel@vger.kernel.org, '@ravnborg.org
References: <1085025662.1032.10.camel@offworld> <20040520073951.GA2210@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040520073951.GA2210@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2004 at 09:39:51AM +0200, Sam Ravnborg wrote:
> On Thu, May 20, 2004 at 12:01:02AM -0400, Davidlohr Bueso A wrote:
> > When will the 2.6 branch be added to the bitkeeper resository?
> It's alrweady there, but with a bit mis-leading name.
> bk://linux.bkbits.net/linux-2.5
> 
> To see the repository in your browser use:
> http://linux.bkbits.net and select the linux-2.5 repository.
> 
> The reason to keep the linux-2.5 name is simply that renaming the repository
> would cause parent information to be void for all people pulling
> from this directory.
> 
> To my knowledge there is no possibility to symlink two repositories, so
> both names could live in parrallel for a while??

Sure there is and it's done.

root@hostme:/repos/l/linux# ls -l
total 20
drwxrwxr-x   17 linux    1000         4096 May 20 05:29 linux-2.4
drwxrwxr-x   20 linux    1000         4096 May 20 07:27 linux-2.5
lrwxrwxrwx    1 root     root            9 May 20 08:24 linux-2.6 -> linux-2.5
drwxrwxr-x   20 root     root         4096 May 10 17:40 lm
drwxrwxr-x   16 linux    root         4096 Apr 16 23:43 vger
drwxrwxr-x    5 linux.ad 1000         4096 Mar 28  2002 www

-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
