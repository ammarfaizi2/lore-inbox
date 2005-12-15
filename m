Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750874AbVLOR7v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbVLOR7v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 12:59:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750875AbVLOR7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 12:59:51 -0500
Received: from sa3.bezeqint.net ([192.115.104.17]:44673 "EHLO sa3.bezeqint.net")
	by vger.kernel.org with ESMTP id S1750865AbVLOR7u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 12:59:50 -0500
From: Shlomi Fish <shlomif@iglu.org.il>
To: Nathan Scott <nathans@sgi.com>
Subject: Re: XFS Mount Hangs the Partition (on latest kernel + many old 2.6.x ones)
Date: Thu, 15 Dec 2005 19:53:16 +0200
User-Agent: KMail/1.8.2
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-xfs@oss.sgi.com
References: <200512071357.39121.shlomif@iglu.org.il> <20051208075512.F7282696@wobbly.melbourne.sgi.com> <200512081755.58078.shlomif@iglu.org.il>
In-Reply-To: <200512081755.58078.shlomif@iglu.org.il>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512151953.16931.shlomif@iglu.org.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to myself, I'd like to ask for a response to my previous message, 
especially the order in which the operations Mr. Scott mentioned need to be 
performed.

Regards,

	Shlomi Fish

On Thursday 08 December 2005 17:55, Shlomi Fish wrote:
> On Wednesday 07 December 2005 22:55, Nathan Scott wrote:
> > On Wed, Dec 07, 2005 at 01:57:38PM +0200, Shlomi Fish wrote:
> > > Hi all!
> >
> > Hi there,
>
> Hi Mr. Scott (and all)!
>
> > > (Please CC me on replies)
> > >
> > > I encountered a problem with the Linux kernel handling of XFS, in which
> > > attempting to mount a certain XFS partition (but not a different one on
> > > the same hard-disk) caused the mount process to hang, and all other
> > > XFS-aware apps (like "xfs_check" or "xfs_repair") to hang too. However,
> > > running xfs_check
> > > or xfs_repair before the first mount (after a reboot) worked, and
> > > eventually resolved this problem.
> > >
> > > I blogged about it (relatively incoherently) here:
> > >
> > > http://www.livejournal.com/~shlomif/7182.html?mode=reply
> > > http://www.livejournal.com/~shlomif/7547.html?mode=reply
> >
> > Unfortunately there's not much information here in your mail or
> > there that would help us to analyse this further.  If you see this
> > behaviour again could you:
> > - get sysrq-t information for all hung processes, esp. mount;
> > - send xfs_info output for the filesystem in question;
> > - dump the log (xfs_logprint -C) and send it to us.
>
> Sure. But in what order should I do all that?

[SNIPPED]

---------------------------------------------------------------------
Shlomi Fish      shlomif@iglu.org.il
Homepage:        http://www.shlomifish.org/

95% of the programmers consider 95% of the code they did not write, in the
bottom 5%.
