Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266146AbUGJGAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266146AbUGJGAM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 02:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266149AbUGJGAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 02:00:12 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:24763 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S266146AbUGJGAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 02:00:04 -0400
From: jmerkey@comcast.net
To: Hans Reiser <reiser@namesys.com>
Cc: Pete Harlan <harlan@artselect.com>, linux-kernel@vger.kernel.org
Subject: Re: Ext3 File System "Too many files" with snort
Date: Sat, 10 Jul 2004 06:00:01 +0000
Message-Id: <071020040600.3803.40EF85E1000853B300000EDB2200762194970A059D0A0306@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Jun 24 2004)
X-Authenticated-Sender: am1lcmtleUBjb21jYXN0Lm5ldA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




> >NetWare has always supported more than this, so this whole idea of fixed inode 
> tables 
> >is somewhat strange to me to start with.  I am still looking through Hans code, 
> but if 
> >this is accurate I'll just take a system out Monday and see if it works.  My 
> only concern 
> >with Reiser has to do with the bug reports I've seen on it over the years, but 
> Suse is 
> >shipping it as default, and we have been running it here for about a year on a 
> production 
> >server.  I'll post if it crashes, corrupts data, or has problems.  
> >
> >Jeff
> >
> >
> Don't use it on redhat systems, those bug reports tend to be for redhat 
> kernels, redhat refuses to apply our bugfixes that we send in to the 
> official kernel because they want us to look bad.  I sound so paranoid 
> when I say that, but they really do refuse to apply our bugfixes.

Not nice at all to not post updates.  They don't respond to email much either.   

> 
> ReiserFS V3 has been very stable for quite some time in 2.4.x.  There 
> were some instabilities recently in some versions of 2.6.x due to code 
> changes not by our team. sigh....
> 
> We at Namesys are much more conservative in code changes for V3 than 
> ext*.  I can't control some of the changes by SuSE though that have 
> added some bugs that could have been caught by more serious QA.  (SuSE 
> adheres to the usual linux lack of QA approach, it is not that they are 
> bad, but that they conform to the social norm for linux.)  Hopefully I 
> will have more control over that in V4.

We are using Suse for appliance builds for customer shipments.  More stable, 
more features, better quality.  I will be using Suse for the site with Reiser 
Monday.  So far looks good.  Builds finished tonight on 2.6 and running stable.

I will post a report of any problems at the site with Reiser.  From initial tests, looks
fixed.

:-)

> 
> Hans

