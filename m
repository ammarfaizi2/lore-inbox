Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752480AbVHGSCO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752480AbVHGSCO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 14:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752481AbVHGSCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 14:02:14 -0400
Received: from smtp-vbr8.xs4all.nl ([194.109.24.28]:60420 "EHLO
	smtp-vbr8.xs4all.nl") by vger.kernel.org with ESMTP
	id S1752480AbVHGSCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 14:02:14 -0400
Message-ID: <42F64C9F.602@xs4all.nl>
Date: Sun, 07 Aug 2005 20:02:07 +0200
From: Udo van den Heuvel <udovdh@xs4all.nl>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: VIA Rhine ethernet driver bug (reprise)
X-Enigmail-Version: 0.92.0.0
OpenPGP: id=8300CC02
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

In january of this year I mentioned a problem with the Linux kernel
driver for VIA Rhine ethernet chips. (see http://lkml.org/lkml/2005/1/15/47)
In the mean time this bug was reproduced quite a number of times on my
Fedora Core 3 (then)/4 (now) box (a VIA CL6000).

An alternative driver by VIA was used (with kernel 2.6.1x,
http://www.viaarena.com/downloads/Source/rhinefet.tgz); this VIA driver
did not have the Oversized ethernet frame bug but consumes quite a lot
of CPU when transfering a steady stream of a few 1000 KB/S, so it is no
good solution.

Since the ethernet connection goes down due to this bug I think I can
mark the bug as critical. The bug is still present in 2.6.12.
The maintainer of the driver cannot fix the bug. Who can?

Please post here and/or email me with your thoughts about a solution,
ways of fixing the bug. Would a small reward help?

Kind regards,
Udo

