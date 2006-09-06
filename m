Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030252AbWIFXtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030252AbWIFXtM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 19:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030254AbWIFXtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 19:49:12 -0400
Received: from smtp111.iad.emailsrvr.com ([207.97.245.111]:20871 "EHLO
	smtp141.iad.emailsrvr.com") by vger.kernel.org with ESMTP
	id S1030252AbWIFXtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 19:49:11 -0400
Message-ID: <44FF5E90.9030808@gentoo.org>
Date: Wed, 06 Sep 2006 19:49:36 -0400
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060818)
MIME-Version: 1.0
To: Stian Jordet <liste@jordet.net>, sergio@sergiomb.no-ip.org
CC: akpm@osdl.org, jeff@garzik.org, greg@kroah.com, cw@f00f.org,
       bjorn.helgaas@hp.com, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, harmon@ksu.edu, len.brown@intel.com,
       vsu@altlinux.ru
Subject: Re: [NEW PATCH] VIA IRQ quirk behaviour change
References: <20060906020429.6ECE67B40A0@zog.reactivated.net>	 <44FE8EBA.4060104@jordet.net>  <44FCE36D.4000708@gentoo.org> <1157557765.5091.1.camel@localhost.localdomain>
In-Reply-To: <1157557765.5091.1.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stian Jordet wrote:
> On man, 2006-09-04 at 22:39 -0400, Daniel Drake wrote:
>> Stian Jordet wrote:
>>> Daniel Drake wrote:
>>>> Stian Jordet: You're on CC due to a discussion linked to from above where
>>>> it appeared that you needed Bjorn's patch. Please test this patch against
>>>> unmodified 2.6.17 or 2.6.18-rc and let us know if there are any problems.
>>>>
>>> No more usb for me with this patch :P
>> Please send dmesg from both a working kernel and a patched kernel, and 
>> /proc/interrupts from both too.
> 
> Here dmesg and /proc/interrupts with and without the patch. Both are
> 2.6.18-rc6...

Sergio,

Stian appears to be walking proof that quirks are sometimes required in 
IO-APIC mode.

My next move would be to modify the patch to not revert Bjorn's changes 
(but leave Linus' modification in place, alongside the southbridge 
detection). Any thoughts?

Daniel

