Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261157AbVAILgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbVAILgR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 06:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbVAILgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 06:36:17 -0500
Received: from omega.datac.cz ([81.31.15.4]:64904 "EHLO omega.datac.cz")
	by vger.kernel.org with ESMTP id S261157AbVAILgO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 06:36:14 -0500
Message-ID: <41E1170D.6090405@feix.cz>
Date: Sun, 09 Jan 2005 12:35:41 +0100
From: Michal Feix <michal@feix.cz>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Tomasz Torcz <zdzichu@irc.pl>
Subject: Re: Conflicts in kernel 2.6 headers and {glibc,Xorg}
References: <41E0F76D.7080805@feix.cz> <20050109110805.GA8688@irc.pl>
In-Reply-To: <20050109110805.GA8688@irc.pl>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>First, I'm not on kernel mailing list so please CC any replies to me. 
>>Thank you.
>>
>>Yesterday I was recompiling my Linux from Scratch distribution for the 
>>first time with Linux kernel 2.6.10 headers as a base for glibc. I've 
>>found, that glibc (and XOrg later on too) won't compile, as there is a 
>>conflict in certain functions or macros that glibc and Kernel headers 
>>both define.
> 
> 
>  Are you using proper kernel headers - from
> http://ep09.pld-linux.org/~mmazur/linux-libc-headers/ ?

No, I am not, because I wasn't told to do so. For meny years I always 
used vanilla sources from kernel.org for my /usr/include/... I wasn't 
told, that it is wrong and I still believe, that Linux kernel headers 
should be fixed by including these conflicting macros and functions into 
__KERNEL__ block instead. Or am I missing something?

-- 
Michal
