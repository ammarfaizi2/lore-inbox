Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262138AbUFCLaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbUFCLaV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 07:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262605AbUFCLaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 07:30:21 -0400
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:47323 "EHLO
	smtp-out5.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S262138AbUFCLaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 07:30:16 -0400
Message-ID: <40BF0BC6.4090001@blueyonder.co.uk>
Date: Thu, 03 Jun 2004 12:30:14 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc2-mm1
References: <40BDD8AC.8080706@blueyonder.co.uk> <20040602212803.0ae212ba.akpm@osdl.org>
In-Reply-To: <20040602212803.0ae212ba.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Jun 2004 11:30:17.0776 (UTC) FILETIME=[257A9300:01C4495E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Sid Boyce <sboyce@blueyonder.co.uk> wrote:
>  
>
>>As with 2.6.7-rc1-mm1, I'm seeing the same problem on 2.6.7-rc2-mm1. 
>> 2.6.7-rc1 and 2.6.7-rc2 are OK. It hangs needing a hard reset setting up 
>> /dev/pts, with console=ttyS1 .... same as before. SuSE 9.1 on A7N8X-E 
>> nforce2 chipset.
>>    
>>
>
>Works OK here.  Is it the `console=ttyS1' which is causing the hang?  If
>not, what?  Try removing boot options, stripping config options, etc.
>
>
>
>  
>
It just freezes, I then use console=ttyS1 simply to capture the 
messages. SYSRQ does nothing and the only way out is to press the reset 
switch. I shall try 2.6.7-rc2-mm2 later with different and with no 
commandline options if it also freezes.
I start with the same basic .config for all kernels (make oldconfig)  
and grub is setup as below, 2.6.7-rc2-mm1 freezes and 2.6.7-rc2 is fine, 
2.6.7-rc1-mm1 froze, 2.6.7-rc1 was fine.
 
title 2.6.7-rc2-mm1
    kernel (hd0,0)/boot/2.6.7-rc2-mm1 root=/dev/hda1 vga=0x31a 
splash=silent desktop hdb=ide-cd showopts

title 2.6.7-rc2
    kernel (hd0,0)/boot/2.6.7-rc2 root=/dev/hda1 vga=0x31a splash=silent 
desktop hdb=ide-cd showopts

Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
Linux Only Shop.

