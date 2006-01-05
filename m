Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbWAESwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWAESwz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 13:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751886AbWAESwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 13:52:55 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:6876 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1750809AbWAESwy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 13:52:54 -0500
Date: Thu, 5 Jan 2006 19:52:06 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Ben Collins <ben.collins@ubuntu.com>,
       Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/15] Ubuntu patch sync
Message-ID: <20060105185206.GA13021@electric-eye.fr.zoreil.com>
References: <0ISL003P992UCY@a34-mta01.direcway.com> <20060104140627.1e89c185@dxpl.pdx.osdl.net> <1136412768.4430.28.camel@grayson> <Pine.LNX.4.61.0601050848570.10161@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601050848570.10161@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> :
[...]
> rt2400/etc is a bit more tricky. There exist several versions and they 
> all have different levels of evolution :-/
>  Group 1:
>  - rt* from ralink.com.tw

Too much work to merge imho.

>  Group 2:
>  - rt2400,rt2500,rt2570 "1.1.0" from sf.net/projects/rt2400
>  - rt2x00 "2.0", also sf.net/projects/rt2400


Afaiks it does not apply to the rt2x00 drivers. However these are still
strongly different from the ideal in-kernel driver. CodingStyle (arguable)
and locking - broken - would need more work. This is not yet another
80211 subsystem but it is not clear if the authors/maintainers plan to
merge their stuff in a near future.

--
Ueimor
