Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbWDUQtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbWDUQtM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 12:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbWDUQtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 12:49:12 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:51146 "EHLO
	palinux.external.hp.com") by vger.kernel.org with ESMTP
	id S932069AbWDUQtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 12:49:11 -0400
Date: Fri, 21 Apr 2006 10:49:10 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Adrian Bunk <bunk@stusta.de>
Cc: Steven Whitehouse <swhiteho@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/16] GFS2: Makefiles and Kconfig
Message-ID: <20060421164910.GV24104@parisc-linux.org>
References: <1145636558.3856.118.camel@quoit.chygwyn.com> <20060421164309.GE19754@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060421164309.GE19754@stusta.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2006 at 06:43:09PM +0200, Adrian Bunk wrote:
> > --- /dev/null
> > +++ b/fs/gfs2/Kconfig
> > @@ -0,0 +1,46 @@
> > +config GFS2_FS
> > +        tristate "GFS2 file system support"
> > +	default m
> > +	depends on EXPERIMENTAL
> > +        select FS_POSIX_ACL
> > +        select SYSFS
> >...
> 
> - "depends on SYSFS" instead of the select

Why?  It's more natural to select it rather than depend on it.
