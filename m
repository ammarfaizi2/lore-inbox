Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264452AbUEDPqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264452AbUEDPqv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 11:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264456AbUEDPqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 11:46:51 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:27662 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S264452AbUEDPqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 11:46:50 -0400
Message-ID: <4097BC46.2050300@techsource.com>
Date: Tue, 04 May 2004 11:52:38 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Douglas Mayle <douglas@mayle.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Framebuffer Layer - Radeonfb, kernel 2.6.5
References: <1083340507.8830.16.camel@doug64.sophia.metrixsystems.com>	 <409295D1.6070609@techsource.com> <1083364411.5868.3.camel@doug64.mayle.org>
In-Reply-To: <1083364411.5868.3.camel@doug64.mayle.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Douglas Mayle wrote:
>>If you specify a resolution different from what EDID reports, what you 
>>get on screen is the resolution reported by EDID physically, but 
>>virtually the resolution requested.  That is, if I ask for 1280x1024, 
>>but EDID says 1024x768, I see the upper left 1024x768 of the 1280x1024 
>>screen that the console is being displayed on.
> 
> 
> I'm not sure I'd call that a bug.  You've set the resolution
> specifically, and the driver does it's best to give you what you've
> requested.


It does not give me what I requested.  I requested 1280x1024.  I get a 
broken 1024x768.

I know that when EDID reports only 1280x1024, everything works fine, but 
for whatever reason, my LCD monitor reports 1024x768 first, and that's 
what it uses.

I did some searching, and I'm not the only person who reports this 
problem.  I found a patch for it online.  I'll see if I can't dig that 
up for you.

