Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161140AbWAHCTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161140AbWAHCTR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 21:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161142AbWAHCTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 21:19:16 -0500
Received: from mail.kroah.org ([69.55.234.183]:12482 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161140AbWAHCTQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 21:19:16 -0500
Date: Sat, 7 Jan 2006 18:16:30 -0800
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Alessandro Suardi <alessandro.suardi@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-git2: CONFIGFS_FS shows up as M/y choice, help says "if unsure, say N"
Message-ID: <20060108021630.GA3771@kroah.com>
References: <5a4c581d0601061310j3f4eb310o1d68c0b87c278685@mail.gmail.com> <20060106223032.GZ18439@ca-server1.us.oracle.com> <20060107220959.GA3774@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060107220959.GA3774@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07, 2006 at 11:09:59PM +0100, Adrian Bunk wrote:
> On Fri, Jan 06, 2006 at 02:30:32PM -0800, Joel Becker wrote:
> > On Fri, Jan 06, 2006 at 10:10:13PM +0100, Alessandro Suardi wrote:
> > > If unsure, say N.
> > > ===========
> > > 
> > > I think I'll say M - for now ;)
> > 
> > 	If you choose something depending on CONFIGFS_FS, you of course
> > don't get the choice of 'N'.  Here's a cleanup also available at
> > http://oss.oracle.com/git/ocfs2-dev.git
> 
> I don't know whether I already asked this question (if I did it seems 
> I've forgotten the answer...):
> 
> Why is CONFIGFS_FS a user-visible option?

I think it should be the same as SYSFS, only changable from the EMBEDDED
portion.

thanks,

greg k-h
