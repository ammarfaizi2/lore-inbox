Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262509AbUCHPhn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 10:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262513AbUCHPhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 10:37:42 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:9346 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262509AbUCHPhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 10:37:40 -0500
Message-ID: <404C932B.8050307@nortelnetworks.com>
Date: Mon, 08 Mar 2004 10:37:15 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Paul Jackson <pj@sgi.com>, kangur@polcom.net, mmazur@kernel.pl,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.3.0
References: <200402291942.45392.mmazur@kernel.pl>	<200403031829.41394.mmazur@kernel.pl>	<m3brnc8zun.fsf@defiant.pm.waw.pl>	<200403042149.36604.mmazur@kernel.pl>	<m3brnb8bxa.fsf@defiant.pm.waw.pl>	<Pine.LNX.4.58.0403060022570.5790@alpha.polcom.net>	<m38yidk3rg.fsf@defiant.pm.waw.pl>	<20040306171535.5cbf2494.pj@sgi.com>	<m38yiclby8.fsf@defiant.pm.waw.pl>	<20040307172847.46708dcc.pj@sgi.com> <m3hdwzwfcp.fsf@defiant.pm.waw.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa wrote:
> Paul Jackson <pj@sgi.com> writes:
> 
> 
>>>You're talking about the kernel development ...
>>>
>>No.  I mean that even the C API that the kernel presents to
>>user code will sometimes change or have parts disappear.
>>
> 
> And it can be caused by changing kernel config?
> 
> Care to show an example?

Generally it cannot be caused by changing kernel config (although kernel 
config can cause syscalls to be valid or not).

However, new kernel versions can add/remove stuff.  Usually stuff isn't 
removed for a while after its deprecated, but there have been instances 
where stuff has been added/changed/removed during unstable kernel 
development.

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

