Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261241AbULINrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbULINrP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 08:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbULINrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 08:47:15 -0500
Received: from got80-74-137-2.ch-meta.net ([80.74.137.2]:36784 "EHLO
	gothicus.metanet.ch") by vger.kernel.org with ESMTP id S261241AbULINrN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 08:47:13 -0500
From: Thomas Bettler <bettlert@student.ethz.ch>
To: linux-kernel@vger.kernel.org
Subject: uhci-hcd and cpufreq
Date: Thu, 9 Dec 2004 14:47:11 +0100
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412091447.11996.bettlert@student.ethz.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found out the uhci-hcd causes the cpu to work at highest frequecy (according 
to x86info -mhz). If I unload it, cpu frequency dropps from full (1.8GHz) to 
~2/3 (1.1GHz). In both cases top shows 97% or even 99% idle.

1. Why causes uhci-hcd that high frequency at no obiously load?

2. Could this behaviour be stopped or do we have to live with it?

This is what I could find out. But I won't get further since I not a hacker, 
just a user.

Thanks anyway for all your work.
Thomas Bettler
