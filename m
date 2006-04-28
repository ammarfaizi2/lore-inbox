Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030339AbWD1JeG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030339AbWD1JeG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 05:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030340AbWD1JeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 05:34:05 -0400
Received: from gateway.argo.co.il ([194.90.79.130]:15117 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S1030339AbWD1JeE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 05:34:04 -0400
Message-ID: <4451E185.9030107@argo.co.il>
Date: Fri, 28 Apr 2006 12:33:57 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Davi Arnaut <davi.lkml@gmail.com>
CC: Willy Tarreau <willy@w.ods.org>, Denis Vlasenko <vda@ilport.com.ua>,
       dtor_core@ameritech.net, Kyle Moffett <mrmacman_g4@mac.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Compiling C++ modules
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com>	 <d120d5000604251028h67e552ccq7084986db6f1cdeb@mail.gmail.com>	 <444E61FD.7070408@argo.co.il> <200604271810.07575.vda@ilport.com.ua>	 <20060427201531.GH13027@w.ods.org> <750c918d0604271408y2afef6fflf380e4d0a6c1cec6@mail.gmail.com>
In-Reply-To: <750c918d0604271408y2afef6fflf380e4d0a6c1cec6@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Apr 2006 09:34:03.0102 (UTC) FILETIME=[E2EE47E0:01C66AA6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davi Arnaut wrote:
>>
>> Mozilla is written in C++ ? I start to better understand where the
>> 160 MB bloat comes from...
>>     
>
> Evolution is written in C.
>   

FWIW, userspace is moving away from C as unproductive and unsafe. KDE is 
of course C++, mozilla, openoffice are C++, and gnome is moving towards 
(of all things) C#.

GCC considered adopting a C++ subset. My impressions of the discussion 
was that (a) a majority of the developers would like that (b) RMS would 
never allow it (c) there were concerns about bootstrap on platforms 
where a C++ compiler was not available.

Kernels of other operating systems (Windows, AIX (?)) allow C++. And 
don't start about Windows crashing whenever you sneeze at it - it's so 1998.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

