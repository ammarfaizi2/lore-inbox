Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbVCCMA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbVCCMA7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 07:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbVCCLLB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 06:11:01 -0500
Received: from ppsw-2.csi.cam.ac.uk ([131.111.8.132]:16863 "EHLO
	ppsw-2.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261554AbVCCKuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 05:50:21 -0500
Date: Thu, 3 Mar 2005 10:49:37 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Jeff Garzik <jgarzik@pobox.com>, "David S. Miller" <davem@davemloft.net>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
In-Reply-To: <Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.60.0503031045580.26782@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
 <42264F6C.8030508@pobox.com> <20050302162312.06e22e70.akpm@osdl.org>
 <42265A6F.8030609@pobox.com> <20050302165830.0a74b85c.davem@davemloft.net>
 <422674A4.9080209@pobox.com> <Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2005, Linus Torvalds wrote:
> On Wed, 2 Mar 2005, Jeff Garzik wrote:
> > 
> > If we want a calming period, we need to do development like 2.4.x is 
> > done today.  It's sane, understandable and it works.
> 
> No. It's insane, and the only reason it works is that 2.4.x is a totally
> different animal. Namely it doesn't have the kind of active development AT
> ALL any more. It _only_ has the "even" number kind of things, and quite 
> frankly, even those are a lot less than 2.6.x has.
> 
> > 2.6.x-pre: bugfixes and features
> > 2.6.x-rc: bugfixes only
> 
> And the reason it does _not_ work is that all the people we want testing 
> sure as _hell_ won't be testing -rc versions.
> 
> That's the whole point here, at least to me. I want to have people test 
> things out, but it doesn't matter how many -rc kernels I'd do, it just 
> won't happen. It's not a "real release".
> 
> In contrast, making it a real release, and making it clear that it's a 
> release in its own right, might actually get people to use it. 
> 
> Might. Maybe.

I agree with you.  And I think it definitely would.  A lot of people just 
go to ftp.kernel.org and get the latest full release (heck a lot of 
compile your own kernel scripts I have seen do that).  They never read 
LKML or related lists, they just try the latest released kernel.  You 
would catch that whole group of people by turning -rc into 2.6.ODD.

And not to forget companies where senior management will refuse to run -rc 
because its a beta and beta is not good enough for company use.

Its the same as with companies refusing to run 0.x software.  In the end 
the software developers usually end up doing a 1.x release just _so_ it 
gets run by those companies.

I think the .EVEN and .ODD proposal would work a lot better than -rc ever 
would/could.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
