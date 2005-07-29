Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262843AbVG2Wdc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262843AbVG2Wdc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 18:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbVG2Wbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 18:31:40 -0400
Received: from mail.dvmed.net ([216.237.124.58]:62930 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262899AbVG2W3y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 18:29:54 -0400
Message-ID: <42EAADDC.1010505@pobox.com>
Date: Fri, 29 Jul 2005 18:29:48 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: jason.d.gaston@intel.com, mj@ucw.cz, linux-kernel@vger.kernel.org,
       gregkh@suse.de
Subject: Re: [PATCH 2.6.13-rc4 1/1] pci_ids: patch for Intel ICH7R
References: <26CEE2C804D7BE47BC4686CDE863D0F5046EA44B@orsmsx410>	<42EAABD1.8050903@pobox.com> <20050729152648.2c2fe390.akpm@osdl.org>
In-Reply-To: <20050729152648.2c2fe390.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>>[speaking to the audience]  I wouldn't mind if someone did a pass 
>>through pci_ids.h and removed all the constants that are not being used. 
>>  If constants are not being used, it's IMHO more appropriate to store 
>>that info in pci.ids.
> 
> 
> It looks like Greg is planning on nuking pci.ids.

 From the kernel, yes, that's been long planned.  But not from existence.

The kernel source code is an inappropriate place to store random hex 
numbers that the kernel itself does not use.

Or IOW, we shouldn't be knowingly storing dead code in linux/pci_ids.h :)

	Jeff


