Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271831AbTG2PTd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 11:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271833AbTG2PTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 11:19:33 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:25871 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S271831AbTG2PTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 11:19:31 -0400
Message-ID: <3F2692FF.7050108@techsource.com>
Date: Tue, 29 Jul 2003 11:30:07 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Daniel Phillips <phillips@arcor.de>, Andrew Morton <akpm@osdl.org>,
       ed.sweetman@wmich.edu, eugene.teo@eugeneteo.net,
       linux-kernel@vger.kernel.org
Subject: Re: Ingo Molnar and Con Kolivas 2.6 scheduler patches
References: <1059211833.576.13.camel@teapot.felipe-alfaro.com> <200307271517.55549.phillips@arcor.de> <3F267CF9.40500@techsource.com> <200307292357.19647.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Con Kolivas wrote:
> On Tue, 29 Jul 2003 23:56, Timothy Miller wrote:
> 

> 
>>interactive processing in the desired time.  I don't think we should be
>>making scheduler tweaks to fix this corner case because it's impossible
>>to fix, no?
> 
> 
> Your concerns are well founded. However neither Ingo nor I (and all the other 
> contributors) are trying to make an audio app scheduler. At some stage a 
> modification will be made to the mainline kernel which will have adequate 
> audio performance in many (but not all) settings, and more importantly be 
> fair and interactive.
> 


For this case, I wasn't concerned with audio but with any combination of 
interactive tasks.  That is, if you have enough interactive tasks going 
on on a slow machine, you're going to get audio skips and other 
interactivity problems and just have to live with it.


