Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263354AbTKCU0T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 15:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263400AbTKCU0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 15:26:19 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:157 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S263354AbTKCUYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 15:24:33 -0500
Message-ID: <3FA6B97C.6070707@softhome.net>
Date: Mon, 03 Nov 2003 21:24:28 +0100
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030927
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Muli Ben-Yehuda <mulix@mulix.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: How provoke call stack trace
References: <3FA6A0AF.2070300@softhome.net> <20031103185334.GS32115@actcom.co.il>
In-Reply-To: <20031103185334.GS32115@actcom.co.il>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Muli Ben-Yehuda wrote:
> On Mon, Nov 03, 2003 at 07:38:39PM +0100, Ihar 'Philips' Filipau wrote:
> 
> 
>>   Is there any function which can be used by module to just 
>>investigate some given call path?
> 
> 
> Assuming 2.6, call dump_stack(). If you want greater flexibility,
> investigate show_trace() and friends. 
> 
> Hope this helps, 

   I'm sitting right now on 2.4.22 - so no 2.6 nicities.
   I actually wanted to have something like this on ppc - but ppc has no 
dump_stack() implemented.

   Thanks any way.

   [ Just checked 2.6 - ppc has dump_stack() now. Nice. It looks like 
all archs have implemented it in 2.6. Cool. ]

-- 
Ihar 'Philips' Filipau  / with best regards from Saarbruecken.
--                                                           _ _ _
  "... and for $64000 question, could you get yourself       |_|*|_|
    vaguely familiar with the notion of on-topic posting?"   |_|_|*|
                                 -- Al Viro @ LKML           |*|*|*|

