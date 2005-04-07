Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262271AbVDGI3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262271AbVDGI3v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 04:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262401AbVDGI2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 04:28:14 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:18437 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S262271AbVDGI0Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 04:26:24 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Matthew Wilcox" <matthew@wil.cx>
Cc: <linux-kernel@vger.kernel.org>, <debian-legal@lists.debian.org>,
       <linux-acenic@sunsite.dk>
Subject: RE: non-free firmware in kernel modules, aggregation and unclear copyright notice.
Date: Thu, 7 Apr 2005 01:26:17 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKAEKLCPAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
In-Reply-To: <yq08y3vxd3x.fsf@jaguar.mkp.net>
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Thu, 07 Apr 2005 01:25:28 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Thu, 07 Apr 2005 01:25:29 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Well whoever wrote that seems to have taken the stand that the
> openfirmware package was were the firmware came from. The person
> obviously made a lot of statements without bothering checking out the
> real source. Well it didn't come from there, I got it from Alteon
> under a written agreement stating I could distribute the image under
> the GPL. Since the firmware is simply data to Linux, hence keeping it
> under the GPL should be just fine.

	You cannot distribute anything under the GPL if you cannot also distribute
the source code (the preferred form of the software for the purpose of
making modifications to it). How Linux sees it is irrelevant. For any piece
of software, one can imagine some processor that can only see it as data.
The GPL doesn't distinguish between processors.

	Alteon's written agreement notwithstanding, you cannot distribute the
firmware under the GPL if you cannot provide the preferred form of the
firmware for the purpose of making modifications to it. The firmware does
not run on Linux, so saying "linux sees it as data" is as absurd as saying I
can distribute the x86 Linux kernel without the source because my calculator
can only see it as data.

	You cannot distribute the firmware binary under the GPL. Period.

	Now, if you were trying to say that you could aggregate the firmware with
another work and distribute the result under the GPL, the test would be
whether the final result is "mere aggregation" or not. This is a
fantastically tricky question and I don't think anyone on this list could
give you particularly useful guidance.

	My own opinion is that it's a threshold issue based upon several factors.
For example -- has the firmware been specifically designed to work with the
Linux driver or is it "generic" firmware? If you can't take the thing you're
distributing (the combined binary) and extract two works from it (the
firmware and the work whose source you are offering), I cannot see how you
can claim it's mere aggregation.

	If you believe the linker "merely aggregates" the object code for the
driver with the data for the firmware, I can't see how you can argue that
any linking is anything but mere aggregation. In neither case can you
separate the linked work into the two separate works and in both cases the
linker provides one work direct access to the other.

	If you only distribute the source to the driver and don't put a GPL notice
in the files that contain the firmware data, I think you're okay. I think
you're asking for trouble if you distribute a combined compiled/linked
driver.

	DS


