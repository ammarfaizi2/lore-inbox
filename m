Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264957AbUD2UUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264957AbUD2UUY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 16:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264959AbUD2UUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 16:20:24 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:22278 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S264957AbUD2UUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 16:20:20 -0400
Message-ID: <40916495.1060805@techsource.com>
Date: Thu, 29 Apr 2004 16:24:53 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Giuliano Colla <copeca@copeca.dsnet.it>
CC: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
       hsflinux@lists.mbsi.ca, Rusty Russell <rusty@rustcorp.com.au>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [hsflinux] [PATCH] Blacklist binary-only modules lying about
 their	license
References: <408DC0E0.7090500@gmx.net> <40914C35.1030802@copeca.dsnet.it>
In-Reply-To: <40914C35.1030802@copeca.dsnet.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Giuliano Colla wrote:

> As an end user, if I buy a full fledged modem, I get some amount of 
> proprietary, non GPL, code  which executes within the board or the 
> PCMCIA card of the modem. The GPL driver may even support the 
> functionality of downloading a new version of *proprietary* code into 
> the flash Eprom of the device. The GPL linux driver interfaces with it, 
> and all is kosher.
> On the other hand, I have the misfortune of being stuck with a 
> soft-modem, roughly the *same* proprietary code is provided as a binary 
> file, and a linux driver (source provided) interfaces with it. In that 
> case the kernel is flagged as "tainted".
> 
> But in both cases, if the driver is poorly written, because of 
> developer's inadequacy, or because of the proprietary code being poorly 
> documented and/or implemented, my kernel may go nuts, be it tainted or not.
> 
> Can you honestly tell apart the two cases, if you don't make a it a case 
> of "religion war"?
> 


Firmware downloaded into a piece of hardware can't corrupt the kernel in 
the host.

(Unless it's a bus master which writes to random memory, which might be 
possible, but there is hardware you can buy to watch PCI transactions.)

