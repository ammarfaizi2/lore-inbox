Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbVGSR0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbVGSR0i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 13:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbVGSR0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 13:26:38 -0400
Received: from mr1.uky.edu ([128.163.2.150]:36551 "EHLO mr1.uky.edu")
	by vger.kernel.org with ESMTP id S261563AbVGSR0h convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 13:26:37 -0400
Subject: Possible GPL violation by PQI
Reply-To: rfbaum2@uky.edu
From: "Ryan Frederick Baumann" <rfbaum2@uky.edu>
To: linux-kernel@vger.kernel.org
Date: Tue, 19 Jul 2005 13:05:00 -0400
X-Mailer: NetMail ModWeb Module
MIME-Version: 1.0
Message-ID: <1121792700.9333fa4rfbaum2@uky.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mail-Router: No infection found
X-Mail-Router-SpamCheck: not spam (whitelisted), SpamAssassin (score=0,
	required 7)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Precise name of the product: PQI mPack P800

The firmware uses a modified version of the Sigma Designs uClinux 2.4.17-uc0 kernel (available here:
http://www.uclinux.org/pub/uClinux/ports/arm/EM8500/). In my previous encounters with similar devices, they have kept the portions of code that dealt with the EM85XX chipset in a seperate binary module loaded at run-time (this is the case with my Bravo D1). This is not the case with this firmware. All the EM85XX-specific modifications are embedded directly into the linux.bin kernel image, with no source available to reproduce the kernel. I contacted PQI a week ago through their "Contact Engineer" web form, but have received no response.

How the license was violated:

-copyright notice of the copyright holder is not preserved
-source code is completely missing, requests for source code ignored
-no written offer for source or copy of the license included

Firmware can be downloaded here:
http://www.pqi.com.tw/download.asp?filetype=3D5

The firmware is a modified romfs filesystem (it has a nonstandard header that you must strip before being able to use it with normal romfs tools).

-Ryan Baumann

(My apologies if this reaches the list multiple times, I tried sending this message from my GMail account but it never appeared on the list)

