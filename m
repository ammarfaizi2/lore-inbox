Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261363AbVALX6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbVALX6Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 18:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbVALXzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 18:55:52 -0500
Received: from numenor.qualcomm.com ([129.46.51.58]:21901 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id S261599AbVALXvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 18:51:02 -0500
Message-ID: <41E5B7DC.8020301@qualcomm.com>
Date: Wed, 12 Jan 2005 15:50:52 -0800
From: Max Krasnyansky <maxk@qualcomm.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [BK] TUN/TAP driver update and fixes for 2.6.BK
References: <41E5A5DA.1010301@qualcomm.com> <41E5B077.8030300@pobox.com>
In-Reply-To: <41E5B077.8030300@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Non-technical comments:
> 
> 1) Please send drivers/net patches to me and netdev@oss.sgi.com
Ok

> 2) Consider using the bk-make-sum script (in Documentation/BK-usage/) to 
> generate your summary.  This will add a "bk pull " prefix to your BK url 
> particularly, making it even easier to cut-n-paste.
I do use bk-make-sum. A bit hacked version though which does not add
'bk pull' prefix. I'll put it back in if it's useful for folks.

> 3) Please include a patch in your submission so that list readers may 
> review your changes, not just the BK users.
Anybody can go to bkbits.net and review them. I'd rather not send
patches along with BK stuff, unless that's a new rule or something :).

> Technical comments:
> 
> 2) in your implementation of tun_get_drvinfo(), it may be nice to 
> include the tun/tap interface number in info->bus_info, to differentiate 
> between multiple tun interfaces or multiple tap interfaces.
> 
> 3) You might consider moving tun_set_msglevel() completely inside 
> TUN_DEBUG ifdef.
> 
> 4) use of MODULE_VERSION() is recommended
Good points.

Thanks
Max

