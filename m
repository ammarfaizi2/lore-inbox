Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751015AbVILOWI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbVILOWI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 10:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbVILOWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 10:22:08 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:26761 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1751013AbVILOWH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 10:22:07 -0400
Message-ID: <43258F02.6060406@gmail.com>
Date: Mon, 12 Sep 2005 16:21:54 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.13-mm3 BUG in ntfs or slab
References: <200509121417.j8CEH7u5006138@wscnet.wsc.cz>
In-Reply-To: <200509121417.j8CEH7u5006138@wscnet.wsc.cz>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby napsal(a):

>This BUG causes freeze of applications, such as beep-media-player (e.g.
>uninterruptible sleep in futex with no wake), ls (un. sleep, i don't know
>where), bash, when listing ntfs dirs.
>  
>
[snip]

>linux_ver:
>Linux bellona 2.6.13-mm3-g856d0bcc #26 SMP PREEMPT Mon Sep 12 12:58:14 CEST 2005 i686 i686 i386 GNU/Linux
>  
>
2.6.13-mm2 was maybe (i haven't get this BUG all over the time I used 
it) OK. Now, I am getting it often.

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10

