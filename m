Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbTLWRki (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 12:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbTLWRki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 12:40:38 -0500
Received: from fep04-mail.bloor.is.net.cable.rogers.com ([66.185.86.74]:21434
	"EHLO fep04-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S261965AbTLWRkg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 12:40:36 -0500
Message-ID: <3FE8388F.1020302@rogers.com>
Date: Tue, 23 Dec 2003 12:43:59 +0000
From: pZa1x <pZa1x@rogers.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Karol Kozimor <sziwan@hell.org.pl>
CC: linux-kernel@vger.kernel.org
Subject: Laptops and 2.6.0 - momentum? (was Re: 2.6.0 release + ALSA + suspend
 = not work)
References: <15Ee5-Id-5@gated-at.bofh.it> <20031222230237.GA26609@hell.org.pl>
In-Reply-To: <20031222230237.GA26609@hell.org.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at fep04-mail.bloor.is.net.cable.rogers.com from [24.157.208.226] using ID <dw2price@rogers.com> at Tue, 23 Dec 2003 12:38:22 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, I'm volunteering time to do testing on my notebook for 2.6.0. I 
wonder if there is anyway to generate some momentum for it? If the aim 
is enterprise, doesn't enterprise use thousands of notebooks? I got mine 
refurbished from some large business. There are many organizations that 
collect thousands of old notebooks used by businesses, refurbish them 
and re-sell them. It's a great way of acquiring a durable, light 
business-class notebook at bargain prices.

This is a great target for Linux especially as it runs fine (even with 
the infamous Gnome) on my 700Mhz T20 Thinkpad. ie. a multi-gigahertz 
system seems a complete waste of money and a risk re weight and build 
quality.

I couldn't code a hello world to save my life but I can test patches and 
collect data. Currently, I am running 2.4.22 on my notebook because on 
2.6.0:

(a) suspend kills ALSA and ALSA mut be restarted
(b) suspend fails to function if yenta_socket (PCMCIA services) is running


Karol Kozimor wrote:
> Thus wrote pZa1x:
> 
>>ALSA stops producing sound after any time I suspend my Thinkpad T20 
>>notebook. I am using 2.6.0 release and the snd-cs46xx driver.
>>
>>I have to log out of Gnome and remove the sound card module and re 
>>modprobe it then restart Gnome to get sound back.
>>
>>No problems with 2.4.20 with OSS drivers.
> 
> 
> I have a similar problem here (ICH3M, CS4299, snd-intel8x0). In my case,
> using OSS emulation in userspace and ALSA modules in kernel works fine, so
> it must be a locking problem of some kind, anyway probably something
> trivial to fix.
> A similar problem occurs under 2.4, FYI.
> Best regards,
> 

