Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265781AbUFIN3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265781AbUFIN3K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 09:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263663AbUFIN1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 09:27:49 -0400
Received: from tristate.vision.ee ([194.204.30.144]:19864 "HELO mail.city.ee")
	by vger.kernel.org with SMTP id S265780AbUFIN1G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 09:27:06 -0400
Message-ID: <40C71031.2050500@vision.ee>
Date: Wed, 09 Jun 2004 16:27:13 +0300
From: =?ISO-8859-1?Q?Lenar_L=F5hmus?= <lenar@vision.ee>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040605)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: ACPI / cpu temperature problem
References: <1086783539.14784.24.camel@linux.local>
In-Reply-To: <1086783539.14784.24.camel@linux.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Hans Kristian Rosbach wrote:

>Now, the problem with all these supermicro servers is that the
>temperature seems to be stuck at 27 C. No matter what load or
>temperature in the room. Something is clearly wrong.
>What can be done to fix this? We tried setting polling_frequency
>to '10', but that made no difference.
>  
>
To confirm this I've found this:

Last kernel I used was 2.6.7-rc1-mm1. There "acpi -t" was reporting 
correct temperatures (as lm-sensors).
Now with 2.6.7-rc2-mm2 It reports 22C constantly. lm-sensors gives 40-43C.

This is on nForce2 MB with Athlon XP2500+

Same .config.

Lenar
