Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264152AbTLEO1b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 09:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264229AbTLEO1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 09:27:31 -0500
Received: from purple.csi.cam.ac.uk ([131.111.8.4]:7857 "EHLO
	purple.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S264152AbTLEO1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 09:27:30 -0500
Subject: Re: Is there a "make hole" (truncate in middle) syscall?
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Andy Isaacson <adi@hexapodia.org>, Rob Landley <rob@landley.net>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20031205114400.GD10421@parcelfarce.linux.theplanet.co.uk>
References: <200312041432.23907.rob@landley.net>
	 <20031204172348.A14054@hexapodia.org>
	 <Pine.SOL.4.58.0312051119240.9902@green.csi.cam.ac.uk>
	 <20031205114400.GD10421@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Organization: University of Cambridge
Message-Id: <1070634436.6622.2.camel@imp>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 05 Dec 2003 14:27:16 +0000
Content-Transfer-Encoding: 7bit
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-12-05 at 11:44, viro@parcelfarce.linux.theplanet.co.uk
wrote:
> On Fri, Dec 05, 2003 at 11:22:01AM +0000, Anton Altaparmakov wrote:
> > On Thu, 4 Dec 2003, Andy Isaacson wrote:
> > > On Thu, Dec 04, 2003 at 02:32:23PM -0600, Rob Landley wrote:
> > > I'm curious -- does NTFS implement sparse files?  Does the Win32 API
> > > provide any way to manipulate them?  Does the NT kernel have any sparse
> > > file handling?
> > 
> > Yes it does.  The new NTFS Linux driver has full support for sparse files
> > as does Windows of course.
> > 
> > Windows does provide a function which is just "make hole".  It takes
> > starting offset and length (or was it ending offset instead of length,
> > can't remember) and makes this sparse (obviously aligning to cluster
> > boundaries, etc).
> 
> Have fun getting it to play nice with mmap()...

I have no intention to provide such "make hole" functionality in the
Linux kernel NTFS driver so I don't need to...  (-;

Cheers,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ &
http://www-stu.christs.cam.ac.uk/~aia21/

