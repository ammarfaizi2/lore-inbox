Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266595AbUHIOcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266595AbUHIOcd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 10:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266674AbUHIOcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 10:32:09 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:13965 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S266595AbUHIO36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 10:29:58 -0400
Date: Mon, 9 Aug 2004 15:28:19 +0100
From: Dave Jones <davej@redhat.com>
To: Michael Clark <michael@metaparadigm.com>
Cc: jeremy@goop.org, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] - Initial dothan speedstep support
Message-ID: <20040809142819.GD21238@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Michael Clark <michael@metaparadigm.com>, jeremy@goop.org,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <41131120.5060202@metaparadigm.com> <411365C9.5020909@metaparadigm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <411365C9.5020909@metaparadigm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2004 at 07:04:41PM +0800, Michael Clark wrote:
 > On 08/06/04 13:03, Michael Clark wrote:
 > >Hi All,
 > >
 > >Was looking for a patch for Dothan cpufreq support but could only
 > >find the stepping identification code here:
 > >
 > >ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm6/broken-out/bk-cpufreq.patch 
 > 
 > I've since found there is a newer speedstep-centrino in 2.6.8-rc3-mm1
 > although still without dothan support but slight changes for more
 > informative messages about steppings without needed table support.
 > 
 > So i've rediffed table support for dothan b0 steppings to 2.6.8-rc3-mm1

Merged, thanks.
I've accumulated quite a lot of changes in the cpufreq bk tree
(around 30 csets), and Linus didn't respond the last time I asked
him to merge, so it may be he feels theres too much change
for an RC -> Final transition.  I'll send a pull request again
when 2.6.9 opens up.

		Dave

