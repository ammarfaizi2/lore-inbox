Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262000AbVBUPCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbVBUPCL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 10:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262004AbVBUPCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 10:02:09 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:50854 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262000AbVBUPCE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 10:02:04 -0500
Subject: Re: ide-scsi is deprecated for cd burning! Use ide-cd and give
	dev=/dev/hdX as device
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Kiniger, Karl (GE Healthcare)" <karl.kiniger@med.ge.com>
Cc: Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050218103107.GA15052@wszip-kinigka.euro.med.ge.com>
References: <200502152125.j1FLPSvq024249@turing-police.cc.vt.edu>
	 <200502161736.j1GHa4gX013635@turing-police.cc.vt.edu>
	 <cv36kk$54m$1@gatekeeper.tmr.com>
	 <20050218103107.GA15052@wszip-kinigka.euro.med.ge.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1108998023.15518.93.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 21 Feb 2005 15:00:28 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-02-18 at 10:31, Kiniger, Karl (GE Healthcare) wrote:
> Not entirely true (at least for me). I actually tried to read the 
> last iso9660 data sector with a small C program (reading 2 kb) and
> it failed to read the sector. Using ide-scsi I was able to read it.....

Thats the bug that should now be fixed by the ide changes I did so that
ide-cd has the knowledge ide-scsi has for partial completions of I/O

