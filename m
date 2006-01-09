Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751241AbWAITfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbWAITfg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 14:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbWAITfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 14:35:36 -0500
Received: from ppsw-7.csi.cam.ac.uk ([131.111.8.137]:32986 "EHLO
	ppsw-7.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751241AbWAITfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 14:35:36 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Mon, 9 Jan 2006 19:35:26 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Lee Revell <rlrevell@joe-job.com>
cc: Olivier Galibert <galibert@pobox.com>, Oliver Neukum <oliver@neukum.org>,
       Bernd Petrovitsch <bernd@firmix.at>, Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Why the DOS has many ntfs read and write driver,but the linux
 can't for a long time
In-Reply-To: <1136827695.9957.73.camel@mindpipe>
Message-ID: <Pine.LNX.4.64.0601091933020.25320@hermes-2.csi.cam.ac.uk>
References: <5t06S-7nB-15@gated-at.bofh.it>  <1136824149.5785.75.camel@tara.firmix.at>
  <1136824880.9957.55.camel@mindpipe> <200601091753.36485.oliver@neukum.org>
  <20060109171411.GB67773@dspnet.fr.eu.org> <1136827695.9957.73.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jan 2006, Lee Revell wrote:
> On Mon, 2006-01-09 at 18:14 +0100, Olivier Galibert wrote:
> > On Mon, Jan 09, 2006 at 05:53:35PM +0100, Oliver Neukum wrote:
> > > Does the Windows Explorer draw icons based only on name and metadata?
> > 
> > >From what I can see it does icons on non-executable entirely based on
> > the extension and nothing else on the first pass.  Executables are
> > looked inside for an icon (and there seems to be cache effects at
> > times, especially visible on the desktop).  Then for images a second
> > pass generates icons depending on the contents (with, once again, a
> > cache hidden somewhere).
> > 
> > Not a bad strategy, too.  Doing a file(1) on everything can only be
> > slow given the random disk accesses it generates.  Maybe a file(1) as
> > a _second_ pass would work.
> 
> Gack, does Nautilus really do file(1) on everything?  That's unspeakably
> awful.

I believe it does a lot worse things.  It actually reads a picture file 
for example, then resizes the picture down to an icon sized one and then 
displays the icon, then on to the next file and for text files it 
displays the beginning of the text file in the icon, etc...  Totally 
unnecessary and brings total slowdown.  But of course as with Windows 
Explorer this is configurable and you can just use list view without 
icons...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
