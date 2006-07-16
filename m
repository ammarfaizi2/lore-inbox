Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbWGPRqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWGPRqn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 13:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbWGPRqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 13:46:43 -0400
Received: from tallyho.bytemark.co.uk ([80.68.81.166]:14809 "EHLO
	tallyho.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S1750767AbWGPRqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 13:46:42 -0400
Date: Sun, 16 Jul 2006 18:46:37 +0100
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: linux-kernel@vger.kernel.org
Subject: Re: reiserFS?
Message-ID: <20060716174636.GA3615@gallifrey>
References: <20060716161631.GA29437@httrack.com> <20060716162831.GB22562@zeus.uziel.local> <20060716165648.GB6643@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060716165648.GB6643@thunk.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.4.32 (i686)
X-Uptime: 18:40:14 up 68 days,  6:52,  2 users,  load average: 0.00, 0.09, 0.10
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is a sad reflection that we have these regular 'fs wars'; and that
most of them are driven by peoples bad experiences with particular
filesystems.

That leads me to ask what level of testing is performed on each
filesystem - are there filesystem torture tests that are getting
run by someone (who?) on various filesystems (preferably on large
TB sized ones, preferably with simulated failures and resets)?
The discussions on Ext4 a few weeks ago made me think that the
thing I'd value more than anything else would be a damn good
test regime.

It would be much nicer if the fs wars came down to peoples
particularly good experiences with filesystems rather than people
selecting file systems based on which one has lost them data most
rarely.

Dave

P.S. For the record I use Reiser for large (>500GB) fs since 
I couldn't get Ext3 stable on one a year or so ago and xfs failed
the 'recover from hitting reset' test.   A couple of years
ago I wouldn't touch Reiser because of NFS issues, but it seems
to have grown out of that.
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
