Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263645AbUEGPxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263645AbUEGPxR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 11:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263646AbUEGPxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 11:53:17 -0400
Received: from fw.osdl.org ([65.172.181.6]:23988 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263645AbUEGPxN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 11:53:13 -0400
Date: Fri, 7 May 2004 08:53:12 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: Distributions vs kernel development
Message-Id: <20040507085312.3247d70d@dell_ss3.pdx.osdl.net>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After having being burned twice: first by Mandrake and supermount, and second
by SuSe and reiserfs attributes; are any of the distributions committed to
making sure that their distribution will run the standard kernel? (ie. 2.6.X from
kernel.org). When running a non-vendor kernel, I need to reasonably expect that the system
will boot and all the filesystems and standard devices are available.  I don't
expect every startup script to run clean, or every device that has a driver
only in the vendor kernel to work. 

But kernel developers need to be able run a standard environment. This effects
both day to day kernel testing and automated test environments like PLM and STP.
I am not saying it is bad that the distributions try to satisfy their customers,
or create a better experience; they just need to stop breaking things, and add
running a standard kernel as part of their QA cycle.

