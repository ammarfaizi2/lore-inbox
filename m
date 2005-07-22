Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261836AbVGVAUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbVGVAUc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 20:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbVGVAUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 20:20:32 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:34986 "EHLO
	pd2mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S261836AbVGVAUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 20:20:30 -0400
Date: Thu, 21 Jul 2005 18:15:05 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: kernel page size explanation
In-reply-to: <4sSO3-58H-13@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <42E03A89.1040603@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <4sSO3-58H-13@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gaspar Bakos wrote:
> Hi,
> 
> Sorry for this nursery-school question.
> 
> Could someone briefly explain me :
> 1. what is the kernel page size (any _useful_ pointer on the web is fine),
> 2. how can one tune it (for 2.6.*)?
> 3. what kind of effect does it have on system performance, if it is
> tuneable, and if it worth changing this at all?

This is dependent on the hardware, not really the OS. On x86 the 
normally used page size is 4KB. 4MB pages are also supported but are 
usually used only for special purposes (ex: hugetlbfs).

As you mentioned some other architectures like Itanium support different 
page sizes.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

