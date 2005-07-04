Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261521AbVGDTJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbVGDTJR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 15:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbVGDTJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 15:09:17 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:2707 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261521AbVGDTJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 15:09:15 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Mon, 4 Jul 2005 20:09:11 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Daniel Drake <dsd@gentoo.org>
cc: =?UTF-8?B?RGF2aWQgR8OzbWV6?= <david@pleyades.net>,
       Robert Love <rml@novell.com>, John McCutchan <ttb@tentacle.dhs.org>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem with inotify
In-Reply-To: <42C9788F.50205@gentoo.org>
Message-ID: <Pine.LNX.4.60.0507042008310.7572@hermes-1.csi.cam.ac.uk>
References: <20050630181824.GA1058@fargo> <1120156188.6745.103.camel@betsy>
  <20050630193320.GA1136@fargo>  <Pine.LNX.4.60.0506302138230.29755@hermes-1.csi.cam.ac.uk>
  <20050630204832.GA3854@fargo>  <Pine.LNX.4.60.0506302158190.29755@hermes-1.csi.cam.ac.uk>
  <42C65A8B.9060705@gentoo.org>  <Pine.LNX.4.60.0507022253080.30401@hermes-1.csi.cam.ac.uk>
  <42C72563.7040103@gentoo.org>  <Pine.LNX.4.60.0507030053040.15398@hermes-1.csi.cam.ac.uk>
  <42C7BF37.9010005@gentoo.org> <1120487242.11399.5.camel@imp.csi.cam.ac.uk>
 <42C9788F.50205@gentoo.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Jul 2005, Daniel Drake wrote:
> Anton Altaparmakov wrote:
> > )-:  I have addressed the only things I can think off that could cause
> > the oops and below is the resulting patch.  Could you please test it?
> 
> Yeah!! After removing I_WILL_FREE stuff, that fixed both the oops *and* the
> hang. Everything works nicely now.

Great!  Thanks a lot for testing!  I will send a patch to Robert and 
Andrew in a minute with more comments added.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
