Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268965AbUHME2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268965AbUHME2U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 00:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268966AbUHME2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 00:28:20 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:28555 "EHLO
	pd4mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S268965AbUHME2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 00:28:15 -0400
Date: Thu, 12 Aug 2004 22:22:58 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Allow userspace do something special on overtemp
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <00fe01c480ed$36a08330$6401a8c0@northbrook>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Content-transfer-encoding: 7bit
X-Priority: 3
X-MSMail-priority: Normal
References: <fa.fd8nc62.oig6ao@ifi.uio.no> <fa.g1p407b.1c569pj@ifi.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: "Pavel Machek" <pavel@suse.cz>
Newsgroups: fa.linux.kernel
To: "Len Brown" <len.brown@intel.com>
Cc: "Dax Kelson" <dax@gurulabs.com>; <trenn@suse.de>; <seife@suse.de>;
"Kernel Mailing List" <linux-kernel@vger.kernel.org>
Sent: Thursday, August 12, 2004 5:25 PM
Subject: Re: Allow userspace do something special on overtemp


> Ouch and btw I've done some torturing on one prototype (AMD). It had
> thermal at 98Celsius (specs for this cpu said 95C max), and I ended my
> test at 105Celsius. I do not know about TM1/TM2 etc, but in this case
> hardware clearly failed to do the right thing.

This is dependent on the CPU/motherboard in use - AMD CPUs (up to the last
ones I heard about, anyway) don't have any built in thermal protection, they
rely on the motherboard to shut down the CPU in the event of
over-temperature. Intel CPUs since the Pentium II all shut down on excessive
over-temperature; Pentium 4s will also clock-throttle to continue operating
before they get to this point.

