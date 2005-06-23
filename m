Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262871AbVFWIjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262871AbVFWIjw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 04:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263067AbVFWIgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 04:36:39 -0400
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:42385 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S262263AbVFWIBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 04:01:47 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Thu, 23 Jun 2005 09:01:41 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: Updated git HOWTO for kernel hackers
In-Reply-To: <Pine.LNX.4.58.0506221603120.11175@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.60.0506230900140.7099@hermes-1.csi.cam.ac.uk>
References: <42B9E536.60704@pobox.com> <Pine.LNX.4.58.0506221603120.11175@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jun 2005, Linus Torvalds wrote:
> On Wed, 22 Jun 2005, Jeff Garzik wrote:
> > 2) download a linux kernel tree for the very first time
> > 
> > $ mkdir -p linux-2.6/.git
> > $ cd linux-2.6
> > $ rsync -a --delete --verbose --stats --progress \
> > rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/ 
> > \          <- word-wrapped backslash; sigh
> >      .git/
> 
> Gaah. I should do a "git-clone-script" or something that does this, and 
> then you could just do
> 
> 	git clone rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git linux-2.6
> 	
> Anybody?

What's wrong with Pasky's cogito scripts?  There is a cg-pull as well as a 
cg-clone in there already.  If nothing else you could just copy the 
relevant scripts and rename them to git-blah...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
