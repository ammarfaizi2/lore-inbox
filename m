Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265629AbUAMUy0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 15:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265635AbUAMUy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 15:54:26 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:27633 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S265629AbUAMUyY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 15:54:24 -0500
Message-ID: <40045AF6.5000905@mvista.com>
Date: Tue, 13 Jan 2004 12:54:14 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Matt Mackall <mpm@selenic.com>, kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>,
       "Amit S. Kale" <amitkale@emsyssoft.com>
Subject: Re: kgdb cleanups
References: <20040109183826.GA795@elf.ucw.cz> <3FFF2304.8000403@mvista.com> <20040110044722.GY18208@waste.org> <3FFFB3D6.1050505@mvista.com> <20040110175607.GH18208@waste.org> <400233A5.8080505@mvista.com> <20040112064923.GX18208@waste.org> <20040112094543.GA10869@elf.ucw.cz>
In-Reply-To: <20040112094543.GA10869@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> 
>>>For the internal kgdb stuff I have created kdgb_local.h which I intended to 
>>>be local to the workings of kgdb and not to contain anything a user would 
>>>need.
>>
>>Agreed, I just haven't touched it since you last mentioned it.
> 
> 
> I believe we need better name than kgdb_local.h.... Hmm, but I'm not
> sure what the name should be.

Sure.  How about kgdb_internal.h  ??

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

