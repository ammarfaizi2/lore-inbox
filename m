Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbTJ2ClB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 21:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbTJ2ClB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 21:41:01 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:2956 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261746AbTJ2ClA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 21:41:00 -0500
Message-ID: <3F9F28B8.9030807@cyberone.com.au>
Date: Wed, 29 Oct 2003 13:40:56 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Olien <dmo@osdl.org>
CC: cliff white <cliffw@osdl.org>, mhf@linuxmail.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test8/test9 io scheduler needs tuning?
References: <200310261201.14719.mhf@linuxmail.org> <20031027145531.2eb01017.cliffw@osdl.org> <3F9DAF2C.8010308@cyberone.com.au> <20031028092612.68d1c80d.cliffw@osdl.org> <20031028211844.GA8285@osdl.org>
In-Reply-To: <20031028211844.GA8285@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Dave Olien wrote:

>Yes, it seems Nick's latest patch from 10/27, has helped reaim
>considerably.
>
>The dbt2 workload still has a problem though.  Mary ran this patch today,
>with deadline and with as-iosched:
>
>2.6.0-test9, elevator=deadline			1644 NOTPM 
>2.6.0-test9, unpatched as-iosched		 977 NOTPM
>2.6.0-test9, as-iosched with as-fix.patch	 980 NOTPM
>
>Higher NOTPM numbers are better.
>

OK, how does 2.6.0-test5 go on these tests?


