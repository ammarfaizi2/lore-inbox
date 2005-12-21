Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbVLUTX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbVLUTX3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 14:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbVLUTX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 14:23:29 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:60623 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751209AbVLUTX2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 14:23:28 -0500
Date: Wed, 21 Dec 2005 20:23:27 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: ip_output.c change question
Message-ID: <Pine.LNX.4.61.0512212021140.12159@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


what was the reason to remove the EXPORT_SYMBOL(sysctl_ip_default_ttl) in 
http://www.kernel.org/git/?p=linux/kernel/git/davem/net-2.6.16.git;a=blobdiff;h=c934f5316c3bc1362e85029f3978448501028b96;hp=766564cb420760d0d715d75851a8e49496eeaf6b;hb=0742fd53a3774781255bd1e471e7aa2e4a82d5f7;f=net/ipv4/ip_output.c
? ipt_TARPIT uses this variable and relies on it being available.


Jan Engelhardt
-- 
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/
