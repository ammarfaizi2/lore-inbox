Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751335AbWEZHPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbWEZHPJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 03:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbWEZHPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 03:15:09 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:8862 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1751335AbWEZHPH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 03:15:07 -0400
Message-ID: <4476AA43.9070203@aitel.hist.no>
Date: Fri, 26 May 2006 09:12:03 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       Matheus Izvekov <mizvekov@gmail.com>,
       "D. Hazelton" <dhazelton@enter.net>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>	 <200605230048.14708.dhazelton@enter.net>	 <9e4733910605231017g146e16dfnd61eb22a72bd3f5f@mail.gmail.com>	 <6896241F-3389-4B20-9E42-3CCDDBFDD312@mac.com>	 <44740533.7040702@aitel.hist.no> <447465C6.3090501@ums.usu.ru>	 <9e4733910605240749r1ce9e9fehcfffb2f2e3aeab60@mail.gmail.com>	 <44747432.1090906@ums.usu.ru>	 <305c16960605240915p7961ddbfye90afd3cf7fbc372@mail.gmail.com>	 <4474891D.9010205@ums.usu.ru> <9e4733910605240932s61bb124fre3ec217d69956e78@mail.gmail.com>
In-Reply-To: <9e4733910605240932s61bb124fre3ec217d69956e78@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
>>
>> Or: lock the memory in advance, to avoid the use of swap. But this is 
>> not better
>> than doing the same thing from a userspace application that shows a 
>> pop-up
>> ballon with the contents of this oops. And it won't be affected by a 
>> disk
>> failure, because it has everything already in memory.
>
> Most video hardware (99%) has enough memory to support double
> buffering. You save it to the other buffer, display the error, and
> copy it back on enter.
Graphichs memory and double buffering is nice, which is why it might
already be in use when the panic happens.  Overwriting
someone elses double buffers or fonts or textures is even worse
than overwriting the display. The latter is usually sort of fixable
with a few alt+tabs. . .

Helge Hafting


