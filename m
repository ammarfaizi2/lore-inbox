Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268321AbUH0Vkk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268321AbUH0Vkk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 17:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268335AbUH0Vj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 17:39:56 -0400
Received: from ppsw-3.csi.cam.ac.uk ([131.111.8.133]:60038 "EHLO
	ppsw-3.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S268634AbUH0Vgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 17:36:31 -0400
Date: Fri, 27 Aug 2004 22:36:29 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Xavier Bestel <xavier.bestel@free.fr>,
       Christoph Hellwig <hch@infradead.org>,
       Craig Milo Rogers <rogers@isi.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       webcam@smcc.demon.nl
Subject: Re: Termination of the Philips Webcam Driver (pwc)
In-Reply-To: <Pine.LNX.4.58.0408271106330.14196@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.60.0408272225140.9310@hermes-1.csi.cam.ac.uk>
References: <20040826233244.GA1284@isi.edu>  <20040827004757.A26095@infradead.org>
  <Pine.LNX.4.58.0408261700320.2304@ppc970.osdl.org>  <20040827094346.B29407@infradead.org>
  <Pine.LNX.4.58.0408271027060.14196@ppc970.osdl.org> <1093628254.15313.14.camel@gonzales>
 <Pine.LNX.4.58.0408271106330.14196@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Aug 2004, Linus Torvalds wrote:
> But Greg is right - we don't keep hooks that are there purely for binary
> drivers. If somebody wants a binary driver, it had better be a whole
> independent thing - and it won't be distributed with the kernel.

So how come we allow drivers which load binary firmware into the kernel?  
And there are plenty of them...

There isn't very much difference between binary firmware and the binary 
module in this case.  Lets see what each of these does:

- binary firmware: protects the intellectual rights of the people who 
designed the chips by not showing anyone how they work by not showing the 
original program code that drives the chips

- binary module at hand: protects the intellectual rights of the people 
who designed the chips by not showing anyone how they work by not 
showing the original program code that drives the extended functionality 
of the chips

Sound simillar?

IMHO they are identical except that the firmware is downloaded to the 
hardware and executed by a different cpu while the binary module is 
executed by the host cpu.

So how come binary firmware is welcome and binary modules which extend 
functionality are not?

Just curious.  (I personally prefer everything to be OSS but I do 
understand that some companies do not want to do this and I do have 
sympathy for their reasons in some cases.)

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
