Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262152AbVFHLmB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262152AbVFHLmB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 07:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262177AbVFHLjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 07:39:14 -0400
Received: from RT-soft-2.Moscow.itn.ru ([80.240.96.70]:64155 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S262178AbVFHLix
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 07:38:53 -0400
Message-ID: <42A6DB3E.6010502@ru.mvista.com>
Date: Wed, 08 Jun 2005 15:49:18 +0400
From: "Eugeny S. Mints" <emints@ru.mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       David Brownell <david-b@pacbell.net>
Subject: Re: race in usbnet.c in full RT
References: <42A6C6B3.2000303@ru.mvista.com> <20050608103440.GA18380@elte.hu>
In-Reply-To: <20050608103440.GA18380@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Eugeny S. Mints <emints@ru.mvista.com> wrote:
> 
> 
>>seems there is a race in drivers/net/usbnet.c in full RT mode. To be 
>>honest I haven't hardly checked this on the latest kernel and latest 
>>RT patch but just took a look at usbnet.c and latest RT patch and 
>>haven't observed any related changes.
> 
> 
> thanks, i've applied your patch to my tree. Note that your patch is 
> specific to the -RT kernel (both in terms of semantics and in term of 
> API dependence), so it does not make any sense to apply it upstream.  
exactly. I put David in CC just to be sure usbnet.c has not been 
rewritten in the recent kerenls in sense of locking scheme.
	Eugeny
> David, please ignore it.
> 
> 	Ingo
> 
> 
> 


