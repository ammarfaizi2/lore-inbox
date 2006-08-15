Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbWHOV1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWHOV1U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 17:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbWHOV1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 17:27:20 -0400
Received: from xenotime.net ([66.160.160.81]:29830 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750724AbWHOV1T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 17:27:19 -0400
Message-Id: <1155677232.11401@shark.he.net>
Date: Tue, 15 Aug 2006 14:27:12 -0700
From: "Randy Dunlap" <rdunlap@xenotime.net>
To: Pavel Machek <pavel@suse.cz>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Alex Tomas <alex@clusterfs.com>, Andrew Morton <akpm@osdl.org>,
       cmm@us.ibm.com, linux-fsdevel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [PATCH 1/9] extents for ext4
X-Mailer: WebMail 1.25
X-IPAddress: 216.4.146.131
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> Hi!
> 
> > >  AM> - The existing comments could benefit from some rework by a
> > >  AM> native English speaker.
> > > 
> > > could someone assist here, please?
> > 
> > See if this helps.
> > Patch applies on top of all ext4 patches from
> > http://ext2.sourceforge.net/48bitext3/patches/latest/.
> 
> > --- linux-2618-rc4-ext4.orig/include/linux/ext4_fs_extents.h
> > +++ linux-2618-rc4-ext4/include/linux/ext4_fs_extents.h
> > @@ -22,29 +22,29 @@
> >  #include <linux/ext4_fs.h>
> >  
> >  /*
> > - * with AGRESSIVE_TEST defined capacity of index/leaf blocks
> > - * become very little, so index split, in-depth growing and
> > - * other hard changes happens much more often
> > - * this is for debug purposes only
> > + * With AGRESSIVE_TEST defined, the capacity of index/leaf blocks
> > + * becomes very small, so index split, in-depth growing and
> > + * other hard changes happen much more often.
> > + * This is for debug purposes only.
> >   */
> >  #define AGRESSIVE_TEST_
> 
> Using _ for disabling is unusual/nasty. Can't we simply #undef it?

Yes, that's the right thing to do.
The ext4dev people should do that. :)

---
~Randy
