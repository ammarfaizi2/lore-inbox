Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264588AbTLGXZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 18:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264589AbTLGXZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 18:25:57 -0500
Received: from mail-04.iinet.net.au ([203.59.3.36]:46313 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S264588AbTLGXZ4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 18:25:56 -0500
Message-ID: <3FD3B221.1060200@cyberone.com.au>
Date: Mon, 08 Dec 2003 10:05:05 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: =?ISO-8859-15?Q?Markus_H=E4stbacka?= <midian@ihme.org>
CC: Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: Nick's scheduler v19a
References: <3FB62608.4010708@cyberone.com.au>	 <1069361130.13479.12.camel@midux>  <3FBD4F6E.3030906@cyberone.com.au>	 <1069395102.16807.11.camel@midux>  <3FBDAE99.9050902@cyberone.com.au>	 <1069405566.18362.5.camel@midux>  <3FBDD790.5060401@cyberone.com.au>	 <1070468086.17208.4.camel@midux>  <3FCE6073.7040503@cyberone.com.au> <1070833955.3572.2.camel@midux>
In-Reply-To: <1070833955.3572.2.camel@midux>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Markus Hästbacka wrote:

>Hi again Nick, I ported the patch forward to -bk1>, the problem was
>here:
><snip>
>-                       if (sync)
><snip>
>
>That should be:
><snip>
>-                       if (sync && (task_cpu(p) == smp_processor_id()))
><snip>
>when patchin kernel/sched.c
>Is this right?
>

Hi Markus,
Yep thats correct.


