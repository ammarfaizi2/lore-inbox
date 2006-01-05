Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751633AbWAEWpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633AbWAEWpu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 17:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752265AbWAEWpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 17:45:49 -0500
Received: from lx09-hrz.uni-duisburg.de ([134.91.4.50]:31724 "EHLO
	lx09-hrz.uni-duisburg.de") by vger.kernel.org with ESMTP
	id S1751633AbWAEWpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 17:45:47 -0500
Message-ID: <43BDA02F.5070103@folkwang-hochschule.de>
Date: Thu, 05 Jan 2006 23:39:43 +0100
From: Joern Nettingsmeier <nettings@folkwang-hochschule.de>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
CC: Jaroslav Kysela <perex@suse.cz>, Pete Zaitcev <zaitcev@redhat.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Adrian Bunk <bunk@stusta.de>, Olivier Galibert <galibert@pobox.com>,
       Tomasz Torcz <zdzichu@irc.pl>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Andi Kleen <ak@suse.de>, ALSA development <alsa-devel@alsa-project.org>,
       James@superbug.demon.co.uk, sailer@ife.ee.ethz.ch,
       linux-sound@vger.kernel.org, zab@zabbo.net, kyle@parisc-linux.org,
       parisc-linux@lists.parisc-linux.org, jgarzik@pobox.com,
       Thorsten Knabe <linux@thorsten-knabe.de>, zwane@commfireservices.com,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [OT] ALSA userspace API complexity
References: <20050726150837.GT3160@stusta.de> <20060103193736.GG3831@stusta.de> <Pine.BSO.4.63.0601032210380.29027@rudy.mif.pg.gda.pl> <mailman.1136368805.14661.linux-kernel2news@redhat.com> <20060104030034.6b780485.zaitcev@redhat.com> <Pine.LNX.4.61.0601041220450.9321@tm8103.perex-int.cz> <Pine.BSO.4.63.0601051253550.17086@rudy.mif.pg.gda.pl> <Pine.LNX.4.61.0601051305240.10350@tm8103.perex-int.cz> <Pine.BSO.4.63.0601051345100.17086@rudy.mif.pg.gda.pl>
In-Reply-To: <Pine.BSO.4.63.0601051345100.17086@rudy.mif.pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz K³oczko wrote:
> List all neccessary feactures and abstract them. Below this layer you 
> can plug to this all device drivers. Where is the problem ?

users want to use all the bells and whistles that modern sound hardware 
has to offer. so "necessary features" roughly equals the union of all 
the "cool ideas of the week" of all soundcard vendors.

please have a look at, say, the rme hammerfall cards, compare them with 
ye olde sblive, then take a look at usb audio devices and for dessert, 
take a peek into current firewire hardware.

then push up your sleeves, design a small and elegant little abstraction 
mechanism that is maximally effective in all circumstances and makes all 
hardware features usable, wrap it up nicely and submit it to linus.

i look forward to hearing back from you, in, oh, 2015 or so?

jaroslav, takashi and the other alsa developers have been toiling with 
this for years, and i hate to see them having to take shit from people 
who don't do anything more with their sound hardware than listen to mp3s 
in stereo and can't imagine anything else.

granted, there is always room for improvement. the alsa guys are very 
receptive towards constructive criticism, when it is backed with a 
little insight. many linux audio developers have criticised the API for 
the high initial barrier, and ALSA certainly does not score that high in 
the "making simple things simple" department. but it does make 
*complicated things possible*, and all those rants of "gimme back me 
oss" usually ignore this.

modem dialup users know better than to chime in to networking core 
discussions and complain they don't need all that complexity. why do 
professional audio users always have to put up with people who only 
listen to mp3s whining about a complicate API?

i'll always grant you far better taste and insight into kernel matters 
than i will ever have, but hey: the library is in userspace. it does not 
clutter the kernel. so rrreeelaax!


-- 
jörn nettingsmeier

home://germany/45128 essen/lortzingstr. 11/
http://spunk.dnsalias.org
phone://+49/201/491621

if you are a free (as in "free speech") software developer
and you happen to be travelling near my home, drop me a line
and come round for a free (as in "free beer") beer. :-D
