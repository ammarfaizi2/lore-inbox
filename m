Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264706AbUDVVmn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264706AbUDVVmn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 17:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264713AbUDVVmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 17:42:43 -0400
Received: from host-198-7-243-17.oshean.org ([198.7.243.17]:32207 "EHLO
	rwu-e1000.rwu.edu") by vger.kernel.org with ESMTP id S264706AbUDVVmk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 17:42:40 -0400
Subject: Nforce2 Apic lockup temporary fix
From: "Gerald J. Normandin Jr." <gnormandin428@rwu.edu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1082655922.7650.4.camel@screamer.nfn.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 22 Apr 2004 17:45:22 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, it seems as if I just might have found a temporary fix for the
Nforce APIC Borkage. Using a uniprocessor configured kernel, I would get
lockups running hdparm -t /dev/hda. However, reconfiguring the kernel
for SMP seems to have fixed this.

Please send all input on this either to my email, or the bug I posted on
bugme.osdl.org at : http://bugme.osdl.org/show_bug.cgi?id=2552
One person who replied to that bug states this works. 

(I ask this because I do not have the bandwidth or storage to spare
signing up on this list.)

Thanks, 
Gerald J. Normandin Jr.

