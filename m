Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267485AbTACKv2>; Fri, 3 Jan 2003 05:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267487AbTACKv2>; Fri, 3 Jan 2003 05:51:28 -0500
Received: from [218.104.80.12] ([218.104.80.12]:31617 "HELO netspeed-tech.com")
	by vger.kernel.org with SMTP id <S267485AbTACKv1>;
	Fri, 3 Jan 2003 05:51:27 -0500
Message-ID: <3E156C49.5090702@netspeed-tech.com>
Date: Fri, 03 Jan 2003 18:56:09 +0800
From: ZHAO Wei <zw@netspeed-tech.com>
Reply-To: zhaoway@public1.ptt.js.cn
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.3b) Gecko/20030102
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@codemonkey.org.uk>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: odd phenomenon.
References: <20030103103816.GA2567@codemonkey.org.uk>
In-Reply-To: <20030103103816.GA2567@codemonkey.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> Something strange I've noticed on all recent 2.4 and 2.5 kernels.
> 
> If I start galeon whilst I've got a bk pull in operation, the
> galeon process starts, opens its window, and then dies instantly.
> Starting it a second time works.
> 
> Its not OOM, as theres plenty of free RAM, and half gig of free (unused) swap.
> 
> It's almost 100% reproducable here.  Only seen it do it on this box
> though which is a P4 with HT, so it could be SMP related..

I used to have a small system with 96M RAM and no swap, only OpenSSH 
and bash and some kernel threads were running, when I got a big BK 
pull, it would catch sig 11 and die. Maybe this is unrelated. 
Indeed, at first I had only 64M RAM installed, only after some sig 
11, had I got more RAM installed. But this probably has nothing to 
do with your situation.

