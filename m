Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbUCDAlZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 19:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbUCDAlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 19:41:25 -0500
Received: from alt.aurema.com ([203.217.18.57]:37527 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S261321AbUCDAlJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 19:41:09 -0500
Message-ID: <40467B1C.8080204@aurema.com>
Date: Thu, 04 Mar 2004 11:41:00 +1100
From: Peter Williams <peterw@aurema.com>
Organization: Aurema Pty Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: johnl@aurema.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] O(1) Entitlement Based Scheduler
References: <fa.fi4j08o.17nchps@ifi.uio.no.suse.lists.linux.kernel>	<fa.ctat17m.8mqa3c@ifi.uio.no.suse.lists.linux.kernel>	<yydjishqw10p.fsf@galizur.uio.no.suse.lists.linux.kernel>	<40426E1C.8010806@aurema.com.suse.lists.linux.kernel>	<p73k7224pdn.fsf@brahms.suse.de> <404554D8.5040800@aurema.com> <20040303165718.379f9151.ak@suse.de>
In-Reply-To: <20040303165718.379f9151.ak@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Wed, 03 Mar 2004 14:45:28 +1100
> Peter Williams <peterw@aurema.com> wrote:
> 
> 
>>Andi Kleen wrote:
>>
>>>Peter Williams <peterw@aurema.com> writes:
>>>
>>>One comment on the patches: could you remove the zillions of numerical Kconfig
>>>options and just make them sysctls? I don't think it makes any sense 
>>>to require a reboot to change any of that. And the user is unlikely
>>>to have much idea yet on what he wants on them while configuring.
>>
>>The default initial values should be fine and the default configuration 
>>allows the scheduling tuning parameters (i.e. half life and time slice 
>>       ) to be changed on a running system via the /proc file system. 
> 
> 
> I'm running the 2.6.3-full patch on my workstation now. No tuning applied
> at all. I reniced the X server to -10. When I have two kernel compiles (without any -j*) 
> running there is  a visible (=not really slow, but long enough to notice something) 
> delay in responses while typing something in a xterm. In sylpheed there
> is the same issue.
> 
> The standard scheduler didn't show this that extreme with only two compiles.
> 

Thanks for the feedback.  We're looking at some minor modifications to 
try and improve this issue.

BTW Could you try it with the X server reniced to -15?

Thanks
Peter
-- 
Dr Peter Williams, Chief Scientist                peterw@aurema.com
Aurema Pty Limited                                Tel:+61 2 9698 2322
PO Box 305, Strawberry Hills NSW 2012, Australia  Fax:+61 2 9699 9174
79 Myrtle Street, Chippendale NSW 2008, Australia http://www.aurema.com

