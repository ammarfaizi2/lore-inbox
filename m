Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286322AbSCBKNU>; Sat, 2 Mar 2002 05:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290946AbSCBKNK>; Sat, 2 Mar 2002 05:13:10 -0500
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:65500 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S286322AbSCBKM7>; Sat, 2 Mar 2002 05:12:59 -0500
Message-ID: <3C80A5A4.5050208@attbi.com>
Date: Sat, 02 Mar 2002 04:12:52 -0600
From: Chase Venters <chase.venters@attbi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [2.5] i_rdev structure (why has it changed?)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've noticed when compiling 2.5.2 that certain modules (such as 
via82cxxx_audio) do not want to compile. After a few hours of digging, I 
noticed that it seems as if the method for dealing with i_rdev has 
changed. I eventually got my code to compile (and, as a matter of fact, 
ALSA and NVIDIA's driver) by amending all instances of i_rdev to 
i_rdev.value, but I'll be the first to admit that's my first "kernel 
patch" (is it worthy of such a name?) and though the modifications seem 
to produce a flawlessly working kernel I'm still tinkering with cogs in 
a giant machine.

That said, if my modification is not an example of human stupidity in 
action, I'd like to notify those reading that if you have any similar 
places that must be cleaned, I've crafted a simple perl script to patch 
sources accordingly.

http://tucb.com/chase/fix-i_rdev.html

Commentary is appreciated. But more importantly - why did this change?

(Please CC all replies to this message to chase.venters@attbi.com as I 
am not yet a member of this mailing list [hides in corner])

Thanks,
Chase Venters


