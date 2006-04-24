Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbWDXNQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWDXNQM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 09:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbWDXNQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 09:16:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33515 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750780AbWDXNQL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 09:16:11 -0400
Subject: Re: [PATCH 13/16] GFS2: Makefiles and Kconfig
From: Steven Whitehouse <swhiteho@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060421230035.GA11190@kroah.com>
References: <1145636558.3856.118.camel@quoit.chygwyn.com>
	 <20060421164309.GE19754@stusta.de>  <20060421230035.GA11190@kroah.com>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Mon, 24 Apr 2006 14:24:41 +0100
Message-Id: <1145885081.3856.143.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2006-04-21 at 16:00 -0700, Greg KH wrote:
> On Fri, Apr 21, 2006 at 06:43:09PM +0200, Adrian Bunk wrote:
> > > --- /dev/null
> > > +++ b/fs/gfs2/Kconfig
> > > @@ -0,0 +1,46 @@
> > > +config GFS2_FS
> > > +        tristate "GFS2 file system support"
> > > +	default m
> > > +	depends on EXPERIMENTAL
> > > +        select FS_POSIX_ACL
> > > +        select SYSFS
> > >...
> > 
> > - tabs <-> spaces (tabs are correct)
> > - please remove the "default m"
> > - "depends on SYSFS" instead of the select
> 
> Why do you depend on sysfs at all?  If it's not enabled, your code
> should still build just fine, right?  If not, please let us know and we
> will fix the build error in the sysfs.h header file.
> 
> thanks,
> 
> greg k-h

I've removed this dependency now. Thanks for pointing this out,

Steve.


