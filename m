Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965027AbVI3Jju@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965027AbVI3Jju (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 05:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965033AbVI3Jju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 05:39:50 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:32902 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S965027AbVI3Jjt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 05:39:49 -0400
Message-ID: <433D07CE.4070502@gmail.com>
Date: Fri, 30 Sep 2005 11:39:26 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: janik holy <divizion@pobox.sk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pcmcia bug ?
References: <f1b1d6fa609b4f29ba59f4f49f0c9f08@pobox.sk>
In-Reply-To: <f1b1d6fa609b4f29ba59f4f49f0c9f08@pobox.sk>
Content-Type: text/plain; charset=windows-1250
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

janik holy napsal(a):
> Its dont work tho.... 
> 
> 
>>-----Pôvodná správa-----
>>Od: Jiri Slaby [mailto:jirislaby@gmail.com]
>>Odoslané: 29. septembra 2005 21:12
>>Komu: janik holy
>>Predmet: Re: pcmcia bug ?
>>
>>
>>janik holy napsal(a):
>>
>>
>>>Hello, i use slack 10.1, kernel 2.6.14-rc2-git7, i have orinoco silver pcmcia
>>>wifi card, i compile PCMCIA support into kernel, and orinoco, hermes, orinoco_cs
>>>as modules.... after booting loading modules, and run /etc/rc.d/rc.pcmcia i see
>>>message >= cardmgr no pcmcia in /proc/devices. after cat /proc/devices there is
>>>really no pcmcia. I really dont know what is it, on 2.6.11 with the same kernel
>>>conf, its works ok and pcmcia was in /proc/devices. So during i wont have pcmcia
>>>in /proc/devices i cant use cardctl and cardmgr ... any idea how to fix it ?
>>>where can be a problem ? thanks
>>>
>>>
>>
>>Compile yenta, pcmcia, hermes and hermes pcmcia into kernel. I know
>>about this problem, but I haven't had enough time to solve it.
Please, do not remove Ccs when replying.

In that case, boot the old kernel, do `dmesg -s 1000000 >old`, in the new `dmesg
-s 1000000 >new' and send `diff -u old new'.
Next, append .config and some hw info (model and so).
No mimes, if it is possible.

regards,
-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10
