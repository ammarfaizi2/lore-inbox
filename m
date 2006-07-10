Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422644AbWGJSeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422644AbWGJSeN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 14:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422749AbWGJSeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 14:34:13 -0400
Received: from mga02.intel.com ([134.134.136.20]:7759 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1422644AbWGJSeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 14:34:11 -0400
X-IronPort-AV: i="4.06,223,1149490800"; 
   d="scan'208"; a="63043774:sNHT1566116776"
Message-ID: <44B29C8A.8090405@intel.com>
Date: Mon, 10 Jul 2006 11:29:30 -0700
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.4 (X11/20060617)
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Pavel Machek <pavel@ucw.cz>, yi.zhu@intel.com, jketreno@linux.intel.com,
       Netdev list <netdev@vger.kernel.org>, linville@tuxdriver.com,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] do not allow IPW_2100=Y or IPW_2200=Y
References: <20060710152032.GA8540@elf.ucw.cz> <44B2940A.2080102@pobox.com>
In-Reply-To: <44B2940A.2080102@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Jul 2006 18:30:14.0180 (UTC) FILETIME=[E28AF640:01C6A44E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Pavel Machek wrote:
>> Kconfig currently allows compiling IPW_2100 and IPW_2200 into kernel
>> (not as a module). Unfortunately, such configuration does not work,
>> because these drivers need a firmware, and it can't be loaded by
>> userspace loader when userspace is not running.
> 
> False, initramfs...

which would warrant some extra documentation in Kconfig explaining that this 
driver needs initramfs with firmware for it to work when compiled in the 
kernel. A link to the ipw2x00 documentation might also help.

Cheers,

Auke
