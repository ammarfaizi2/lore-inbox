Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423146AbWKHUgD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423146AbWKHUgD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 15:36:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423510AbWKHUgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 15:36:03 -0500
Received: from pne-smtpout3-sn2.hy.skanova.net ([81.228.8.111]:23743 "EHLO
	pne-smtpout3-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1423146AbWKHUgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 15:36:00 -0500
Date: Wed, 8 Nov 2006 22:35:46 +0200
From: Riku Voipio <riku.voipio@iki.fi>
To: Martin Michlmayr <tbm@cyrius.com>
Cc: romieu@fr.zoreil.com, linux-kernel@vger.kernel.org, buytenh@wantstofly.org
Subject: Re: r8169 mac address change (was Re: [0/3] 2.6.19-rc2: known regressions)]
Message-ID: <20061108203546.GA32247@kos.to>
References: <20061107115940.GA23954@unjust.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061107115940.GA23954@unjust.cyrius.com>
X-message-flag: Warning: message not sent with a DRM-Certified client
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Lennert, I have compared 2.6.19-rc4 + 0001-r8169-perform-a-PHY-reset-etc
> with the serie of patches against 2.6.18-rc4 which was reported to work
> on your n2100 (thread on netdev around 05/09/2006). Can you:
> 
> - apply the patch below on top of 2.6.19-rc4 + 0001 and see if it works ?
>   Don't apply 0002, it is not required.

I took 2.6.19-rc5 as there was no changes in this driver relative to -rc4. 
applied Francois's 0001-r8169-perform-a-PHY-reset.. and finally the
patch in this mail. And networking _does_not_ work on Thecus N2100.

mii-tool sees the link being connected and disconnected, but dhcp or ping
with static ip goes nowhere.

