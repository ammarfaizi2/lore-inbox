Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265115AbUD3QRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265115AbUD3QRQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 12:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265099AbUD3QRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 12:17:15 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:6929 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S265160AbUD3QPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 12:15:43 -0400
Message-ID: <40927CC5.7060901@techsource.com>
Date: Fri, 30 Apr 2004 12:20:21 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Helge Hafting <helgehaf@aitel.hist.no>
CC: Paul Wagland <paul@wagland.net>, Rik van Riel <riel@redhat.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       David Gibson <david@gibson.dropbear.id.au>,
       Marc Boucher <marc@linuxant.com>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
References: <Pine.LNX.4.44.0404291114150.9152-100000@chimarrao.boston.redhat.com> <4FE43C97-9A20-11D8-B804-000A95CD704C@wagland.net> <4091757B.3090209@techsource.com> <40923D65.2010704@aitel.hist.no>
In-Reply-To: <40923D65.2010704@aitel.hist.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Helge Hafting wrote:
> Timothy Miller wrote:
> 
>>
>> While we're on all of this, are we going to change "tained" to some 
>> other less alarmist word?  Say there is a /proc file or some report 
>> that you can generate about the kernel that simply wants to indicate 
>> that the kernel contains closed-source modules, and we want to use a 
>> short, concise word like "tainted" for this.  "An untrusted module has 
>> been loaded into this kernel" would be just a bit too long to qualify.
>>
>> Hmmm... how about "untrusted"?  Not sure...
> 
> 
> "Unsupported" seems a good candidate to me.  It describes the
> situation fairly well.  Such a kernel is unsupported by the
> kernel community, and probably by the binary module vendor
> too. They tend to restrict support to their own module . . .
> 


GOOD!  And if people misunderstood "unsupported" to also mean that the 
VENDOR doesn't support it either, that's fine, because it's almost 
always true.  :)

