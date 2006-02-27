Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751700AbWB0Ix6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751700AbWB0Ix6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 03:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751701AbWB0Ix5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 03:53:57 -0500
Received: from mx1.redhat.com ([66.187.233.31]:18914 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751697AbWB0Ix4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 03:53:56 -0500
Subject: Re: GFS2 Filesystem [13/16]
From: Steven Whitehouse <swhiteho@redhat.com>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060224223046.GS8083@ca-server1.us.oracle.com>
References: <1140793524.6400.734.camel@quoit.chygwyn.com>
	 <20060222185059.GC2633@ucw.cz>
	 <20060224223046.GS8083@ca-server1.us.oracle.com>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Mon, 27 Feb 2006 08:58:58 +0000
Message-Id: <1141030738.6400.788.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2006-02-24 at 14:30 -0800, Joel Becker wrote:
> On Wed, Feb 22, 2006 at 06:50:59PM +0000, Pavel Machek wrote:
> > > --- a/fs/Kconfig
> > > +++ b/fs/Kconfig
> > > @@ -883,8 +884,6 @@ config CONFIGFS_FS
> > >  	  Both sysfs and configfs can and should exist together on the
> > >  	  same system. One is not a replacement for the other.
> > >  
> > > -	  If unsure, say N.
> > > -
> > 
> > Why? Most users probably still want configfs_fs=N.
> 
> 	What version is this patch against?  This line was removed from
> mainline a while ago.
> 	As to why it was removed, the discussion happened back then.
> Basically, if something requires CONFIGFS_FS (eg, OCFS2) and is a
> module, then a user is asked whether they want configfs as a module or
> built-in.  Text saying "say N" is completely incorrect there.
> 
> Joel
> 
Checking the gfs2 git tree and Linus' tree again reveals that its not
something that we changed. I think I must have fed the wrong command to
git to produce the diff as the change is quite clearly there, exactly
same in both trees,

Steve.


