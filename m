Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752396AbWCPQms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752396AbWCPQms (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 11:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752398AbWCPQms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 11:42:48 -0500
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:20912 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1752395AbWCPQms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 11:42:48 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Thu, 16 Mar 2006 16:42:29 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Christoph Hellwig <hch@infradead.org>
cc: "Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, aia21@cantab.net, len.brown@intel.com
Subject: Re: [patch 1/1] consolidate TRUE and FALSE
In-Reply-To: <20060316163621.GA7519@infradead.org>
Message-ID: <Pine.LNX.4.64.0603161640230.31173@hermes-2.csi.cam.ac.uk>
References: <200603161004.k2GA46Fc029649@shell0.pdx.osdl.net>
 <20060316160129.GB6407@infradead.org> <20060316082951.58592fdc.rdunlap@xenotime.net>
 <20060316163001.GA7222@infradead.org> <20060316083654.d802f3f3.rdunlap@xenotime.net>
 <20060316163621.GA7519@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Mar 2006, Christoph Hellwig wrote:
> > > it makes the code longer and harder to read.  there's a reason the core
> > > code doesn't use it, and the periphal code should do the same.
> > 
> > in your opinion.
> 
> of course.  but that it's not used in core code implies this opinion is
> widely shared.

Again, in your opinion.  To me it is a simple consequence of there not 
being a boolean type in the kernel so you cannot use it in the core code.  
Once there is such a type I would imagine users will appear in the core 
code over time.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
