Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269121AbUIZAGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269121AbUIZAGu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 20:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269129AbUIZAGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 20:06:49 -0400
Received: from ppsw-8.csi.cam.ac.uk ([131.111.8.138]:51942 "EHLO
	ppsw-8.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S269121AbUIZAGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 20:06:42 -0400
Date: Sun, 26 Sep 2004 01:06:34 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [PATCH 4/10] Re: [2.6-BK-URL] NTFS: 2.1.19 sparse annotation,
 cleanups and a bugfix
In-Reply-To: <20040925063210.GP23987@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.60.0409260106140.24909@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0409241707370.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241711400.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241712320.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241712490.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241713070.19983@hermes-1.csi.cam.ac.uk>
 <20040925063210.GP23987@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Sep 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:

> On Fri, Sep 24, 2004 at 05:13:20PM +0100, Anton Altaparmakov wrote:
> > This is patch 4/10 in the series.  It contains the following ChangeSet:
> > 
> > <aia21@cantab.net> (04/09/23 1.1951)
> >    NTFS: Change '\0' and L'\0' to simply 0 as per advice from Linus Torvalds.
> 
> Take one more step and replace cpu_to_le16(0) with 0...

Done.

Thanks,
	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
