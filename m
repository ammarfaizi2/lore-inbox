Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261390AbVGDQJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbVGDQJL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 12:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbVGDQH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 12:07:59 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:50410 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261390AbVGDQAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 12:00:42 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: RE: Problem with inotify
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Gautam Singaraju <gsingara@uncc.edu>
Cc: "'Daniel Drake'" <dsd@gentoo.org>,
       "'David =?ISO-8859-1?Q?G=F3mez=27?=" <david@pleyades.net>,
       "'Robert Love'" <rml@novell.com>,
       "'John McCutchan'" <ttb@tentacle.dhs.org>,
       "'Linux-kernel'" <linux-kernel@vger.kernel.org>
In-Reply-To: <200507041555.j64FtFL4010937@ms-smtp-04-eri0.southeast.rr.com>
References: <200507041555.j64FtFL4010937@ms-smtp-04-eri0.southeast.rr.com>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Mon, 04 Jul 2005 17:00:32 +0100
Message-Id: <1120492832.11399.24.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gautam,

On Mon, 2005-07-04 at 11:55 -0400, Gautam Singaraju wrote:
> I had used the 2.6.12 kernel with the latest Inotify. There was no
> "I_WILL_FREE" in the any place. And, there was no problem in compilation.

Er, yes, obviously.  You are not using my patch on top of inotify and
original inotify does not use I_WILL_FREE.  You are answering somewhat
out of context...

> I believe Inotify is very useful and should be included in the next versions
> of the kernel. Are there any ongoing plans for this?

I cannot answer this.  Robert/John?  However there appear to be issues
with it at the moment (the umount problems with ntfs volumes) so
probably not quite yet unless we figure out the problems...

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

