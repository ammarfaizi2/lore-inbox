Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964783AbVKGFty@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbVKGFty (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 00:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbVKGFtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 00:49:53 -0500
Received: from pacific.moreton.com.au ([203.143.235.130]:63242 "EHLO
	cyberguard.com.au") by vger.kernel.org with ESMTP id S964783AbVKGFtw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 00:49:52 -0500
Message-ID: <436EEB2B.9060109@snapgear.com>
Date: Mon, 07 Nov 2005 15:50:35 +1000
From: Greg Ungerer <gerg@snapgear.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Milton Miller <miltonm@bga.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]: linux-2.6.14-uc0 (MMU-less support)
References: <40564dc5fa508b27c752b692f93562f4@bga.com> <20051105191224.GB4493@stusta.de>
In-Reply-To: <20051105191224.GB4493@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

Adrian Bunk wrote:
>>
>>>ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
>>>-CFLAGS		+= -Os
>>>+CFLAGS		+= -O
>>>else
>>>CFLAGS		+= -O2
>>>endif
>>
>>Sees this undoes part of the benefit, perhaps you should add a
>>third option.
> 
> 
> Even further, I don't see any reason for using -O - the resulting code 
> is expected to be both bigger and slower than with -Os.
> 
> Is this a workaround for a gcc bug on some platform?

Yes, extacly, it is. See other post on this for more details.
Still shouldn't be here though.

Regards
Greg



------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude       EMAIL:     gerg@snapgear.com
SnapGear -- a CyberGuard Company            PHONE:       +61 7 3435 2888
825 Stanley St,                             FAX:         +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia         WEB: http://www.SnapGear.com
