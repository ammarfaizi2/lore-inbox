Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262476AbVBXUyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262476AbVBXUyp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 15:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262479AbVBXUyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 15:54:45 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:38472 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262476AbVBXUyj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 15:54:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=NZpzMzP/XgMGcImWVsrZgQNsub5J5kXgTafaFwjvy41UCDyw1nYGoqzOjjBDg1Xu3qD8mcySL/2uTZY744sP4xfglkAt5lyCJhVt3kUJF5KmzT82Zz0uRsz5EQ/Wri/pVokWN03YNNJCHhjsiz93WwztpMqlUNM3eZg+qaF/FCg=
Message-ID: <42bf3386050224125455c8e6cc@mail.gmail.com>
Date: Thu, 24 Feb 2005 21:54:33 +0100
From: Thor Harald Johansen <thorhajo@gmail.com>
Reply-To: Thor Harald Johansen <thorhajo@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: pegasus.c driver gives 'Tx timed out' on high traffic
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:
pegasus.c driver gives 'Tx timed out' on high traffic

[2.] Full description of the problem/report:
The pegasus driver gives errors on Billionton 10/100 FastEthernet
(USBE-100B2) adapters on Toshiba 2140CDS NEC-based USB controllers, in
the form of "Tx timed out" and "Intr status -84", on anything but
light traffic (<1 Mbit) lasting for more than a few seconds (5-7
seconds). Card then stops conveying traffic for anywhere between 5 and
20 seconds, then recouperates. Very annoying as it renders cards
unusable. Doesn't happen with any other USB controller, nor any other
USB device on the same controller (copying large files from/to an MP3
player works fine).

[3.] Keywords (i.e., modules, networking, kernel):
usb, networking, IRQs?

[4.] Kernel version (from /proc/version):
2.4.26 (has the issue been fixed in a newer kernel perhaps?)

[7.2.] Processor information (from /proc/cpuinfo):
AMD K6-2 450 MHz

[X.] Other notes, patches, fixes, workarounds:
Purposely slow down the network traffic? ;-)

I sent it here because the person I assumed to be the original
mainainer (the guy running pegasus2.sf.net) hasn't answered. If I
remember right, he didn't answer 2 years ago either...

-- 
Thor
