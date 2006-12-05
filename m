Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760219AbWLEWHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760219AbWLEWHz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 17:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760217AbWLEWHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 17:07:55 -0500
Received: from mga03.intel.com ([143.182.124.21]:27424 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760214AbWLEWHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 17:07:53 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,501,1157353200"; 
   d="scan'208"; a="154257808:sNHT2378718559"
Message-ID: <4575EDAB.6060305@intel.com>
Date: Tue, 05 Dec 2006 14:07:39 -0800
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       NetDev <netdev@vger.kernel.org>
Subject: 2.6.19-rc6-mm2: Network device naming starts at 1 instead of 0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Dec 2006 22:07:40.0178 (UTC) FILETIME=[C7B34720:01C718B9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[resend]

Quick note: I loaded up 2.6.19-rc6-mm2 on a platform here and noticed that the onboard
e1000 NIC was enumerated to eth1 instead of eth0. on 2.6.18.5 and any other kernel I
used before, it was properly named eth0 after startup. eth0 itself is completely missing
(-ENODEV).

I'll try to see if I can point out the culprit, but perhaps this rings a bell to anyone.

Cheers,

Auke
