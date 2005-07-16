Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263378AbVGPHGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263378AbVGPHGK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 03:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263371AbVGPHGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 03:06:10 -0400
Received: from hulk.hostingexpert.com ([69.57.134.39]:41893 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S262262AbVGPHEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 03:04:51 -0400
Message-ID: <42D8B196.8030208@m1k.net>
Date: Sat, 16 Jul 2005 03:04:54 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Hinds <dhinds@sonic.net>
CC: somshekar.c.kadam@in.abb.com, linux-kernel@vger.kernel.org
Subject: Re: Sandisk Compact Flash
References: <OFF2465F02.D3F1F2D8-ON6525703D.0049BB41-6525703D.004A8B94@in.abb.com> <20050715052139.GA7788@sonic.net>
In-Reply-To: <20050715052139.GA7788@sonic.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Hinds wrote:

>On Wed, Jul 13, 2005 at 07:04:38PM +0530, somshekar.c.kadam@in.abb.com wrote:
>  
>
>>I ma newbie to compactflash driver , I am using mpc862 PPC processor
>>on my custom board having 64mb ram running linuxppc-2.4.18 kernel .
>>i am using Sandisk Extreme CF 1GB which is 133x high speed, but
>>found the performance with other kingston 1GB CF with slower speed ,
>>is both same , CF is implemented on pcmcia port , i am not sure what
>>is the mode set for transfer , Feature set command is used in which
>>it sets the PIO mode or Multiword DMA transfer mode by specifying
>>its value in Sector count register , i am not able to understand in
>>linux kernel ide driver where this is set , is it by default set ,
>>this mode is set or we need to set it , i think we should assign
>>this value , right now i am not able to trace this in my code.  ,
>>    
>>
>It sounds like your card reader is one of the slow 16-bit ones.
>
I recommend picking up a CF-to-IDE adapter, such as this:

http://www.acscontrol.com/Index_ACS.asp?Page=/Pages/Products/CompactFlash/IDE_To_CF_Adapter.htm

...It works great for me!

There are a bunch of companies selling these... Google "cf ide adapter".

-- 
Michael Krufky

