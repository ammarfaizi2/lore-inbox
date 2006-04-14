Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbWDNL1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbWDNL1U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 07:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbWDNL1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 07:27:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:28862 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751095AbWDNL1T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 07:27:19 -0400
X-Authenticated: #2277123
Message-ID: <443F86EB.8060903@gmx.de>
Date: Fri, 14 Apr 2006 13:26:35 +0200
From: Christian Heimanns <ch.heimanns@gmx.de>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, pavel@suse.cz
Subject: Re: Suspend to disk
References: <443C0C2D.1020207@gmx.de> <200604112235.18943.rjw@sisk.pl> <200604112238.07166.rjw@sisk.pl>
In-Reply-To: <200604112238.07166.rjw@sisk.pl>
X-Enigmail-Version: 0.93.2.0
OpenPGP: id=94079F4C
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the delay, I was on the road...

Rafael J. Wysocki wrote:
> [update]
> 
> On Tuesday 11 April 2006 22:35, Rafael J. Wysocki wrote:
>> On Tuesday 11 April 2006 22:06, Christian Heimanns wrote:
>>> Hello to all,
>>> following situation:
>>> On my notebook Samsung X20 1730V I'm running Slackware 10.2 current with
>>> kernel 2.6.15.6. Suspend to RAM and suspend to disk works fine.
>>> Since kernel >= 2.6.16 suspend to disk breaks the restore of the
>>> X-Server. That means that the current sessions is lost and the X-Server
>>> restarts.
>> Does it resume successfully without X (ie. runlevel 3)?
>>
>>> No problems with suspend to RAM. Please find attached the 
>>> dmesg output for kernel 2.6.15.6 and 2.6.16.2. As well there is the
>>> output frpm lspci. The only difference I can find is that I have with
>>> kernel 2.6.16 some
>> Do you use a framebuffer driver and if so, is it modular?
> 
> Sorry, I see in the logs that you do.  Could you please boot with vga=normal
> and see if that helps?
> 

I tried kernel 2.6.16.2 with vga=normal. No changes. Suspend to RAM
works well, suspend to disk not. It's just the X-Server who restarts and
 I lose the suspended X-session. The following messages I've found in
the dmesg output after resume:

pnp: Device 00:08 does not supported activation.
pnp: Device 00:09 does not supported activation.
Restarting tasks... done

No idea what pnp device 00:08 and 00:09 is! These problems I have only
with the kernel >= 2.6.16

Regards,
Christian
-- 
---
Christian Heimanns
ch.heimanns<at>gmx<dot>de

### Pinguine können nicht fliegen
- Pinguine stürzen auch nicht ab! ###
