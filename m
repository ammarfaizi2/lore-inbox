Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261207AbVCNH20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbVCNH20 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 02:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbVCNH20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 02:28:26 -0500
Received: from dialpool1-164.dial.tijd.com ([62.112.10.164]:13001 "EHLO
	precious.kicks-ass.org") by vger.kernel.org with ESMTP
	id S261207AbVCNH2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 02:28:22 -0500
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: cpufreq on-demand governor up_treshold?
Date: Mon, 14 Mar 2005 08:29:04 +0100
User-Agent: KMail/1.7.2
Cc: cpufreq@ZenII.linux.org.uk
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503140829.04750.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello lists,

(please cc me from cpufreq list)

I've since yesterday started using the ondemand governor. Seems to work fine, 
tho I can't seem to find a reason why it keeps scaling my processor speed 
upwards tho the processor use never exceeds 30% (been watching top -d 1). 

I've been using the powernowd daemon and the userspace governor previously, 
which doesn't seem to have this problem, even if i set it at the same 
sampling rates as the ondemand governor.

The settings in /sys/.../ondemand are default.

Any hints?

Thanks.
-- 
Women aren't as mere as they used to be.
  -- Pogo
