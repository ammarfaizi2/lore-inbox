Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265800AbUI0Dnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265800AbUI0Dnx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 23:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265697AbUI0Dnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 23:43:52 -0400
Received: from fmr05.intel.com ([134.134.136.6]:37275 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S265800AbUI0Dng convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 23:43:36 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: suspend/resume support for driver requires an external firmware
Date: Mon, 27 Sep 2004 11:43:09 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8403BD5791@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: suspend/resume support for driver requires an external firmware
Thread-Index: AcSiT8oJvNp+q6/BTP2rS6I6CH1doAB7rSNA
From: "Zhu, Yi" <yi.zhu@intel.com>
To: "Oliver Neukum" <oliver@neukum.org>
Cc: "Patrick Mochel" <mochel@digitalimplant.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 27 Sep 2004 03:43:10.0456 (UTC) FILETIME=[1BCFEF80:01C4A444]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum wrote:
> Am Freitag, 24. September 2004 08:16 schrieb Zhu, Yi:
>> Choice 3? or I missed something here?
> 
> If the user requests suspension, why can't he transfer the
> firmware before he does so? Thus the firmware would be in ram
> or part of the image read back from disk.

Do you suggest before user echo 4 > /proc/acpi/sleep, [s]he must
do something like cat /path/of/firmware > /proc/net/ipw2100/firmware?

Thanks,
-yi
