Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264956AbUD2UKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264956AbUD2UKN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 16:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264957AbUD2UKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 16:10:13 -0400
Received: from p508B630B.dip.t-dialin.net ([80.139.99.11]:62772 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S264956AbUD2UKH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 16:10:07 -0400
Date: Thu, 29 Apr 2004 22:09:27 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Tim Bird <tim.bird@am.sony.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>,
       linux-arm-kernel@lists.arm.linux.org.uk, linux-mips@linux-mips.org,
       linux-sh-ctl@m17n.org,
       CE Linux Developers List <celinux-dev@tree.celinuxforum.org>
Subject: Re: CONFIG_XIP_ROM vs. CONFIG_XIP_KERNEL
Message-ID: <20040429200927.GB20401@linux-mips.org>
References: <40915265.2050906@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40915265.2050906@am.sony.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 12:07:17PM -0700, Tim Bird wrote:

> I'm looking at some sources for kernel Execute-in-place (XIP).
> 
> I see references to CONFIG_XIP_ROM and CONFIG_XIP_KERNEL,
> in different architecture branches of the same kernel
> source tree.
> 
> Is this difference merely the result of inconsistent
> usage, or is there a functional difference between
> these two options?
> 
> I can imagine that CONFIG_XIP_ROM is intended only to
> handle XIP in ROM, and that CONFIG_XIP_KERNEL possibly
> handles additional cases like XIP in flash.  However,
> before jumping to that conclusion I thought I would
> ask if there is some intention behind the different
> config names.

Since you copied linux-mips - neither option is implemented for MIPS ...

  Ralf
