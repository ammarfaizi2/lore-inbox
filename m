Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268340AbUHQQq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268340AbUHQQq5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 12:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268341AbUHQQq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 12:46:57 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:29889 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S268334AbUHQQqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 12:46:53 -0400
Date: Tue, 17 Aug 2004 17:45:09 +0100
From: Dave Jones <davej@redhat.com>
To: Ray Bryant <raybry@sgi.com>
Cc: Pavel Machek <pavel@ucw.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: cpufreq deprecation
Message-ID: <20040817164509.GB19243@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Ray Bryant <raybry@sgi.com>, Pavel Machek <pavel@ucw.cz>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040817105859.GA1497@elf.ucw.cz> <41221890.8070307@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41221890.8070307@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2004 at 09:39:12AM -0500, Ray Bryant wrote:
 > Pavel,
 > 
 > A scan of the lkml archives on theaimsgroup for cpufreq shows only this 
 > message about deprecation.  Where was this discussed?

Probably cpufreq list around the time cpufreq was first merged to mainline 2.6.

I never wanted to really see the proc stuff hit 2.6 at all, but
someone (maybe Dominik) suggested that as there were tools using it,
(a multitude of cpu scaling daemons appeared), we should drag it into 2.6
too, at least until the daemons caught up with the preferred interface.

It's been marked as 'deprecated' since day one of its inclusion.
All the userspace tools that are actually decent enough to use
are aware of the 2.6 interface, and will use those rather than the
/proc interface.

 > Is there an alternative for this information being proposed?

sysfs.

		Dave

