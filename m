Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262985AbTFGKrV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 06:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263011AbTFGKrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 06:47:21 -0400
Received: from grobbebol.xs4all.nl ([194.109.248.218]:19031 "EHLO
	grobbebol.xs4all.nl") by vger.kernel.org with ESMTP id S262985AbTFGKrU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 06:47:20 -0400
Date: Sat, 7 Jun 2003 13:00:23 +0200
From: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: AEC SCSIDE bridge/2.4.18 crash
Message-ID: <20030607110023.GA1750@grobbebol.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all,


I recently decided to do some testing on an www.acard.com scside bridge.
type : AEC7720U.

this thing essentially connects to my BT930 scsi controller and at the
other side a standard IDE drive, WD1200JB.

as long as I don't use the drive the systems stays stable. if I format
the drive, it crashes half of the time. if copying lots of data, it
crashes as well.

there is no error in any log. the system crashes hard. numlock can be
used one time and then it fails as well. magic sysrq doesn't work
either.

I will add scsi verbose logging to the kernel and restart but am afraid
there will be nothing in the logs.

any ideas ?

