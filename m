Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261976AbUEFKIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbUEFKIY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 06:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbUEFKIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 06:08:24 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:33545 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S261976AbUEFKIJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 06:08:09 -0400
Message-ID: <409A0EEB.9080409@aitel.hist.no>
Date: Thu, 06 May 2004 12:09:47 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3-mm2 (4KSTACK)
References: <200405051312.30626.dominik.karall@gmx.net> <20040505043002.2f787285.akpm@osdl.org> <c7bin8$fg7$1@gatekeeper.tmr.com>
In-Reply-To: <c7bin8$fg7$1@gatekeeper.tmr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:

> Andrew Morton wrote:
>
>>
>> We need to push this issue along quickly.  The single-page stack 
>> generally
>> gives us a better kernel and having the stack size configurable creates
>> pain.
>
>
> Add my voice to those who don't think 4k stacks are a good idea as a 
> default, they break some things and seem to leave other paths (as 
> others have noted) on the edge. I'm not sure what you have in mind as 
> a "better kernel" but I'd rather have a worse kernel and not have to 
> check 4k stack as a possible problem before looking at other things if 
> I get bad behaviour. 

I think 4k stacks is perfectly ok for mm, as mm is an experimental
testing ground anyway.  Not everything in mm goes into the next 2.6.x.


Wether 4k goes into some 2.6 release or waits for 2.7 is another debate.

Helge Hafting
