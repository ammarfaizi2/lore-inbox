Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbTDOOek (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 10:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbTDOOek 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 10:34:40 -0400
Received: from [62.231.65.103] ([62.231.65.103]:6149 "HELO ultrapopular.com")
	by vger.kernel.org with SMTP id S261595AbTDOOei 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 10:34:38 -0400
Message-ID: <3E9C1B7C.2010807@easynet.ro>
Date: Tue, 15 Apr 2003 17:47:24 +0300
From: Alexandru Damian <ddalex_krn@easynet.ro>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ro-RO; rv:1.2.1) Gecko/20030225
X-Accept-Language: ro, en, en-us
MIME-Version: 1.0
To: filip <filip_@op.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: paralel port - doesn't keep pins states
References: <E192JNC-0004Dy-00@f28.test.onet.pl>
In-Reply-To: <E192JNC-0004Dy-00@f28.test.onet.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

filip wrote:

>Hello,
>
>I hope it is the right place to ask about my problem...
>
>I want to use /dev/lp0 (lp module) on my PC for controlling
>external devices.
>The problem is when I wtire 1 byte to /dev/lp0, paralel port
>keeps this state just for few ms...
>(I made special plug - so the is no problem with handshake - details on:
>http://www.hut.fi/Misc/Electronics/circuits/nullprint.html)
>  
>
It's normal, since the parallel -port specification clearly states that 
the port doesn't maintain
the pins voltage more than a minimum mandatory delay, and while setting, 
the
state is undefined.

>It is strange because everything works corect on my old PC (Pentium160).
>
That was broken hardware, it didn't meet the specifications :))

>
>Regards,
>Filip
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>


