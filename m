Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162446AbWLBMCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162446AbWLBMCp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 07:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423742AbWLBMCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 07:02:45 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:266 "EHLO spitz.ucw.cz")
	by vger.kernel.org with ESMTP id S1162446AbWLBMCo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 07:02:44 -0500
Date: Sat, 2 Dec 2006 11:40:17 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Russell Cattelan <cattelan@thebarn.com>
Cc: Al Viro <viro@ftp.linux.org.uk>, cluster-devel@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Cluster-devel] Re: [GFS2] Change argument of gfs2_dinode_out [17/70]
Message-ID: <20061202114016.GA4030@ucw.cz>
References: <1164888933.3752.338.camel@quoit.chygwyn.com> <1165000744.1194.89.camel@xenon.msp.redhat.com> <20061201192555.GD3078@ftp.linux.org.uk> <1165006331.1194.96.camel@xenon.msp.redhat.com> <20061201210849.GF3078@ftp.linux.org.uk> <1165015786.1194.133.camel@xenon.msp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1165015786.1194.133.camel@xenon.msp.redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > code clean up are not without risk and with no regression test suite to
> > > verify
> > > that a "cleanup" has not broken something. Cleanups are very much a
> > > hindrance to stabilization. With no know working points in a code
> > > history it becomes difficult
> > > to bisect changes and figure out when bugs were introduced
> > > Especially when cleanups are mixed in with bug fixes.
> > > 
> > > Pretty code does not equal correct code.
> > 
> > No, but convoluted and unreadable code ends up being crappier due
> > to lack of review.  And that's aside of the memory footprint,
> > likeliness of bugs introduced by code modifications (having in-core
> > and on-disk data structures with different contents and the same C
> > type => trouble that won't be caught by compiler), etc.
> 
> Nothing makes up for the complete lack of GFS2 testing.
> reviewed code does not equal correct code either.

Tested code does not equal correct code, either.

> gfs2 is supposed to be stabilized and use-able for the up coming rhel5
> release, not pretty up for somebody to print out and hang on their wall.

Feel free to keep rhel5 ugly, but we are talking mainline here.

							Pavel
-- 
Thanks for all the (sleeping) penguins.
