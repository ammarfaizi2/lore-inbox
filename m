Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270496AbTGaSBd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 14:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274839AbTGaSBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 14:01:33 -0400
Received: from jive.SoftHome.net ([66.54.152.27]:64389 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id S270496AbTGaSBc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 14:01:32 -0400
Message-ID: <3F2959A4.4070605@softhome.net>
Date: Thu, 31 Jul 2003 20:02:12 +0200
From: "Ihar \"Philips\" Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.6 size increase
References: <eLVb.3yF.1@gated-at.bofh.it> <eOJn.5NI.1@gated-at.bofh.it> <f1dJ.GS.21@gated-at.bofh.it> <faTE.2LQ.3@gated-at.bofh.it> <fd56.4Te.9@gated-at.bofh.it> <fdRv.5uB.9@gated-at.bofh.it> <fnHd.54o.19@gated-at.bofh.it> <3F294461.2020902@softhome.net> <20030731164326.GG27214@ip68-0-152-218.tc.ph.cox.net> <3F294C31.6030702@softhome.net> <20030731172046.GH27214@ip68-0-152-218.tc.ph.cox.net>
In-Reply-To: <20030731172046.GH27214@ip68-0-152-218.tc.ph.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:
>>
>>    You didn't get my point.
>>    My appliances do not need sleep/shutdown at all.
>>    Not every embedded system is a handheld ;-)
> 
> 
> That certainly is true, yes.  They might want to power things down when
> the user isn't there (or maybe they don't, I don't know what you're
> making :)).  And I did originally say 'some'.
> 

   Can you imagine teapot?
   State of your system - on/off. Power saving as done by user herself: 
power is consumed only when user want to boil the water ;-)

   Two devices I was working on were little bit more complicated and I 
had internal UPS to be able to handle power offs/fails gracefuly (like 
switching off of LCD + save of the mechanics state).

   As for me - I already expressed my point on subject: we should fix 
compiler and language (C's inline is definitely not ehough to express 
our intentions to compiler). That's the compiler should be optimized to 
gain space for performace or gain performance for space.

   And sure kernel should be more configurable too.


