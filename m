Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267487AbUI1C21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267487AbUI1C21 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 22:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267509AbUI1C20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 22:28:26 -0400
Received: from fmr05.intel.com ([134.134.136.6]:4279 "EHLO hermes.jf.intel.com")
	by vger.kernel.org with ESMTP id S267487AbUI1C2Y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 22:28:24 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: suspend/resume support for driver requires an external firmware
Date: Tue, 28 Sep 2004 10:28:01 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8403BD579C@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: suspend/resume support for driver requires an external firmware
Thread-Index: AcSkshiIAJIveccgSNS48VO1gos4pQATvnuA
From: "Zhu, Yi" <yi.zhu@intel.com>
To: "Patrick Mochel" <mochel@digitalimplant.org>
Cc: "Oliver Neukum" <oliver@neukum.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 28 Sep 2004 02:28:02.0469 (UTC) FILETIME=[C7417550:01C4A502]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel wrote:
> Why not just suspend the device first, then enter the system
> suspend state; then on resume, resume the device after
> control has transferred back to userspace. That way, the
> driver can load the firmware from the disk, and we don't have
> to worry about it in the kernel. Automate with a script, and
> never worry about it again. :)

This won't work for the mount NFS root model proposed by
Denis Vlasenko on this topic.

Thanks,
-yi
