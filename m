Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261625AbVFUEo4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbVFUEo4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 00:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261574AbVFTW5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 18:57:23 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:53000 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S262295AbVFTWVE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:21:04 -0400
Date: Tue, 21 Jun 2005 00:26:18 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: Re: 2.6.12 udev hangs at boot
Message-ID: <20050620222618.GA20058@irc.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	trivial@rustcorp.com.au
References: <20050620164800.GA14798@suse.de> <Pine.LNX.4.21.0506201723090.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0506201723090.30848-100000@iabervon.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2005 at 05:26:46PM -0400, Daniel Barkalow wrote:
> On Mon, 20 Jun 2005, Greg KH wrote:
> 
> > On Mon, Jun 20, 2005 at 01:04:10PM +0300, Denis Vlasenko wrote:
> > > 
> > > Greg, any plans to distribute udev and hotplug within kernel tarballs
> > > so that people do not need to track such changes continuously?
> > 
> > Nope.  But if you use udev, you should read the announcements for new
> > releases, as I did say this was required for 2.6.12, and gave everyone a
> > number of weeks notice :)
> 
> Shouldn't this be listed in Changes? It looks like Changes only mentions
> the existance of udev, but doesn't specify a required version, despite
> there being a version requirement.

 Probably.

 Add udev version requirement to Changes files.

Signed-off-by: Tomasz Torcz <zdzichu@irc.pl>

--- linux-2.6.12/Documentation/Changes  2005-05-07 10:56:52.000000000 +0200
+++ linux-fixed/Documentation/Changes   2005-06-21 00:19:58.000000000 +0200
@@ -64,6 +64,7 @@ o  isdn4k-utils           3.1pre1       
 o  nfs-utils              1.0.5                   # showmount --version
 o  procps                 3.2.0                   # ps --version
 o  oprofile               0.5.3                   # oprofiled --version
+o  udev                   058                     # udevinfo -V
 
 Kernel compilation
 ==================


-- 
Tomasz Torcz                 Morality must always be based on practicality.
zdzichu@irc.-nie.spam-.pl                -- Baron Vladimir Harkonnen

