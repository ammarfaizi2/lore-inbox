Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932676AbVHSRtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932676AbVHSRtv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 13:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932678AbVHSRtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 13:49:51 -0400
Received: from theta1.cft.edu.pl ([195.187.84.131]:29676 "EHLO
	theta1.cft.edu.pl") by vger.kernel.org with ESMTP id S932676AbVHSRtv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 13:49:51 -0400
Date: Fri, 19 Aug 2005 19:49:42 +0200
From: Cezary Sliwa <sliwa@blue.cft.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: floppy driver in 2.6.12.5
Message-ID: <20050819174942.GA14713@cft.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just wanted to format a floppy disk with fdformat, no way:

Aug 14 22:28:45 kwant kernel: floppy0: unexpected interrupt 
Aug 14 22:28:45 kwant kernel: floppy0: sensei repl[0]=80 
Aug 14 22:28:49 kwant kernel: floppy0: -- FDC reply errorfloppy0: unexpected interrupt 
Aug 14 22:28:49 kwant kernel: floppy0: sensei repl[0]=80 
Aug 14 22:28:51 kwant kernel: floppy0: -- FDC reply error<4>IN=ppp0 OUT= MAC= SRC=81.190.249.26 DST=83.24.228.114 LEN=60 TOS=0x00 PREC=0x00 TTL=120 ID=51789 PROTO=UDP SPT=4672 DPT=4672 LEN=40 
Aug 14 22:29:04 kwant kernel: IN=ppp0 OUT= MAC= SRC=83.25.145.251 DST=83.24.228.114 LEN=60 TOS=0x00 PREC=0x00 TTL=122 ID=33367 PROTO=UDP SPT=4685 DPT=4672 LEN=40 
Aug 14 22:29:07 kwant kernel: floppy0: unexpected interrupt 
Aug 14 22:29:07 kwant kernel: floppy0: sensei repl[0]=80 
Aug 14 22:29:07 kwant kernel: floppy0: seek failed

Linux version 2.6.12.5 (root@kwant) (gcc version 2.95.3 20010315 (release))
#1 Thu Aug 18 21:12:45 CEST 2005

nforce2 mobo, nec fdd

