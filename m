Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751120AbWE2CzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbWE2CzU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 22:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbWE2CzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 22:55:20 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:58668 "EHLO
	pd2mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751120AbWE2CzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 22:55:19 -0400
Date: Sun, 28 May 2006 20:55:03 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Resume stops working between 2.6.16 and 2.6.17-rc1 on Dell
 Inspiron 6000
In-reply-to: <6hF3n-4kh-1@gated-at.bofh.it>
To: Paul Dickson <dickson@permanentmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <447A6287.3050202@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <6hAGq-6t8-1@gated-at.bofh.it> <6hAQd-6ET-27@gated-at.bofh.it>
 <6hB9t-735-3@gated-at.bofh.it> <6hBsR-7sn-21@gated-at.bofh.it>
 <6hDO1-2D9-3@gated-at.bofh.it> <6hDXI-2Om-15@gated-at.bofh.it>
 <6hF3n-4kh-1@gated-at.bofh.it>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Dickson wrote:
>>> I still get the BUG message on resuming that I reported in bugzilla
>>> comment #9:
>>>     https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=185108#c9
>>> It is likely a separate bug.
>> That's ACPI doing a GFP_KERNEL allocation while resume has disabled
>> interrupts.  It won't cause much trouble and I'm pretty sure we
>> subsequently fixed that.
> 
> I don't immediately see a fix in the linux-2.6.git/log since 2.6.17-rc5
> (within the past 3 days).  I do see Mark Lord's patch.

I think Fedora has been carrying a patch for that for some time, last I 
checked they still were..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

