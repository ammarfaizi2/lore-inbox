Return-Path: <linux-kernel-owner+w=401wt.eu-S1945979AbWLVIZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945979AbWLVIZu (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 03:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945980AbWLVIZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 03:25:50 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:22554 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945977AbWLVIZt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 03:25:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=d0iJ1yvaxPcdWsP7Z4Z1SHte5J8PsK10qv47is+MFcqctaUPBs5JUyLwgdT0wQkvFRsF23gBQlLUGYj3l2sf+c3JV5rEIrfTAyW5sj2uVSAiKUIvs3k1WD/Bxp9n28xo/YbaCvbvPBfqg0x81urYz73XXwnhjzTCDuDWsiiBNHo=
Message-ID: <458B9689.7070300@gmail.com>
Date: Fri, 22 Dec 2006 09:25:45 +0100
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, tglx@linutronix.de,
       David Brownell <dbrownell@users.sourceforge.net>, dwalker@mvista.com,
       khilman@mvista.com, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH -rt 0/4] ARM: OMAP: Add clocksource and clockevent driver
 for OMAP
References: <458A471C.3090402@gmail.com> <20061221094341.GA9203@elte.hu>
In-Reply-To: <20061221094341.GA9203@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
From: Dirk Behme <dirk.behme@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Dirk Behme <dirk.behme@googlemail.com> wrote:
>>
>>the following patches for CONFIG PREEMPT RT add clocksource and 
>>clockevent driver for ARM based TI OMAP devices.
>>
>>They are against linux-2.6.19 + patch-2.6.20-rc1 + 
>>patch-2.6.20-rc1-rt1. The clocksource patch went through several 
>>review cycles on OMAP list.
> 
> thanks. I've added them to the -rt tree and it should be in the next 
> release (2.6.20-rt2).

I just tried -rt3 (linux-2.6.19 + patch-2.6.20-rc1 + 
patch-2.6.20-rc1-rt3) on embedded ARM based TI OMAP OSK 
board. It compiles and boots without any additional patches :)

Hopefully -rt will be merged into mainline someday soon.

Thanks

Dirk
