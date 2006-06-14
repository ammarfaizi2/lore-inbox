Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932295AbWFNU6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbWFNU6F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 16:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbWFNU6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 16:58:05 -0400
Received: from jellep.xs4all.nl ([80.126.151.229]:63349 "EHLO turin.jellep.net")
	by vger.kernel.org with ESMTP id S932295AbWFNU6E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 16:58:04 -0400
Message-ID: <4490784A.2080203@vanbest.org>
Date: Wed, 14 Jun 2006 22:57:46 +0200
From: Jan-Pascal van Best <janpascal@vanbest.org>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Andrew Morton <akpm@osdl.org>,
       Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm] NI5010 netcard cleanup (was: Re: NI5010 network driver
 -- MAINTAINERS entry)
References: <20060613190658.GA396@rhlx01.fht-esslingen.de> <200606132027.k5DKR6ie015928@laptop11.inf.utfsm.cl> <20060614192853.GB19938@rhlx01.fht-esslingen.de>
In-Reply-To: <20060614192853.GB19938@rhlx01.fht-esslingen.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Mohr wrote:
> Hi,
>
> On Tue, Jun 13, 2006 at 04:27:06PM -0400, Horst von Brand wrote:
>   
>> Andreas Mohr <andi@rhlx01.fht-esslingen.de> wrote:
>>
>> [...]
>>
>>     
>>> @@ -47,7 +43,7 @@
>>>   *			-DMODULE -c ni5010.c 
>>>   *
>>>   *	Insert with e.g.:
>>> - *		insmod ni5010.o io=0x300 irq=5 	
>>> + *		insmod ni5010.o io=0x300 irq=5
>>>   */
>>>       
>> Should now be .ko ;-)
>>     
>
> Aaaargh... ;)
>
> Complete waste of time... but I redid it anyway.
>
> Signed-off-by: Andreas Mohr <andi@lisas.de>
>   
If you're wasting your time - the note that one needs to patch ifconfig
to use the driver
is probably pretty obsolete too :-)

Jan-Pascal

