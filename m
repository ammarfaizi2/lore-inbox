Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262659AbVCPQFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262659AbVCPQFh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 11:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262661AbVCPQFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 11:05:36 -0500
Received: from info.elf.stuba.sk ([147.175.111.14]:57864 "EHLO
	info.elf.stuba.sk") by vger.kernel.org with ESMTP id S262659AbVCPQFU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 11:05:20 -0500
Message-ID: <42385A65.7060604@kasr.elf.stuba.sk>
Date: Wed, 16 Mar 2005 17:10:13 +0100
From: peto <fodrek@kasr.elf.stuba.sk>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: regatta <regatta@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 32Bit vs 64Bit
References: <5a3ed5650503160744730b7db4@mail.gmail.com>
In-Reply-To: <5a3ed5650503160744730b7db4@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned: by AntiVirus filter AVilter (msg.KTdhWGOc@delta.elf.stuba.sk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



regatta wrote:

>Hi everyone,
>
>I have a question about the 64Bit mode in AMD 64bit
>
>My question is if I run a 32Bit application in Optreon AMD 64Bit with
>Linux 64Bit does this give my any benefit ? I mean running 32Bit
>application in 64Bit machine with 64 Linux is it better that running
>it in 32Bit or doesn't make any different at all ?
>  
>
It differs on type of the  appliction you used. measured values in Linux
shows that x86-64 64 bit app+OS+CPU have performance from 120% to 500% 
of the performance of the 32 bit conterpart

in MS OS it is x86-64   as 80%-190% of the 32 bit MS OS

It is because pointer manipultaion takes longer time because of higer 
width od the 64 bit pointers but 64 bit multiplication is 6 times faster 
no x86-64 system then in 32 bit system and in Windows there is tragic 
memory management tak causes higher pointer manipulation. But there are 
pracitcaly no anothere performance differency in both architectures


Yours faithfuly
Peter Fodrek


