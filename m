Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264925AbTFQUTo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 16:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264926AbTFQUTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 16:19:44 -0400
Received: from [62.75.136.201] ([62.75.136.201]:32641 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S264925AbTFQUTm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 16:19:42 -0400
Message-ID: <3EEF7B20.5030208@g-house.de>
Date: Tue, 17 Jun 2003 22:33:36 +0200
From: Christian Kujau <evil@g-house.de>
Reply-To: evil@g-house.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.4b) Gecko/20030507
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.71 compile error on alpha
References: <3EEE4A14.4090505@g-house.de> <wrpr85te3fa.fsf@hina.wild-wind.fr.eu.org> <3EEF585E.9030404@g-house.de> <yw1xk7bk36hw.fsf@zaphod.guide> <20030617202221.GH6353@lug-owl.de>
In-Reply-To: <20030617202221.GH6353@lug-owl.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan-Benedict Glaw schrieb:
>>That's typical for the slower Avantis.  Is your's something like 100 MHz?
> 
> Well, that's mainly a question of compiler version and the quantity of
> modules you attempt to build...

it's both :-)

lila:~# cat /proc/cpuinfo
cpu			: Alpha
cpu model		: EV45
cpu variation		: 7
cpu revision		: 0
cpu serial number	:
system type		: Avanti
system variation	: 0
system revision		: 0
system serial number	:
cycle frequency [Hz]	: 232018561
timer frequency [Hz]	: 1024.00
page size [bytes]	: 8192
phys. address bits	: 34
max. addr. space #	: 63
BogoMIPS		: 458.36
kernel unaligned acc	: 32 (pc=fffffc0000478394,va=fffffc0002dbf176)
user unaligned acc	: 0 (pc=0,va=0)
platform string		: AlphaStation 255/233
cpus detected		: 1

lila:~# find /lib/modules/2.5.70/ | wc -l
      62
lila:~#


(still compiling (gcc3.3) 2.5.72....)

