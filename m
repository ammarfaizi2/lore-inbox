Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262217AbVAECn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262217AbVAECn6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 21:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbVAECn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 21:43:58 -0500
Received: from out004pub.verizon.net ([206.46.170.142]:33214 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP id S262217AbVAECnr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 21:43:47 -0500
Message-ID: <41DB5476.9040103@cwazy.co.uk>
Date: Tue, 04 Jan 2005 21:44:06 -0500
From: Jim Nelson <james4765@cwazy.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brian Gerst <bgerst@didntduck.org>
CC: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org
Subject: Re: [PATCH 0/7] ppc: remove cli()/sti() from arch/ppc/*
References: <20050104214048.21749.85722.89116@localhost.localdomain> <41DB4E99.3060200@didntduck.org>
In-Reply-To: <41DB4E99.3060200@didntduck.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [209.158.220.243] at Tue, 4 Jan 2005 20:43:46 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst wrote:

> James Nelson wrote:
>
>> This series of patches is to remove the last cli()/sti() function 
>> calls in arch/ppc.
>>
>> These are the only instances in active code that grep could find.
>
>
> Are you sure none of these need real spinlocks instead of just 
> disabling interrupts?
>
> -- 
>                 Brian Gerst
>
These are for single-processor systems, mostly evaluation boards and 
embedded processors.  I coudn't find any reference to multiprocessor 
setups for the processors in question after a peruse of the code or a 
quick google on the boards in question.

Jim
