Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264016AbTEFSWP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 14:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264012AbTEFSVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 14:21:52 -0400
Received: from lakemtao04.cox.net ([68.1.17.241]:46243 "EHLO
	lakemtao04.cox.net") by vger.kernel.org with ESMTP id S264011AbTEFSVn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 14:21:43 -0400
Message-ID: <3EB80013.3020502@cox.net>
Date: Tue, 06 May 2003 13:33:55 -0500
From: David van Hoose <davidvh@cox.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: walt <wa1ter@myrealbox.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.69] Fails on "Uncompressing Kernel" (detailed)
References: <fa.athqjpk.133cvik@ifi.uio.no> <3EB7D399.4090109@myrealbox.com>
In-Reply-To: <3EB7D399.4090109@myrealbox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

walt wrote:
> David van Hoose wrote:
> 
>> I've managed to get 2.5.69 to boot *once*. Not trusting the kernel to 
>> report the numerous problems until I can boot the kernel more than 
>> once. I lost my config so I can't figure out what I managed to do so 
>> right. I have tried a couple other configs that I normally use for 
>> 2.4.x, but with the new 2.5.x options. Those I have attached.
>> All I get is the "Uncompressing Linux" and then no more output. 
>> However, it appears that my system is booting anyway as if it is on 
>> another TTY. 
> 
> The configuration menu has changed recently so that support for normal
> console operation is not included by default.  To activate the usual
> console on VT and on VGA requires selecting options that are buried
> in the 'Character device' 'Input device' and 'Graphics support' menu
> sections.  Go all the way to the bottom of each section and you will
> see the obvious items you need to select.  Rather a confusing change.

That's all nice, but why have those options been removed if input 
devices are created as modules? This somewhat breaks compatibility with 
a lot of 2.4.x scripts. I run both kernels so I can compare things and 
send bug reports with both trees. Also, 2.5.x has been rather cruel to 
me in the past, so I tend to run the stable branch more often than not. 
Can the VT and VGA options be placed back into the config if input 
devices are created as modules? It would remove some confusion imo.

Thanks,
David

