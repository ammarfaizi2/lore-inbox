Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261780AbUKPTuh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbUKPTuh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 14:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbUKPTne
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 14:43:34 -0500
Received: from ppsw-8.csi.cam.ac.uk ([131.111.8.138]:12720 "EHLO
	ppsw-8.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261771AbUKPTmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 14:42:37 -0500
Date: Tue, 16 Nov 2004 19:42:29 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
cc: jengelh@linux01.gwdg.de, greg@kroah.com,
       rcpt-linux-fsdevel.AT.vger.kernel.org@jankratochvil.net,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
In-Reply-To: <E1CU94I-0007YH-00@dorka.pomaz.szeredi.hu>
Message-ID: <Pine.LNX.4.60.0411161941100.20464@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.58.0411151423390.2222@ppc970.osdl.org>
 <E1CTzKY-0000ZJ-00@dorka.pomaz.szeredi.hu> <84144f0204111602136a9bbded@mail.gmail.com>
 <E1CU0Ri-0000f9-00@dorka.pomaz.szeredi.hu> <20041116120226.A27354@pauline.vellum.cz>
 <E1CU3tO-0000rV-00@dorka.pomaz.szeredi.hu> <20041116163314.GA6264@kroah.com>
 <E1CU6SL-0007FP-00@dorka.pomaz.szeredi.hu> <20041116170339.GD6264@kroah.com>
 <E1CU7Tg-0007O8-00@dorka.pomaz.szeredi.hu> <20041116175857.GA9213@kroah.com>
 <E1CU8hS-0007U5-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.53.0411162023001.24131@yvahk01.tjqt.qr>
 <E1CU94I-0007YH-00@dorka.pomaz.szeredi.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2004, Miklos Szeredi wrote:
> > 15? But include/linux/miscdevice.h lists more than 20 static numbers for
> > possibly-going-to-be-loaded-modules!
> 
> Yes, minors 0-139 are static ones, and 140-254 are dynamic ones.
> Those 20 are all in the static range.

If you didn't mistype above this means there is space for 115 and NOT just 
15 dynamic devices and that ought to be plenty for you.

btw.  On a different subject, does fuse allow several user space 
filesystems at the same time or only one?

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
