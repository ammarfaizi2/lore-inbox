Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261755AbVBSRlb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbVBSRlb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 12:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261749AbVBSRlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 12:41:31 -0500
Received: from wylie.me.uk ([82.68.155.89]:27801 "EHLO mail.wylie.me.uk")
	by vger.kernel.org with ESMTP id S261712AbVBSRl1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 12:41:27 -0500
From: "Alan J. Wylie" <alan@wylie.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16919.31301.949779.355723@wylie.me.uk>
Date: Sat, 19 Feb 2005 17:41:25 +0000
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       EC <wingman@waika9.com>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: 2.4.29-pre1 OOPS early in boot with Intel ICH5 SATA controller
In-Reply-To: <4217786C.2060603@pobox.com>
References: <16824.8109.697757.673632@devnull.wylie.me.uk>
	<41BB41DC.6020808@pobox.com>
	<16829.29661.747368.799519@devnull.wylie.me.uk>
	<41BD7866.4010009@pobox.com>
	<16829.34517.689764.245416@devnull.wylie.me.uk>
	<4217786C.2060603@pobox.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Feb 2005 12:33:32 -0500, Jeff Garzik <jgarzik@pobox.com> said:

>>> Is it possible for you to enable the following two #ifdefs in
>>> include/linux/libata.h, and send me the output?
>>
>>> #define ATA_DEBUG /* debugging output */ #define ATA_VERBOSE_DEBUG
>>> /* yet more debugging output */
>> 
>> 
>> (Hand transcribed - E&OE)
>> 
>> ksymoops output below.

> Can you confirm that this is fixed in 2.4.30-pre1?

Sorry - I worked around the problem by setting the BIOS to "Native
Mode", and the boxes that were showing the problem (Supermicro X6DA8)
have now been shipped out to customers, where I can no longer do any
debugging on them.


-- 
Alan J. Wylie                                          http://www.wylie.me.uk/
"Perfection [in design] is achieved not when there is nothing left to add,
but rather when there is nothing left to take away."
  -- Antoine de Saint-Exupery
