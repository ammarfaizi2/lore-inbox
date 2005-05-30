Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261663AbVE3SES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261663AbVE3SES (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 14:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbVE3SES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 14:04:18 -0400
Received: from mail.dvmed.net ([216.237.124.58]:23275 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261663AbVE3SD5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 14:03:57 -0400
Message-ID: <429B5586.8040004@pobox.com>
Date: Mon, 30 May 2005 14:03:50 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Clemente Aguiar <caguiar@madeiratecnopolo.pt>
CC: linux-kernel@vger.kernel.org
Subject: Re: Adaptec AIC-79xx HostRaid
References: <6A0C419392D7BA45BD141D0BA4F253C776F2@loureiro.madeiratecnopolo.pt>
In-Reply-To: <6A0C419392D7BA45BD141D0BA4F253C776F2@loureiro.madeiratecnopolo.pt>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clemente Aguiar wrote:
>>On Mon, May 30, 2005 at 06:13:03PM +0100, Clemente Aguiar wrote:
>>
>>>Hello,
>>>
>>>We have acquired some IBM xServers which have an integrated raid
> 
> controller
> 
>>>based on the Adaptec AIC-79xx U320 SCSI controller (called HostRaid).
>>>
>>>Is there already support for HostRaid? Are there drivers for it?
>>>>From which kernel version and where do I find it in the config?
>>
>>HostRaid is just software RAID; you can ignore it and let Linux use the
>>underlying SCSI devices via the standard aic79xx driver.
>>
>>	Jeff
> 
> 
> What do you mean it is just software RAID? Can you explain?
> On the servers there is a configuration option to enable HostRaid, and when
> I turn that option ON the mirroring between the two discs start and after a
> while they are mirrored.
> I think that in terms of performance it should be better to used the
> "on-board" HostRaid facility.
> Don't you think so?

HostRaid is not on-board.  It is provided by your system CPU, through 
the card's BIOS and the OS driver.

HostRaid is software RAID, just like Linux's md.

	Jeff



