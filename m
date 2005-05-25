Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262331AbVEYHFf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262331AbVEYHFf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 03:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262298AbVEYHBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 03:01:08 -0400
Received: from fmr16.intel.com ([192.55.52.70]:49348 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S262302AbVEYG60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 02:58:26 -0400
Subject: Re: [0/5] Improvements to the ieee80211 layer
From: Zhu Yi <yi.zhu@intel.com>
To: Jiri Benc <jbenc@suse.cz>
Cc: NetDev <netdev@oss.sgi.com>, LKML <linux-kernel@vger.kernel.org>,
       jgarzik@pobox.com, pavel@suse.cz
In-Reply-To: <20050524150711.01632672@griffin.suse.cz>
References: <20050524150711.01632672@griffin.suse.cz>
Content-Type: text/plain
Organization: Intel Corp.
Date: Wed, 25 May 2005 14:55:16 +0800
Message-Id: <1117004116.3737.30.camel@debian.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-24 at 15:07 +0200, Jiri Benc wrote:
> The ieee80211 layer, now present in -mm, lacks many important features
> (actually it's just a part of the ipw2100/ipw2200 driver; these cards do
> a lot of the processing in the hardware/firmware and thus the layer
> currently can not be used for simpler devices).
> 
> This is the first series of patches that try to convert it to a generic
> IEEE 802.11 layer, usable for most of today's wireless cards.
> 
> The long term plan is:
> - to implement a complete 802.11 stack in the kernel, making it easy to
>   write drivers for simple (cheap) devices
> - to implement all of Ad-Hoc, AP and monitor modes in the layer, so it
>   will be easy to support them in the drivers
> - to integrate Wireless Extensions to unify the kernel-userspace
>   interface of all the drivers

Do you just clean up current ieee80211 code to still do 802.11 <-> 802.3
conversion inside the driver or you plan to handle real 802.11 frames in
the stack like this?
http://oss.sgi.com/archives/netdev/2005-03/msg01405.html

Thanks,
-yi

