Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263325AbVGAMyX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263325AbVGAMyX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 08:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263327AbVGAMyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 08:54:23 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:28891 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S263325AbVGAMyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 08:54:13 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: Re: FUSE merging?
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, arjan@infradead.org,
       linux-kernel@vger.kernel.org, frankvm@frankvm.com
In-Reply-To: <20050701042955.39bf46ef.akpm@osdl.org>
References: <E1DnvCq-0000Q4-00@dorka.pomaz.szeredi.hu>
	 <20050630022752.079155ef.akpm@osdl.org>
	 <E1Dnvhv-0000SK-00@dorka.pomaz.szeredi.hu>
	 <1120125606.3181.32.camel@laptopd505.fenrus.org>
	 <E1Dnw2J-0000UM-00@dorka.pomaz.szeredi.hu>
	 <1120126804.3181.34.camel@laptopd505.fenrus.org>
	 <1120129996.5434.1.camel@imp.csi.cam.ac.uk>
	 <20050630124622.7c041c0b.akpm@osdl.org>
	 <E1DoF86-0002Kk-00@dorka.pomaz.szeredi.hu>
	 <20050630235059.0b7be3de.akpm@osdl.org>
	 <E1DoFcK-0002Ox-00@dorka.pomaz.szeredi.hu>
	 <20050701001439.63987939.akpm@osdl.org>
	 <E1DoG6p-0002Rf-00@dorka.pomaz.szeredi.hu>
	 <20050701010229.4214f04e.akpm@osdl.org>
	 <E1DoIUz-0002a5-00@dorka.pomaz.szeredi.hu>
	 <20050701042955.39bf46ef.akpm@osdl.org>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Fri, 01 Jul 2005 13:53:54 +0100
Message-Id: <1120222434.23346.16.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-07-01 at 04:29 -0700, Andrew Morton wrote:
> Sorry, but I'm not buying it.  I still don't see a solid reason why all
> this could not be done with nfs/v9fs, some kernel tweaks and the rest in
> userspace.  It would take some effort, but that effort would end up
> strengthening existing kernel capabilities rather than adding brand new
> things, which is good.

FUSE is a generic FS API which is _very_ easy to write an FS for
(learning curve is about 10-15 minutes starting after you have unpacked
the fuse source code, at least it took me that long to start writing an
FS based on the example one provided).  NFS is not anything like that.

Also can the NFS approach provide me with different content depending on
the uid of the accessing process?  With FUSE that is easy as pie.  Even
easier than that actually...

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

