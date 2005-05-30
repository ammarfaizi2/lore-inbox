Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261661AbVE3SHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbVE3SHT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 14:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261666AbVE3SGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 14:06:03 -0400
Received: from mail.dvmed.net ([216.237.124.58]:25067 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261667AbVE3SFD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 14:05:03 -0400
Message-ID: <429B55CC.1060505@pobox.com>
Date: Mon, 30 May 2005 14:05:00 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Sipek <jeffpc@optonline.net>
CC: Clemente Aguiar <caguiar@madeiratecnopolo.pt>,
       linux-kernel@vger.kernel.org
Subject: Re: Adaptec AIC-79xx HostRaid
References: <6A0C419392D7BA45BD141D0BA4F253C776F1@loureiro.madeiratecnopolo.pt> <20050530172105.GA15253@havoc.gtf.org> <20050530180156.GA32606@optonline.net>
In-Reply-To: <20050530180156.GA32606@optonline.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Sipek wrote:
> On Mon, May 30, 2005 at 01:21:05PM -0400, Jeff Garzik wrote:
> 
>>On Mon, May 30, 2005 at 06:13:03PM +0100, Clemente Aguiar wrote:
>>
>>>Hello,
>>>
>>>We have acquired some IBM xServers which have an integrated raid controller
>>>based on the Adaptec AIC-79xx U320 SCSI controller (called HostRaid).
>>>
>>>Is there already support for HostRaid? Are there drivers for it?
>>>>From which kernel version and where do I find it in the config?
>>
>>HostRaid is just software RAID; you can ignore it and let Linux use the
>>underlying SCSI devices via the standard aic79xx driver.
> 
> 
> As far as I know, it is software raid done much closer to the hw than
> the linux sw raid (md).

software RAID is software RAID.

It makes no difference whether you embed the RAID software in the 
Adaptec driver or make it a separate module.

	Jeff



