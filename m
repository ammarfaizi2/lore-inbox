Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751582AbVJMPSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582AbVJMPSr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 11:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751583AbVJMPSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 11:18:47 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:47768 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751581AbVJMPSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 11:18:46 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: Re: Linux NTFS Vista compatibility (was: Re: [2.6-GIT] NTFS:
	Release 2.1.24.)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Szakacsits Szabolcs <szaka@sienet.hu>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
In-Reply-To: <200510131613.43578.s0348365@sms.ed.ac.uk>
References: <Pine.LNX.4.21.0509252047090.21817-100000@mlf.linux.rulez.org>
	 <200509252335.37780.s0348365@sms.ed.ac.uk>
	 <200510131613.43578.s0348365@sms.ed.ac.uk>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Thu, 13 Oct 2005 16:18:30 +0100
Message-Id: <1129216711.5293.48.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-10-13 at 16:13 +0100, Alistair John Strachan wrote:
> On Sunday 25 September 2005 23:35, Alistair John Strachan wrote:
> [snip]
> > >
> > > Alistair, any result?
> > >
> > > > Note you will need to try the ntfs driver itself and not ntfscp as
> > > > libntfs does not have these changes yet hence ntfscp will not work just
> > > > the same (it does not use the kernel driver at all, it only uses
> > > > libntfs).
> > >
> > > The latest ntfsprogs CVS has also these changes and every tool should
> > > work fine with Vista (ntfscp, ntfsresize, ntfsundelete, ntfsclone, etc).
> >
> > I have limited access to the beta, as it expires every 30 days and forces
> > me to reinstall it. I promise to get back to all of you after 2.6.14 is
> > released with the LogFile changes.
> >
> > To clarify, I did not leave the Vista NTFS volume in an inconsistent state.
> > I even forced a chkdsk, rebooted, let it run through, then attempted again
> > to mount it with the NTFS code in 2.6.13. This categorically fails.
> 
> I was free today, so I built a 2.6.14-rc4 kernel on the machine with the 
> Longhorn NTFS volume. It now mounts without warnings in dmesg, and I've 
> verified that ntfscp works properly.

Great!  Thanks for letting us know!

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

