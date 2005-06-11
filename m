Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261834AbVFKVIS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261834AbVFKVIS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 17:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbVFKVIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 17:08:18 -0400
Received: from smtpout.mac.com ([17.250.248.45]:4047 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261834AbVFKVIP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 17:08:15 -0400
In-Reply-To: <20050610122105.GA13931@isilmar.linta.de>
References: <200506100811.17631.swsnyder@insightbb.com> <20050610122105.GA13931@isilmar.linta.de>
Mime-Version: 1.0 (Apple Message framework v728)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <73AF5410-0EF8-4F1B-BE13-DB1F22B875DD@mac.com>
Cc: Steve Snyder <swsnyder@insightbb.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: PCMCIA still advised as modules?
Date: Sat, 11 Jun 2005 17:08:08 -0400
To: Dominik Brodowski <linux@dominikbrodowski.net>
X-Mailer: Apple Mail (2.728)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 10, 2005, at 08:21:05, Dominik Brodowski wrote:
> At least from 2.6.13 on, it will be much easier if you have the PCMCIA
> "modules" built into the kernel, as you won't need userspace  
> interaction any
> longer (except on old yenta_socket bridges during startup, but  
> that's a
> different story). Therefore, I do not see any drawbacks to having  
> the PCMCIA
> modules built into the kernel.

Under such a setup, what is the easiest method to shut down the  
bridge chip
for power savings?  On my Debian laptop where said drivers are  
modular, I can
run "/etc/init.d/pcmcia stop" to unload the module and disable the  
PCMCIA chip,
saving a noticeable amount of power.  Is there some equivalent for  
compiled-in
drivers?  Thanks!


Cheers,
Kyle Moffett

Somone asked my why I work on this free (http://www.fsf.org/philosophy/)
software stuff and not get a real job. Charles Shultz had the best  
answer:

"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't.  
That's why
I draw cartoons. It's my life." -- Charles Shultz

