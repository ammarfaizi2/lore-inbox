Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263422AbTJBShY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 14:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263444AbTJBShY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 14:37:24 -0400
Received: from mrout1.yahoo.com ([216.145.54.171]:37127 "EHLO mrout1.yahoo.com")
	by vger.kernel.org with ESMTP id S263422AbTJBShX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 14:37:23 -0400
Message-ID: <3F7C7051.2000003@bigfoot.com>
Date: Thu, 02 Oct 2003 11:37:05 -0700
From: Erik Steffl <steffl@bigfoot.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i386; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Can't X be elemenated?
References: <Law11-F67ATnLE7P95L00001388@hotmail.com> <3F7BE886.8070401@aitel.hist.no>
In-Reply-To: <3F7BE886.8070401@aitel.hist.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> kartikey bhatt wrote:
> 
>> hey everyone who have joined this thread, my fundamental question have 
>> got
>> out of scope. I mean to say
>>
>> 1. Kernel level support for graphics device drivers.
>> 2. On top of that, one can develop complete lightweight GUI.
>> 3. Maybe kernel can provide support for event handling.
>>
>> and I still stick to my opinion that graphics card is a computer resource
>> that needs to be managed by OS   rather than 3rd party developers.
> 
> 
> The card is managed by the os - X has to ask the kernel nicely to get it.
> (Try starting another X server inside an xterm and see how
> that is refused.)

   that has nothing to do with kernel. If you are running display 0 and 
start another X (without specifying display, it default to 0) it doesn't 
work since there cannot be two servers on same machine both being 0. You 
can start another X server with different number (e.g. startx -- :1 or 
whatever number is not used yet).

	erik

