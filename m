Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263725AbUDOSma (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 14:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264355AbUDOSm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 14:42:29 -0400
Received: from userel174.dsl.pipex.com ([62.188.199.174]:11650 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id S263725AbUDOSmH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 14:42:07 -0400
Date: Thu, 15 Apr 2004 19:40:39 +0100 (BST)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: tigran@einstein.homenet
To: linux-kernel@vger.kernel.org
Subject: problems with quad Xeon SuperServer came back 4 years later
Message-ID: <Pine.LNX.4.44.0404151930120.949-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello guys,

Those of you old enough will remember the problem I reported in 2000 (and
at the time fixed) with quad Xeon SuperServer8050 machine, here is the
message from 12 October 2000:

 http://www.uwsg.iu.edu/hypermail/linux/kernel/0010.1/0789.html

Now, something must have changed between 2000 and 2004 because exactly the
same problem came back now when running 2.4.21-4EL kernel from Red Hat
Advanced Server 3 distribution. Only now, disabling the caching of CXXX
areas in the BIOS doesn't fix the problem, unfortunately.  I haven't tried
2.6 on that machine, because I need to get it working urgently with AS3
kernels.

Did anyone else run into this? Maybe I should upgrade the BIOS which will
tune the caching in the chipset appropriately? It is an S2QR6 motherboard
with 4x PIII Xeon 700MHz and 6G RAM, AMI BIOS v1.2 (not upgraded since
1999). The problem is that "everything" is about 40-50 times slower than
normal. E.g. gzip -9 of a 10M random file takes 6 minutes instead of 5
seconds etc. It used to compile the kernel in 50 seconds (as the message
above says). Now it is taking ages, so slow not even worth mentioning the
exact numbers (i.e. unacceptably slow!)

Kind regards
Tigran

