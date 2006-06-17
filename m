Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932486AbWFQAFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932486AbWFQAFL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 20:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbWFQAFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 20:05:11 -0400
Received: from smtp.blackdown.de ([213.239.206.42]:64404 "EHLO
	smtp.blackdown.de") by vger.kernel.org with ESMTP id S932486AbWFQAFI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 20:05:08 -0400
From: Juergen Kreileder <jk@blackdown.de>
To: "Michael Chan" <mchan@broadcom.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: tg3 timeouts with 2.6.17-rc6
References: <1551EAE59135BE47B544934E30FC4FC041BD16@NT-IRVA-0751.brcm.ad.broadcom.com>
	<87k67glrvl.fsf@blackdown.de> <1150494161.26368.39.camel@rh4>
X-PGP-Key: http://blackhole.pca.dfn.de:11371/pks/lookup?op=get&search=0x730A28A5
X-PGP-Fingerprint: 7C19 D069 9ED5 DC2E 1B10  9859 C027 8D5B 730A 28A5
Mail-Followup-To: "Michael Chan" <mchan@broadcom.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Date: Sat, 17 Jun 2006 02:05:01 +0200
In-Reply-To: <1150494161.26368.39.camel@rh4> (Michael Chan's message of "Fri,
	16 Jun 2006 14:42:41 -0700")
Message-ID: <87bqsslk9e.fsf@blackdown.de>
Organization: Blackdown Java-Linux Team
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Chan <mchan@broadcom.com> writes:

> On Fri, 2006-06-16 at 23:20 +0200, Juergen Kreileder wrote:
>> Michael Chan <mchan@broadcom.com> writes:
>>
>>>
>>> Did this use to work with an older kernel or older tg3 driver? If
>>> yes, what version?
>>
>> Works fine with 2.6.16 and earlier.
>>
>>> Please also provide the full tg3 probing output during modprobe
>>> and ifconfig up. Thanks.
>>
> Looking at the patch history since 2.6.16, the only patch that could
> have an impact is the one that enables TSO by default.
>
> Please try turning TSO off to see if it makes a difference:
>
> ethtool -K eth0 tso off

Seems to work fine with TSO disabled.


        Juergen

-- 
Juergen Kreileder, Blackdown Java-Linux Team
http://blog.blackdown.de/
