Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161037AbVKDB0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161037AbVKDB0t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 20:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030573AbVKDB0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 20:26:49 -0500
Received: from penta.pentaserver.com ([66.45.247.194]:9424 "EHLO
	penta.pentaserver.com") by vger.kernel.org with ESMTP
	id S1030570AbVKDB0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 20:26:48 -0500
Message-ID: <436AB58C.30708@linuxtv.org>
Date: Fri, 04 Nov 2005 05:12:44 +0400
From: Manu Abraham <manu@linuxtv.org>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Oberritter <obi@linuxtv.org>
CC: linux-kernel@vger.kernel.org, Mike Krufky <mkrufky@linuxtv.org>,
       linux-dvb-maintainer@linuxtv.org, Andrew Morton <akpm@osdl.org>,
       Johannes Stezenbach <js@linuxtv.org>
Subject: Re: [linux-dvb-maintainer] Re: [PATCH 26/37] dvb: add support for
 plls used by nxt200x
References: <4367241A.1060300@m1k.net>	 <20051103135910.3bf893d9.akpm@osdl.org> <436A96A8.4080906@linuxtv.org>	 <436AA148.8090705@linuxtv.org> <1131065468.9376.23.camel@ip6-localhost>
In-Reply-To: <1131065468.9376.23.camel@ip6-localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - penta.pentaserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - linuxtv.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Oberritter wrote:

>On Fri, 2005-11-04 at 03:46 +0400, Manu Abraham wrote:
>  
>
>>We have in the DVB subsystem most of the exported symbols as 
>>EXPORT_SYMBOL itself, rather than EXPORT_SYMBOL_GPL. I think if this 
>>needs to be changed, we would require a global change of all symbols to 
>>the same to maintain consistency. If you require that change we can have 
>>a change but i would think that the discussions be done with the 
>>relevant copyright holders too, eventhough probably most of the authors 
>>won't have any objection.
>>    
>>
>
>I don't know if I ever contributed code to the DVB subsystem which is
>actually exported, but in case I did, then I am against changing the
>affected EXPORT_SYMBOLs.
>  
>
Since this issue is subject to discussion, i think a consensus can be 
reached, with a discussion with the relevant owners, _if_ it needs to be 
changed. I did not imply that it needs to be changed.

I have personally contributed some code which does EXPORT_SYMBOL, but 
for me changing it to EXPORT_SYMBOL_GPL is acceptable if the general 
consensus is that way, or if there is a valid reason to go either way. I 
don't mind either.

>This would make it impossible to the use source code of most hardware
>vendors for embedded products because they usually have different
>licenses for their "run-on-every-embedded-platform-and-even-on-windows"
>drivers.
>
>Also I remember people telling on lkml that EXPORT_SYMBOL_GPL was used
>for new kernel internal code only and I can't see how this applies to
>dvb-pll or any other part of the dvb subsystem which grew up outside the
>kernel tree.
>  
>

AFAIK, the only hardware that exports EXPORT_SYMBOL_GPL is only the 
budget core, other than that all of the code uses EXPORT_SYMBOL only.

Regards,
Manu


