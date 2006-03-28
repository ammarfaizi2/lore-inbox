Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932454AbWC1WYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbWC1WYI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 17:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbWC1WYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 17:24:07 -0500
Received: from [62.205.161.221] ([62.205.161.221]:4787 "EHLO kir.sacred.ru")
	by vger.kernel.org with ESMTP id S932454AbWC1WYF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 17:24:05 -0500
Message-ID: <4429B789.4030209@sacred.ru>
Date: Wed, 29 Mar 2006 02:24:09 +0400
From: Kir Kolyshkin <kir@sacred.ru>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20060217)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Vilain <sam@vilain.net>
CC: Kir Kolyshkin <kir@openvz.org>, devel@openvz.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Devel] Re: [RFC] Virtualization steps
References: <44242A3F.1010307@sw.ru> <44242D4D.40702@yahoo.com.au>	 <1143228339.19152.91.camel@localhost.localdomain>	 <4428BB5C.3060803@tmr.com>  <4428DB76.9040102@openvz.org> <1143583179.6325.10.camel@localhost.localdomain>
In-Reply-To: <1143583179.6325.10.camel@localhost.localdomain>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Vilain wrote:

>On Tue, 2006-03-28 at 10:45 +0400, Kir Kolyshkin wrote:
>  
>
>>It is actually not a future goal, but rather a reality. Since os-level 
>>virtualization overhead is very low (1-2 per cent or so), one can run 
>>hundreds of VEs.
>>    
>>
>
>Huh?  You managed to measure it!?  Or do you just mean "negligible" by
>"1-2 per cent" ?  :-)
>  
>
We run different tests to measure OpenVZ/Virtuozzo overhead, as we do 
care much for that stuff. I do not remember all the gory details at the 
moment, but I gave the correct numbers: "1-2 per cent or so".

There are things such as networking (OpenVZ's venet device) overhead, a 
fair cpu scheduler overhead, something else.

Why do you think it can not be measured? It either can be, or it is too 
low to be measured reliably (a fraction of a per cent or so).

Regards,
  Kir.
