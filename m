Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261220AbUKBMfy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbUKBMfy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 07:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbUKBMfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 07:35:54 -0500
Received: from natnoddy.rzone.de ([81.169.145.166]:17562 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S261220AbUKBMfq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 07:35:46 -0500
Date: Tue, 2 Nov 2004 13:35:09 +0100
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: dhowells@redhat.com
Cc: cpufreq@www.linux.org.uk, davej@redhat.com, linux-kernel@vger.kernel.org,
       uclinux-dev@uclinux.org
Subject: FRV and CPU frequency scaling
Message-ID: <20041102123509.GA8259@dominikbrodowski.de>
Mail-Followup-To: dhowells@redhat.com, cpufreq@www.linux.org.uk,
	davej@redhat.com, linux-kernel@vger.kernel.org,
	uclinux-dev@uclinux.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While reading through the FRV Documentation patch I stumbled across the file
"clock.txt" file which says:

+ (*) clock.txt
+
+     A description of the CPU clock scaling interface.
+

Could you use the generic cpufreq core (drivers/cpufreq/) for this, please?

And could you explain the difference between p0, cm and cmode settings to
me, and how they can be combined, please? Or is the following assumption 
correct?

The CPU core frequency can only be modified on FR405 CPUs, while p0 and cm 
are available on all CPUs and allow for modification of the frequency of 
some sort of external busses.

Thanks,
	Dominik
