Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261224AbVDDOMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbVDDOMY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 10:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbVDDOMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 10:12:24 -0400
Received: from ppsw-2.csi.cam.ac.uk ([131.111.8.132]:47040 "EHLO
	ppsw-2.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261224AbVDDOMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 10:12:20 -0400
Subject: Re: [PATCH] don't check for NULL before calling kfree() in fs/ntfs/
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.62.0503252322460.2498@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0503252322460.2498@dragon.hyggekrogen.localhost>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Mon, 04 Apr 2005 15:11:54 +0100
Message-Id: <1112623914.18105.41.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2005-03-25 at 23:25 +0100, Jesper Juhl wrote:
> (please keep me on CC)
>
> There's no need to check a pointer for NULL before calling kfree() on it - 
> kfree() handles NULL pointers just fine on its own.

Thanks.  Applied to my ntfs development tree so it should be in the next
-mm tree.

Apologies for the delay but I have been ill for two weeks and have been
catching up with things ever since...

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

