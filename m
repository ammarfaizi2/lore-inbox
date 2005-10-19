Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751524AbVJSFkk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524AbVJSFkk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 01:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751530AbVJSFkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 01:40:40 -0400
Received: from tus-gate1.raytheon.com ([199.46.245.230]:16616 "EHLO
	tus-gate1.raytheon.com") by vger.kernel.org with ESMTP
	id S1751524AbVJSFkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 01:40:39 -0400
Message-ID: <4355DC52.6000202@raytheon.com>
Date: Tue, 18 Oct 2005 22:40:34 -0700
From: Robert Crocombe <rwcrocombe@raytheon.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050611)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.14-rc4-rt9: lpptest removed?
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When using 'make menuconfig' for 2.6.14-rc4-rt7, the option for:

Parallel Port Based Latency Measurement Device

is available (CONFIG_LPPTEST).

When using 'make menuconfig' for 2.6.14-rc4-rt9, this option doesn't 
appear to exist.  From the thread, it looks like the changes were minor, 
so was an accident?  Although, diffing the patches, nothing leaps out at 
me, so perhaps I'm mistaken somehow?

I threw a 'CONFIG_LPPTEST=m' into the newer kernel's .config to see what 
would happen.  No lpptest.ko was produced :(.

Please 'CC': not subscribed.

-- 
Robert Crocombe
rwcrocombe@raytheon.com
