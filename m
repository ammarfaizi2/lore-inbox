Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263033AbTHVGLj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 02:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262990AbTHVGLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 02:11:39 -0400
Received: from [62.13.18.67] ([62.13.18.67]:18370 "EHLO
	mail.kontorshotellet.nu") by vger.kernel.org with ESMTP
	id S263035AbTHVGLe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 02:11:34 -0400
Message-ID: <3F45B417.6010507@lanil.mine.nu>
Date: Fri, 22 Aug 2003 08:11:35 +0200
From: Christian Axelsson <smiler@lanil.mine.nu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030814 Thunderbird/0.2a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Diehl <lists@mdiehl.de>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [2.6.0-test3-mm3] irda compile error
References: <Pine.LNX.4.44.0308212120380.3006-100000@notebook.home.mdiehl.de>
In-Reply-To: <Pine.LNX.4.44.0308212120380.3006-100000@notebook.home.mdiehl.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Diehl wrote:

>On Thu, 21 Aug 2003, Christian Axelsson wrote:
>
>  
>
>>Got this while doing  make. Config attached.
>>Same config compiles fine under mm2
>>
>> CC      drivers/net/irda/vlsi_ir.o
>>drivers/net/irda/vlsi_ir.c: In function `vlsi_proc_pdev':
>>drivers/net/irda/vlsi_ir.c:167: structure has no member named `name'
>>    
>>
>
>Yep, Thanks. I'm aware of the problem which is due to the recent 
>device->name removal. In fact a fix for this was already included in the 
>latest resent of my big vlsi update patch pending since long.
>
>Anyway, it was pointed out now the patch is too big so I'm currently 
>working on splitting it up. Bunch of patches will follow soon :-)
>
>Btw., are you actually using this driver? I'm always looking for testers 
>with 2.6 to give better real life coverage...
>  
>

No, not until I get a cellphone or similar that I can use it with :)
I smiply have it for eventual cases like this as I want to find as much 
bugs as possible before the actual 2.6 release.

--
Christian Axelsson
smiler@lanil.mine.nu


