Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261387AbVG1KHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbVG1KHR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 06:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbVG1KEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 06:04:41 -0400
Received: from [195.23.16.24] ([195.23.16.24]:46003 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261394AbVG1KCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 06:02:51 -0400
Message-ID: <42E8AD47.6010501@grupopie.com>
Date: Thu, 28 Jul 2005 11:02:47 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] signed char fixes for scripts
References: <1121465068l.13352l.0l@werewolf.able.es>	<1121465683l.13352l.5l@werewolf.able.es>	<20050727202757.GB31180@mars.ravnborg.org> <1122507398l.19829l.0l@werewolf.able.es>
In-Reply-To: <1122507398l.19829l.0l@werewolf.able.es>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon wrote:
> On 07.27, Sam Ravnborg wrote:
> 
>>On Fri, Jul 15, 2005 at 10:14:43PM +0000, J.A. Magallon wrote:
>>
>>>On 07.16, J.A. Magallon wrote:
>>>
>>>>On 07.15, Andrew Morton wrote:
>>>>
>>>>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc3/2.6.13-rc3-mm1/
>>>
>>>This time I did not break anything... and they shut up gcc4 ;)
>>
>>I have applied it to my tree. There still is a lot left when I compile
>>with -Wsign-compare.
> 
> All the problems are born here:
> 
> struct sym_entry {
>     unsigned long long addr;
>     unsigned int len;
>     unsigned char *sym;
> };

What are you guys talking about?

I've just compiled the current version in -mm with -Wsign-compare and it 
doesn't give me a single warning.

Is my compiler version the problem (3.3.2), or are you testing with the 
old version of kallsyms?

-- 
Paulo Marques - www.grupopie.com

It is a mistake to think you can solve any major problems
just with potatoes.
Douglas Adams
