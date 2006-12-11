Return-Path: <linux-kernel-owner+w=401wt.eu-S1750744AbWLKXlJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbWLKXlJ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 18:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbWLKXlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 18:41:09 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:50027 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750744AbWLKXlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 18:41:07 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Neil Brown <neilb@suse.de>
Subject: Re: 2.6.19-mm1 (md/raid1 randomly drops partitions)
Date: Tue, 12 Dec 2006 00:43:22 +0100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20061211005807.f220b81c.akpm@osdl.org> <200612112341.42140.rjw@sisk.pl> <17789.57670.482913.886349@cse.unsw.edu.au>
In-Reply-To: <17789.57670.482913.886349@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612120043.22550.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 11 December 2006 23:52, Neil Brown wrote:
> On Monday December 11, rjw@sisk.pl wrote:
> > Hi,
> > 
> > On Monday, 11 December 2006 09:58, Andrew Morton wrote:
> > > 
> > > Temporarily at
> > > 
> > > 	http://userweb.kernel.org/~akpm/2.6.19-mm1/
> > > 
> > > Will appear later at
> > > 
> > > 	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19/2.6.19-mm1/
> > 
> > It caused all of the md RAID1s on my test box to drop one of their partitions,
> > apparently at random.
> 
> That's clever....
> 
> Do you have any kernel logs of this happening?  My guess would be the
> underlying device driver is returned more errors than before, but we
> need the logs to be sure.

I've only found lots of messages like this:

md: super_written gets error=-5, uptodate=0

I'll try to reproduce it tomorrow and collect some more information.

Greetings,
Rafael


-- 
If you don't have the time to read,
you don't have the time or the tools to write.
		- Stephen King
