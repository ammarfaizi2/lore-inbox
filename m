Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262471AbVE0Ppo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262471AbVE0Ppo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 11:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262473AbVE0Ppo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 11:45:44 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:24760 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S262471AbVE0Ppi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 11:45:38 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Fri, 27 May 2005 16:45:16 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ntfs: use struct initializers
In-Reply-To: <Pine.LNX.4.58.0505261113390.6273@sbz-30.cs.Helsinki.FI>
Message-ID: <Pine.LNX.4.60.0505271643350.20905@hermes-1.csi.cam.ac.uk>
References: <1117044875.9510.2.camel@localhost>
 <Pine.LNX.4.60.0505252208120.25834@hermes-1.csi.cam.ac.uk>
 <courier.42956AFA.00002502@courier.cs.helsinki.fi>
 <20050526070437.GY29811@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0505261113390.6273@sbz-30.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pekka,

On Thu, 26 May 2005, Pekka J Enberg wrote:
> This patch converts explicit NULL assignments to use struct initializers as
> suggested by Al Viro.

Thanks.  I applied this (slightly modified since you went outside the 80 
char width) as well as equivalent changes to attrib.c and index.c.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

