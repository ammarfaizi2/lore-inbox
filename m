Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbVIQSkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbVIQSkM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 14:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbVIQSkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 14:40:12 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:23682 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1751178AbVIQSkK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 14:40:10 -0400
Message-ID: <432C62D5.9080703@gmail.com>
Date: Sat, 17 Sep 2005 20:39:17 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Manu Abraham <manu@linuxtv.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: free free irq and Oops on cat /proc/interrupts (2)
References: <432C344D.1030604@linuxtv.org>
In-Reply-To: <432C344D.1030604@linuxtv.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manu Abraham napsal(a):

> Can somebody give me a pointer as to what i am possibly doing wrong.
>
> The module loads fine..
> The module unloads fine.. But i get a "free free IRQ" on free_irq()..
> I do a cat /proc/interrupts .. I get an Oops.. Attached dmesg [1]
> I did an Oops trace down to vsprintf.c, using make EXTRA_CFLAGS="-g 
> -Wa,-a,-ad" lib/vsprintf.o > lib/vsprintf.asm, but still couldn't find 
> what the real bug is.

Please, stop spamming list with your (almost all stupid) questions.
At the first read some material. ldd3 is the book, which will help you 
(the 3rd time I tell you that). There is explained how to write pci devices.
Then read some code, as Rolf Eike Beer wrote. Almost everything what 
will you ever need was written at least once.
Then think, if you didn't see the thing you want somewhere and take a 
look there.
And after all tries ask list, why the driver is not working.

At least Rolf and me wrote you, that you need to call pci_enable_device 
and you do NOT do that again. So?

thanks,

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10

