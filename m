Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261418AbVG1OMb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbVG1OMb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 10:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbVG1OKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 10:10:14 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:29062 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261460AbVG1OKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 10:10:03 -0400
Message-ID: <42E8E6BD.90807@gmail.com>
Date: Thu, 28 Jul 2005 16:07:57 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] New include file for marking old style api files
References: <42E8E0C2.5010302@gmail.com> <20050728140230.GG3528@stusta.de>
In-Reply-To: <20050728140230.GG3528@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk napsal(a):

>On Thu, Jul 28, 2005 at 03:42:26PM +0200, Jiri Slaby wrote:
>  
>
>>Hi.
>>Do you think, that this would be useful in the kernel tree?
>>I have an idea to mark old drivers, which should I or somebody rewrite.
>>For example drivers/isdn/hisax/gazel.c.
>>...
>>--- /dev/null
>>+++ b/include/linux/oldapi.h
>>@@ -0,0 +1,2 @@
>>+#warning This driver uses old style API and needs to be rewritten or removed \
>>+	from kernel
>>    
>>
>
>What's wrong with __deprecated ?
>  
>
Nothing, but this marks entire driver, not a function, that it uses.
I.e. gazel doesn't emit any warning or so, I think; so for these cases.

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10

