Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932518AbWGSHdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932518AbWGSHdU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 03:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932520AbWGSHdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 03:33:20 -0400
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:11229 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932518AbWGSHdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 03:33:19 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: Re: Generic B-tree implementation
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Vishal Patil <vishpat@gmail.com>
Cc: Gary Funck <gary@intrepid.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4745278c0607180822u55ffe5b4g333e2e6457b37d02@mail.gmail.com>
References: <4745278c0607180630m39040ad7neac25c1a64399aff@mail.gmail.com>
	 <JCEPIPKHCJGDMPOHDOIGCELEDFAA.gary@intrepid.com>
	 <4745278c0607180822u55ffe5b4g333e2e6457b37d02@mail.gmail.com>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Wed, 19 Jul 2006 08:33:14 +0100
Message-Id: <1153294394.13071.3.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-18 at 11:22 -0400, Vishal Patil wrote:
> B-trees are good for parellel updates as well. Anyway it would be
> great to have inputs from other folks about how B-trees could help
> inside the kernel (if at all)

B-trees are mostly used in file systems in the kernel.  For example NTFS
and HFS (and I think HPFS) use B-trees for various metadata like
directory indexes for example.

But of course your implementation is purely userspace and cannot be used
in the kernel (you use recursion for example...) so I am not sure how
you envisage to help the kernel with your code...

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

