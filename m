Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030212AbWADMTY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030212AbWADMTY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 07:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030210AbWADMTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 07:19:24 -0500
Received: from lx09-hrz.uni-duisburg.de ([134.91.4.50]:31157 "EHLO
	lx09-hrz.uni-duisburg.de") by vger.kernel.org with ESMTP
	id S1030212AbWADMTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 07:19:22 -0500
Message-ID: <43BBBBFF.5020209@folkwang-hochschule.de>
Date: Wed, 04 Jan 2006 13:13:51 +0100
From: Joern Nettingsmeier <nettings@folkwang-hochschule.de>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
CC: Adrian Bunk <bunk@stusta.de>, Olivier Galibert <galibert@pobox.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Tomasz Torcz <zdzichu@irc.pl>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Andi Kleen <ak@suse.de>, perex@suse.cz, alsa-devel@alsa-project.org,
       James@superbug.demon.co.uk, sailer@ife.ee.ethz.ch,
       linux-sound@vger.kernel.org, zab@zabbo.net, kyle@parisc-linux.org,
       parisc-linux@lists.parisc-linux.org, jgarzik@pobox.com,
       Thorsten Knabe <linux@thorsten-knabe.de>, zwane@commfireservices.com,
       zaitcev@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
References: <20050726150837.GT3160@stusta.de> <200601031629.21765.s0348365@sms.ed.ac.uk> <20060103170316.GA12249@dspnet.fr.eu.org> <200601031716.13409.s0348365@sms.ed.ac.uk> <20060103192449.GA26030@dspnet.fr.eu.org> <20060103193736.GG3831@stusta.de> <Pine.BSO.4.63.0601032210380.29027@rudy.mif.pg.gda.pl>
In-Reply-To: <Pine.BSO.4.63.0601032210380.29027@rudy.mif.pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Tomasz K³oczko wrote:
> Also more than four years exist another thing: generaly sound suport
> in Linux kernel is broken by design. Points where it is broken:
> 
> 1) ALSA API forces not use devices files and many things on sound
> managing level are handled on user space library. This dissallow
<snip>
> 2) ALSA API is to complicated: most applications opens single sound 
> stream. All what system user expect it is plaing sound by more then
<snip>
> 3) ALSA kernel architecture is to complicated. This main reason why 
> configuring sound on Linux is SO COMPLICATED. From my system:
<snip>
> ALSA is also requires much more bigger code size than OSS variant 
> (count all snd* modules size, jackd and libasound and compare this
> with OSS modules and user space OSS library size). Simillar is on
<snip>

oh yeah. why is linux so fscking big? my olde msdos would fit on one 
floppy. whiiine.

what a load of crap. alsa is a serious architecture meant for serious, 
maximally efficient usage with all kinds of (wildly different) hardware.

desktop stuff and "you have mail" beeps are a fscking corner case.

this is like whining about the oh so complex networking infrastructure 
and iptables and constantly reminiscing how simple it used to be to set 
up a modem on /dev/ttyS0.

get real.


-- 
jörn nettingsmeier

home://germany/45128 essen/lortzingstr. 11/
http://spunk.dnsalias.org
phone://+49/201/491621

if you are a free (as in "free speech") software developer
and you happen to be travelling near my home, drop me a line
and come round for a free (as in "free beer") beer. :-D
