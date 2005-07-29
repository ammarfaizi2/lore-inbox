Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262322AbVG2EZt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262322AbVG2EZt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 00:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262324AbVG2EZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 00:25:49 -0400
Received: from mail.dvmed.net ([216.237.124.58]:20430 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262322AbVG2EZr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 00:25:47 -0400
Message-ID: <42E9AFC6.9010805@pobox.com>
Date: Fri, 29 Jul 2005 00:25:42 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Yaroslav Halchenko <kernel@onerussian.com>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8 -> 2.6.11 (+ata-dev patch) -- HDD is always on
References: <20050729041031.GU16285@washoe.onerussian.com>
In-Reply-To: <20050729041031.GU16285@washoe.onerussian.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yaroslav Halchenko wrote:
> I've been running debian stable with 2.6.8 kernel but due to recent
> failure of the SATA harddrive I've decided to upgrade to 2.6.11 + libata
> patch (2.6.11-libata-dev1.patch.gz) and recent smartmontools
> 
> After everything worked out and I decided to rest in piece but I've
> found that HDD LED light nomater what. It seems to turn off during BIOS
> checks and then kicks in 1-2 secs after kernel starts booting. No
> prominent harddrive activity noise can be heard but this drive is
> quite silent so it is hard to say.

Does this happen in unpatched 2.6.12.3 or 2.6.13-rc4?


> QUESTION: 
> 
> LED constantly ON - does it signal about a problem or may be just
> that some status bit is hanging? Should I worry and try differen kernel
> version?
> 
> YIKES: ran hddtemp /dev/sda and whole box hanged... SysRq keys - no
> effect... heh heh... reboot -> nothing in logs

> P.S. was ata-dev patch incorporated in recent kernel versions so I could
> use SMART with vanilla kernel?

This is one of the reasons why SMART support is not yet in the mainline 
kernel!

	Jeff


