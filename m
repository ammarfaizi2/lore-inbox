Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262263AbTGCMxZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 08:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262299AbTGCMxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 08:53:25 -0400
Received: from static213-229-38-018.adsl.inode.at ([213.229.38.18]:64155 "HELO
	home.winischhofer.net") by vger.kernel.org with SMTP
	id S262263AbTGCMxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 08:53:18 -0400
Message-ID: <3F042A24.6040609@winischhofer.net>
Date: Thu, 03 Jul 2003 15:05:40 +0200
From: Thomas Winischhofer <thomas@winischhofer.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en, de-at, de-de, sv
MIME-Version: 1.0
To: maximilian attems <maks@sternwelten.at>
CC: Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org
Subject: Re: [2.5 patch] move an unused variable in sis_main.c
References: <20030703104700.GA939@mail.sternwelten.at> <20030703114726.GK282@fs.tum.de> <20030703120404.GC939@mail.sternwelten.at>
In-Reply-To: <20030703120404.GC939@mail.sternwelten.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The version of sisfb you are dealing with is outdated. James Simmons has 
a newer one, and the absolute current one is on my website.

Thomas

maximilian attems wrote:
> On Thu, 03 Jul 2003, Adrian Bunk wrote:
> 
> 
>>If TWDEBUG does anything your patch breaks the compilation on kernel 2.4 
>>with gcc 2.95 .
>>
>>
> 
> 
> 
> thx for your attention but
> TWDEBUG is defined in drivers/video/sis/sis.h
> 
> #if 1
> #define TWDEBUG(x)
> #else
> #define TWDEBUG(x) printk(KERN_INFO x "\n");
> #endif
> 
> please correct me if it breaks one of this macros
> maks
> 
> 


-- 
Thomas Winischhofer
Vienna/Austria
thomas AT winischhofer DOT net          http://www.winischhofer.net/
twini AT xfree86 DOT org

