Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263851AbTKLAie (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 19:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263855AbTKLAie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 19:38:34 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:46512 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263851AbTKLAid
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 19:38:33 -0500
Message-ID: <3FB18104.30906@cyberone.com.au>
Date: Wed, 12 Nov 2003 11:38:28 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Tom Sightler <ttsig@tuxyturvy.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Nick's scheduler v18
References: <1068589319.1557.1.camel@localhost.localdomain> <1068589837.1557.10.camel@localhost.localdomain>
In-Reply-To: <1068589837.1557.10.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Tom Sightler wrote:

>On Tue, 2003-11-11 at 17:22, Tom Sightler wrote:
>
>>http://www.kerneltrap.org/~npiggin/v18/
>>
>>Nothing exciting for desktop users. High end performance is now starting
>>to get better.
>>
>
>Hey Nick,
>
>Was this tested against single processor?  On my Dell Latitude C810 I
>can boot test9 and test9-mm2 without problems, but using the identical
>config with this patch my system will not even boot up all the way.  It
>stops at various stages during the init scripts.  It seems to
>consistently get further if I add elevator=deadline but it never boots
>all the way up in either case.
>
>No messages or other good info, just hangs and won't go any further. 
>Any thoughts?
>

Yeah, tested on UP. Sigh. Can I have a look at your .config? Do you have
preempt on?

Thanks


