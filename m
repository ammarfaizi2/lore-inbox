Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268148AbUIAV1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268148AbUIAV1U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 17:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268147AbUIAVXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 17:23:16 -0400
Received: from mx1.nersc.gov ([128.55.6.21]:36790 "EHLO mx1.nersc.gov")
	by vger.kernel.org with ESMTP id S268141AbUIAVWX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 17:22:23 -0400
Message-ID: <41363D89.2070604@lbl.gov>
Date: Wed, 01 Sep 2004 14:22:17 -0700
From: Thomas Davis <tadavis@lbl.gov>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040608
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stuart Young <cef-lkml@optusnet.com.au>
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com
Subject: Re: 2.6.9-rc1 : Weirdness after shutdown - ACPI or Suspend bug?
References: <200409012020.42482.cef-lkml@optusnet.com.au> <200409012352.21576.cef-lkml@optusnet.com.au>
In-Reply-To: <200409012352.21576.cef-lkml@optusnet.com.au>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stuart Young wrote:
> On Wed, 1 Sep 2004 20:20, Stuart Young wrote:
> 
>>OK, this one is weirding me out.
>>
>>Note that when using 2.6.8.1 all is fine. The following situation only
>>happens in 2.6.9-rc1 or later.
>>
>>If I shutdown my laptop (ie: halt) it goes through the motions and
>>everything goes off. If the lid switch changes state AFTER powerdown, the
>>laptop starts up. Removing AC power, or with AC power connected and
>>removing the battery does not trigger this, just seemingly the lid switch.
>>This works on lid close, AND lid open.
> 

Interesting - I'm playing with a Sony VAIO S170p, and when you use shutdown -h, it turns off and turning it back on appears to be fine.

HOWEVER, using swsusp2, hibernating the machine works, but it refuses to wake back up until you pull the AC power and battery out.

thomas
