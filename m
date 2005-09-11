Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964814AbVIKPYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964814AbVIKPYj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 11:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964809AbVIKPYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 11:24:39 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:49354 "EHLO
	mta08-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S964806AbVIKPYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 11:24:38 -0400
Message-ID: <43244C33.1050502@gentoo.org>
Date: Sun, 11 Sep 2005 16:24:35 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050820)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steve Kieu <haiquy@yahoo.com>
Cc: Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org,
       Netdev List <netdev@vger.kernel.org>
Subject: Re: Very strange Marvell/Yukon Gigabit NIC networking problems
References: <20050901212110.19192.qmail@web53605.mail.yahoo.com>
In-Reply-To: <20050901212110.19192.qmail@web53605.mail.yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Steve Kieu wrote:
> If run 2.6.13 and up the NIC, it is working. Shuttdown
> or reboot using /sbin/halt (means power completely off
> and on) or /sbin/reboot all other OSs failed to enable
> the NIC except 2.6.13.
> 
> to restore the normal working of the NIC, boot 2.6.13
> and do a hot power reset. (press the reset button)

Stephen recently posted a patch which looks like it might solve this issue.

Steve, maybe you could test it out? I have attached it to this Gentoo bug:

	http://bugs.gentoo.org/100258

Stephen, thanks for your hard work!
Daniel
