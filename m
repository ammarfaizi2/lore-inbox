Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265568AbUABN1F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 08:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265570AbUABN1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 08:27:05 -0500
Received: from firewall.conet.cz ([213.175.54.250]:32667 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S265568AbUABN07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 08:26:59 -0500
Message-ID: <3FF571A2.8050505@conet.cz>
Date: Fri, 02 Jan 2004 14:26:58 +0100
From: Libor Vanek <libor@conet.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matti Aarnio <matti.aarnio@zmailer.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Syscall table AKA hijacking syscalls
References: <3FF56B1C.1040308@conet.cz> <20040102130847.GE2785@mea-ext.zmailer.org>
In-Reply-To: <20040102130847.GE2785@mea-ext.zmailer.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matti Aarnio wrote:

>On Fri, Jan 02, 2004 at 01:59:08PM +0100, Libor Vanek wrote:
>  
>
>>Hi,
>>I'm writing some project which needs to hijack some syscalls in VFS 
>>layer. AFAIK in 2.6 is this "not-wanted" solution (even that there are 
>>    
>>
>...
>  
>
>>So what is proper (Linus recommanded) way to do such a things? Create 
>>patches for specific syscalls like "if this_module_installed then 
>>call_this_function;" or try to force things like syscalltrack to go into 
>>vanilla kernel some time? Because what I've found out there are more 
>>projects which suffer from this restriction.
>>    
>>
>
>
>There is, of course, whole slew of politically coloured
>issues with this chainability.
>  
>

I think that issues with chainability are ALWAYS whenever you try to do 
this hijacking general.


-- 

Libor Vanek




