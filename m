Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268586AbUHLPRO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268586AbUHLPRO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 11:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268587AbUHLPRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 11:17:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26802 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268586AbUHLPRN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 11:17:13 -0400
Message-ID: <411B89EA.3040400@pobox.com>
Date: Thu, 12 Aug 2004 11:16:58 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Clem Taylor <clemtaylor@comcast.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Any news on a higher performance sata_sil SIL_QUIRK_MOD15WRITE
 workaround?
References: <411AFD2C.5060701@comcast.net>  <411B118B.4040802@pobox.com> <1092312030.21994.25.camel@localhost.localdomain>
In-Reply-To: <1092312030.21994.25.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Iau, 2004-08-12 at 07:43, Jeff Garzik wrote:
> 
>>Older Seagates cannot cope with this unique, but spec-correct behavior.
>>
>>This issue cannot even be worked around with "nblocks % 15 == 1", as was 
>>previously thought.  Using that formula just makes the problem harder to 
>>reproduce.
> 
> 
> It fixes it completely on the drivers/ide driver.

SATA bus traces say otherwise.

	Jeff


