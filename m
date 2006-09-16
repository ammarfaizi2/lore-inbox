Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbWIPUUH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbWIPUUH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 16:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbWIPUUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 16:20:07 -0400
Received: from main.gmane.org ([80.91.229.2]:26081 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751178AbWIPUUG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 16:20:06 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Markus Layr <tuxian@yahoo.de>
Subject: Re: [PATCH] unusual device Sony Ericsson M600i
Date: Sat, 16 Sep 2006 20:13:16 +0000 (UTC)
Message-ID: <loom.20060916T220501-329@post.gmane.org>
References: <200608290913.13875.rene@exactcode.de> <44F506FD.1000608@ipom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 193.46.41.12 (Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.2; SV1; .NET CLR 1.1.4322; InfoPath.1))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

for which kernel version is this patch usable?

I'm using gentoo-sources-2.6.17-gentoo-r8 (Linux 2.6.17.13).

My phone is a P990i and not a M600i but they are very similar.

I changed the Vendor ID from 0xe031 to 0xe030 and "M600i" to "P990i" and 
inserted the lines starting with "+" to my unusual_devs.h but I still can't see 
partitions on /dev/sda.

Maybe the problem is that I don't have this section:

       US_SC_DEVICE, US_PR_DEVICE, NULL, 
       US_FL_NO_WP_DETECT ),

in line 1257?


