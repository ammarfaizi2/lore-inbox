Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261481AbVGEH6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261481AbVGEH6i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 03:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbVGEH6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 03:58:38 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:44258 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261752AbVGEH4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 03:56:18 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Tue, 5 Jul 2005 08:56:15 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: John McCutchan <ttb@tentacle.dhs.org>
cc: Daniel Drake <dsd@gentoo.org>,
       David =?ISO-8859-1?Q?G=F3mez?= <david@pleyades.net>,
       Robert Love <rml@novell.com>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem with inotify
In-Reply-To: <1120527203.18268.2.camel@vertex>
Message-ID: <Pine.LNX.4.60.0507050855410.27724@hermes-1.csi.cam.ac.uk>
References: <20050630181824.GA1058@fargo> <1120156188.6745.103.camel@betsy>
  <20050630193320.GA1136@fargo>  <Pine.LNX.4.60.0506302138230.29755@hermes-1.csi.cam.ac.uk>
  <20050630204832.GA3854@fargo>  <Pine.LNX.4.60.0506302158190.29755@hermes-1.csi.cam.ac.uk>
  <42C65A8B.9060705@gentoo.org>  <Pine.LNX.4.60.0507022253080.30401@hermes-1.csi.cam.ac.uk>
  <42C72563.7040103@gentoo.org>  <Pine.LNX.4.60.0507030053040.15398@hermes-1.csi.cam.ac.uk>
  <42C7BF37.9010005@gentoo.org> <1120487242.11399.5.camel@imp.csi.cam.ac.uk>
  <42C9788F.50205@gentoo.org>  <Pine.LNX.4.60.0507042008310.7572@hermes-1.csi.cam.ac.uk>
 <1120527203.18268.2.camel@vertex>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Jul 2005, John McCutchan wrote:
> On Mon, 2005-07-04 at 20:09 +0100, Anton Altaparmakov wrote:
> > On Mon, 4 Jul 2005, Daniel Drake wrote:
> > > Anton Altaparmakov wrote:
> > > > )-:  I have addressed the only things I can think off that could cause
> > > > the oops and below is the resulting patch.  Could you please test it?
> > > 
> > > Yeah!! After removing I_WILL_FREE stuff, that fixed both the oops *and* the
> > > hang. Everything works nicely now.
> > 
> > Great!  Thanks a lot for testing!  I will send a patch to Robert and 
> > Andrew in a minute with more comments added.
> 
> Nice work, I am going to have a closer look at the patch soon. Could you
> post the final patch at http://bugzilla.kernel.org/show_bug.cgi?id=4796

Thanks.  Now done.  But I am not sure about the white space.  I can't get 
anything sensible out of IE on Mac OS 9 which I am on at the moment.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
