Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263504AbTIHTcY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 15:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263525AbTIHTcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 15:32:24 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:54175 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S263504AbTIHTcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 15:32:19 -0400
Date: Mon, 8 Sep 2003 12:32:07 -0700
From: Keith Lofstrom <keithl@kl-ic.com>
To: linux-kernel@vger.kernel.org
Subject: Hot Swapping IDE using USB2 cage
Message-ID: <20030908193207.GA29053@gate.kl-ic.com>
Reply-To: keithl@ieee.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A month back, there was discussion about hotswapping IDE disks.
I have a solution that seems to work, indirectly, using the SanMax
InClose PMD96-USB2 Mobile Dock.  This cage is physically compatable
with the PMD96i direct IDE cages, but has a translator from IDE
(LBA48!) to USB2, which I connect to a USB2 PCI card in my system.
With USB hotswap enabled,  the system seems to recognize when
disks are added and removed.  This allows me to do backups to
cheap big IDE hard drives, and swap them out for safekeeping. 
For more information, look at my web page in progress:  

   http://www.keithl.com/linuxbackup.html

I am still working on this, so your mileage may vary.  I am
incompetent at software, so a more clueful person is welcome
to take over and do this right.  In any case, this provides a
functional solution for IDE hotswap without kernel patches, and
that might free up some wizard time for other needed tasks.

Keith

-- 
Keith Lofstrom           keithl@ieee.org         Voice (503)-520-1993
KLIC --- Keith Lofstrom Integrated Circuits --- "Your Ideas in Silicon"
Design Contracting in Bipolar and CMOS - Analog, Digital, and Scan ICs
