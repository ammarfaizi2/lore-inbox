Return-Path: <linux-kernel-owner+w=401wt.eu-S1030262AbXAKL7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030262AbXAKL7M (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 06:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030286AbXAKL7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 06:59:12 -0500
Received: from birgitte.twibble.org ([202.173.155.195]:51524 "EHLO
	birgitte.twibble.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030262AbXAKL7M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 06:59:12 -0500
X-Greylist: delayed 1110 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Jan 2007 06:59:11 EST
Date: Thu, 11 Jan 2007 22:40:35 +1100
From: Jamie Lenehan <lenehan@twibble.org>
To: David Brownell <david-b@pacbell.net>,
       Alessandro Zummo <alessandro.zummo@towertech.it>,
       Paul Mundt <lethal@linux-sh.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       rtc-linux@googlegroups.com
Subject: Re: [patch 2.6.20-rc3] rtc-sh correctly reports rtc_wkalrm.enabled
Message-ID: <20070111114034.GA6333@twibble.org>
References: <200701052055.06264.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701052055.06264.david-b@pacbell.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 05, 2007 at 08:55:05PM -0800, David Brownell wrote:
[...]
> An audit of the RTC driver treatment of the "enabled" flag turned
> up a handful of clear bugs; most drivers handle it the same now

Yeah, I missed the existing of the enabled flag when I added alarm
support to the driver. Your patch is fine.

> This driver has another issue:  sh_rtc_set_alarm() ignores the
> "enabled" flag, rather than using it to tell whether the alarm
> should be enabled on exit from that routine.  One at a time.  :)

I'll can take care of this.

-- 
 Jamie Lenehan <lenehan@twibble.org>
