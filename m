Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265233AbUFYJDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265233AbUFYJDV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 05:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266598AbUFYJDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 05:03:21 -0400
Received: from out007pub.verizon.net ([206.46.170.107]:13451 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S265233AbUFYJDU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 05:03:20 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Organization: not detectable
To: For users of Fedora Core releases <fedora-list@redhat.com>
Subject: scsi (driver sg) error fix requires a reboot
Date: Fri, 25 Jun 2004 05:03:12 -0400
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406250503.12752.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [141.153.74.164] at Fri, 25 Jun 2004 04:03:18 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

I'm running fedora FC1, but with the most recent 2.6.7-rc3-mm2 kernel, 
however this doesn't seem to be particularly kernel version 
sensitive.  I first noted this maybe 3 or 4 years ago, and its bit me 
maybe 3 or 4 times since.

If I use mtx (version in this instant case is 1.2.18rel) to manipulate 
my tape changer, and there is an error in loading the tape (which it 
actually did just fine by the way), the only apparent recovery seems 
to be a reboot as /dev/sg1 is no longer functioning for the amanda 
required usages after the error.

Is this a known bug, or something rather obscure?

-- 
Cheers, Gene
There are 4 boxes to be used in defense of liberty.  Soap, ballot, 
jury, and ammo.
 Please use in that order, starting now.  -Ed Howdershelt, Author
Additions to this message made by Gene Heskett are Copyright 2004, 
Maurice E. Heskett,
all rights
reserved.
