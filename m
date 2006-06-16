Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751303AbWFPPtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbWFPPtz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 11:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbWFPPtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 11:49:55 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:60426 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S1751303AbWFPPtz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 11:49:55 -0400
Message-ID: <4492D321.9020709@onelan.co.uk>
Date: Fri, 16 Jun 2006 16:49:53 +0100
From: Barry Scott <barry.scott@onelan.co.uk>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.16.20 fails to boot on SATA system but works on IDE
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After failing to get 2.6.17-rc6 working on a HP dc7600U I went back
to 2.6.16.20. It also fails to find any volume group during boot.

I think this might be problem with SATA as I can boot the same build on
two other systems that have IDE disks.

I get success on VIA Epia M10000 and a P4 Shuttle systems that use
IDE disks but fail on the HP dc7600U that uses a SATA disk. All three
systems use LVM2.

The Fedora build of 2.6.16 works on all three systems.

I'm going to see if there are debug messages I can turn on it libata
and md that might give more information.

Any suggestions as to what I can do to track down this problem?

Barry

