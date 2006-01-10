Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbWAJEIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbWAJEIN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 23:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbWAJEIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 23:08:13 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:9998 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751178AbWAJEIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 23:08:13 -0500
Date: Tue, 10 Jan 2006 05:08:11 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Greg KH <greg@kroah.com>
Cc: Alessandro Suardi <alessandro.suardi@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-git2: CONFIGFS_FS shows up as M/y choice, help says "if unsure, say N"
Message-ID: <20060110040811.GB3911@stusta.de>
References: <5a4c581d0601061310j3f4eb310o1d68c0b87c278685@mail.gmail.com> <20060106223032.GZ18439@ca-server1.us.oracle.com> <20060107220959.GA3774@stusta.de> <20060108021630.GA3771@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060108021630.GA3771@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07, 2006 at 06:16:30PM -0800, Greg KH wrote:
> On Sat, Jan 07, 2006 at 11:09:59PM +0100, Adrian Bunk wrote:
> > On Fri, Jan 06, 2006 at 02:30:32PM -0800, Joel Becker wrote:
> > > On Fri, Jan 06, 2006 at 10:10:13PM +0100, Alessandro Suardi wrote:
> > > > If unsure, say N.
> > > > ===========
> > > > 
> > > > I think I'll say M - for now ;)
> > > 
> > > 	If you choose something depending on CONFIGFS_FS, you of course
> > > don't get the choice of 'N'.  Here's a cleanup also available at
> > > http://oss.oracle.com/git/ocfs2-dev.git
> > 
> > I don't know whether I already asked this question (if I did it seems 
> > I've forgotten the answer...):
> > 
> > Why is CONFIGFS_FS a user-visible option?
> 
> I think it should be the same as SYSFS, only changable from the EMBEDDED
> portion.

No, my thoughts got in exactly the opposite direction:

It should not be available except when explicitely select'ed by a driver 
with support for it.

But I got the point that an option is required for stuff not yet merged 
into the kernel.

> thanks,
> 
> greg k-h

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

