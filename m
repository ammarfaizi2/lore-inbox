Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbTFCXhS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 19:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbTFCXhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 19:37:18 -0400
Received: from magic-mail.adaptec.com ([208.236.45.100]:54922 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP id S261893AbTFCXhN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 19:37:13 -0400
Date: Tue, 03 Jun 2003 17:51:07 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
cc: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Message-ID: <1051920000.1054684267@aslan.btc.adaptec.com>
X-Mailer: Mulberry/3.0.3 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,

I've just uploaded version 1.3.10 of the aic79xx driver and version 
6.2.36 of the aic7xxx driver.  Both are available for 2.4.X and
2.5.X kernels in either bk send format or as a tarball from here:
 
http://people.FreeBSD.org/~gibbs/linux/SRC/

The change sets relative to the 2.5.X tree are:

ChangeSet@1.1275, 2003-06-03 17:35:01-06:00, gibbs@overdrive.btc.adaptec.com
  Update Aic79xx Readme

ChangeSet@1.1274, 2003-06-03 17:22:05-06:00, gibbs@overdrive.btc.adaptec.com
  Aic7xxx Driver Update
   o Bump version number to 6.2.36
   o Document recent aic7xxx driver releases

ChangeSet@1.1273, 2003-06-03 17:20:14-06:00, gibbs@overdrive.btc.adaptec.com
  Aic79xx Driver Update
   o Bump driver version to 1.3.10
   o Document recent releases in driver readme.

ChangeSet@1.1272, 2003-05-31 21:12:09-06:00, gibbs@overdrive.btc.adaptec.com
  Aic7xxx and Aic79xx Driver Update
   o Work around negotiation firmware bug in the Quantum Atlas 10K
   o Clear stale PCI errors in our register mapping test to avoid
     false positives from rouge accesses to our registers that occur
     prior to our driver attach.

ChangeSet@1.1271, 2003-05-31 18:34:01-06:00, gibbs@overdrive.btc.adaptec.com
  Aic79xx Driver Update
   o Implement suspend and resume

ChangeSet@1.1270, 2003-05-31 18:32:36-06:00, gibbs@overdrive.btc.adaptec.com
  Aic7xxx Driver Update
   o Fix some suspend and resume bugs

ChangeSet@1.1269, 2003-05-31 18:27:09-06:00, gibbs@overdrive.btc.adaptec.com
  Aic7xxx Driver Update
   o Correct the type of the DV settings array.

ChangeSet@1.1268, 2003-05-31 18:25:28-06:00, gibbs@overdrive.btc.adaptec.com
  Aic7xxx and Aic79xx driver Update
   o Remove unecessary and incorrect use of ~0 as a mask.

ChangeSet@1.1267, 2003-05-30 13:50:00-06:00, gibbs@overdrive.btc.adaptec.com
  Aic7xxx and Aic79xx Driver Update
   o Adapt to 2.5.X SCSI proc interface change while maitaining
     compatibility with earlier kernels.

ChangeSet@1.1266, 2003-05-30 11:01:02-06:00, gibbs@overdrive.btc.adaptec.com
  Merge http://linux.bkbits.net/linux-2.5
  into overdrive.btc.adaptec.com:/usr/home/gibbs/bk/linux-2.5

ChangeSet@1.1215.4.6, 2003-05-30 10:50:17-06:00, gibbs@overdrive.btc.adaptec.com
  Aic7xxx Driver Update
   o Bring in aic7xxx_reg_print.c update that was missed the
     last time the firmware was regenerated.  The old file worked
     fine, so this is mostly a cosmetic change.

ChangeSet@1.1215.4.5, 2003-05-30 10:48:31-06:00, gibbs@overdrive.btc.adaptec.com
  Aic79xx Driver Update
   o Correct non-zero lun output on post Rev A4 hardware
     in packetized mode.

ChangeSet@1.1215.4.4, 2003-05-30 10:46:03-06:00, gibbs@overdrive.btc.adaptec.com
  Aic79xx Driver Update
   o Return to using 16byte alignment for th SCB_TAG field in our SCB.
     The hardware seems to corrupt SCBs on some PCI platforms with the
     tag field in its old location.

ChangeSet@1.1215.4.3, 2003-05-30 10:43:20-06:00, gibbs@overdrive.btc.adaptec.com
  Aic7xxx Driver Update
   o Adopt 2.5.X EISA framework for probing aic7770 controllers

ChangeSet@1.1215.4.2, 2003-05-30 10:31:04-06:00, gibbs@overdrive.btc.adaptec.com
  Aic7xxx Driver Update
   o Correct card identifcation string for the 2920C


