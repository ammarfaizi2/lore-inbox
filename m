Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261879AbVBOUry@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbVBOUry (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 15:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261878AbVBOUqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 15:46:05 -0500
Received: from bay102-f34.bay102.hotmail.com ([64.4.61.44]:10176 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261897AbVBOUlQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 15:41:16 -0500
Message-ID: <BAY102-F34629FB0CE60DB39785241AE6B0@phx.gbl>
X-Originating-IP: [64.90.198.61]
X-Originating-Email: [jocosby@hotmail.com]
From: "Joseph Cosby" <jocosby@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.9 IO-APIC + timer doesn't work! with VMWare 4
Date: Tue, 15 Feb 2005 13:29:49 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 15 Feb 2005 20:30:04.0690 (UTC) FILETIME=[21BF3720:01C5139D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  Using VMWare 4 with a 2.6.9 kernel I get "IO-APIC + timer doesn't work!" 
As suggested, the noapic option fixes the problem. This resulted after 
adding APIC support to my kernel. My problem is, I need APIC support to boot 
on a separate, non-VMWare machine, and I need to keep the kernel and boot 
params the same on both machines.
  Aside from disabling APIC support, and running with the noapic parameter, 
can anybody suggest how to get this running on the VMware machine?

Thank you in advance,
Joseph

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today - it's FREE! 
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/

