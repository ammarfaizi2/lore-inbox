Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbVIJNYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbVIJNYE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 09:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbVIJNYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 09:24:04 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:30695 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1750827AbVIJNYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 09:24:03 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Sat, 10 Sep 2005 14:23:58 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [2.6-GIT] NTFS: Release 2.1.24.
In-Reply-To: <200509101415.12039.s0348365@sms.ed.ac.uk>
Message-ID: <Pine.LNX.4.60.0509101421460.20200@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
 <200509101415.12039.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Sep 2005, Alistair John Strachan wrote:
> On Friday 09 September 2005 10:18, Anton Altaparmakov wrote:
> > Hi Linus, please pull from
> >
> > rsync://rsync.kernel.org/pub/scm/linux/kernel/git/aia21/ntfs-2.6.git/HEAD
> >
> > This is the next NTFS update containing a ton of bug fixes several of
> > which fix bugs people actually hit in the big bad world...
> >
> > Please apply.  Thanks!
> >
> > I am sending the changesets as actual patches generated using git
> > format-patch for non-git users in follow up emails (in reply to this one).
> 
> Do these changes allow us to mount an NTFS volume created by Windows 
> Vista/Longhorn beta 1 yet? I tried the driver in 2.6.13, and it complains 
> about these $LogFile states, and ntfscp refuses to work.
> 
> If you're unaware of the problem, I'm happy to help debug it.

I am indeed unaware of the problem.  Could you try the latest kernel with 
the ntfs patches in it (Linus already merged them in the official git 
tree) and tell me if it now works?  Thanks a lot in advance!

Note you will need to try the ntfs driver itself and not ntfscp as libntfs 
does not have these changes yet hence ntfscp will not work just the same 
(it does not use the kernel driver at all, it only uses libntfs).

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
