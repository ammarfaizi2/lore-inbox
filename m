Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965039AbVI0SiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965039AbVI0SiJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 14:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965041AbVI0SiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 14:38:08 -0400
Received: from mail-kan.bigfish.com ([63.161.60.29]:9055 "EHLO
	mail10-kan-R.bigfish.com") by vger.kernel.org with ESMTP
	id S965039AbVI0SiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 14:38:07 -0400
X-BigFish: V
Message-ID: <4339918C.2040405@am.sony.com>
Date: Tue, 27 Sep 2005 11:38:04 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       Christopher Friesen <cfriesen@nortel.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, george@mvista.com, johnstul@us.ibm.com,
       paulmck@us.ibm.com
Subject: Re: [ANNOUNCE] ktimers subsystem
References: <Pine.LNX.4.61.0509271839140.3728@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0509271839140.3728@scrub.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> On Sun, 25 Sep 2005, Thomas Gleixner wrote:
>>Can you please point out which architectures do not have a 32x32->64
>>instruction ?

<snip>
> For the rest you might want to check <asm/div64.h>, if div64 has to be 
> emulated, there are good chances this instruction has to be emulated as 
> well (especially in smaller embedded archs).

Hmmm.  In my experience, there are several embedded platforms
with a 32x32->64 instruction, which are lacking a div64 instruction.
I don't think checking for div64 is a very good metric here.

=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
=============================

