Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964858AbWBNAuH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbWBNAuH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 19:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964886AbWBNAuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 19:50:06 -0500
Received: from rtr.ca ([64.26.128.89]:57823 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S964858AbWBNAuF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 19:50:05 -0500
Message-ID: <43F1293A.9050002@rtr.ca>
Date: Mon, 13 Feb 2006 19:50:02 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Johannes Stezenbach <js@linuxtv.org>, dgc@sgi.com,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: dirty pages (Was: Re: [PATCH] Prevent large file writeback starvation)
References: <20060206040027.GI43335175@melbourne.sgi.com>	<20060205202733.48a02dbe.akpm@osdl.org>	<43E75ED4.809@rtr.ca>	<43E75FB6.2040203@rtr.ca>	<20060206121133.4ef589af.akpm@osdl.org>	<20060213135925.GA6173@linuxtv.org> <20060213120847.79215432.akpm@osdl.org> <43F11BA3.8060904@rtr.ca>
In-Reply-To: <43F11BA3.8060904@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> Andrew Morton wrote:
>> Johannes Stezenbach <js@linuxtv.org> wrote:
>>> On Mon, Feb 06, 2006, Andrew Morton wrote:
...
>>> Anyway, I temporarily deinstalled vmware (deleted the kernel
>>> modules and rebooted; kernel is still tainted because of madwifi
>>> if that matters).
>>> The behaviour I see with vmware (long 'sync' time) doesn't seem
>>> to happen without it so far ...
> 
> Mmm.. Okay, all of my machines normally have VMWare-WS installed on them,
> so that might just be the culprit.
...
> Mmm.. so the intent is to affect only VMWare itself, not the rest of the
> system while VMWare is dormant.  I guess it's time to disable loading of
> the VMWare modules and reboot.  Bye bye uptime!   Maybe I'll install
> 2.6.16-rc3 while I'm at it.
> 
> I'll follow-up with results in an hour or two.

Okay, results are non-conclusive, because 2.6.16-rc3-git1 breaks VMWare;
the vmmon module no longer compiles.  Unstable kernel non-API issue again.

So I'm back on 2.6.15 until that gets fixed.

Cheers
