Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266500AbUGKFTS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266500AbUGKFTS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 01:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266501AbUGKFTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 01:19:18 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:10896 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266500AbUGKFTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 01:19:16 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: karim@opersys.com
Subject: Re: [PATCH] preset loops_per_jiffy for faster booting
Date: Sun, 11 Jul 2004 00:19:14 -0500
User-Agent: KMail/1.6.2
Cc: Adam Kropelin <akropel1@rochester.rr.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, tim.bird@am.sony.com,
       celinux-dev@tree.celinuxforum.org, tpoynor@mvista.com,
       geert@linux-m68k.org
References: <40EEF10F.1030404@am.sony.com> <200407102351.05059.dtor_core@ameritech.net> <40F0C8E8.2060908@opersys.com>
In-Reply-To: <40F0C8E8.2060908@opersys.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407110019.14558.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 10 July 2004 11:58 pm, Karim Yaghmour wrote:
> 
> Dmitry Torokhov wrote:
> > Do we need to encourage ordinary users to turn this option on? 99% of
> > non-embedded market is much safer with that option off...
> 
> There are other boot params that gather similar if not higher percentages.
> profile= is one of those.
>

I do not see anywhere in my boot log suggestion to activate profiling...
Nor I see recommendadtion to use idebus=66... But i will see suggesion to
set loops_per_jiffy. 

> Also, keep in mind that in a not too distant future (and indeed today for
> some folks already) recompiling and fine-tuning the Linux kernel for your
> latest gizmo will not be as foreign as your statement may make it sound.

Use of this particular option will require active tracking of kernel timer
code to ensure that lpj that was valid for kernel x.y.z is still valid for
kernel x.y.z+1. I do not beleive that normal user will ever care to do that
even in very distant future. Still, given that message in the boot log, many
will probably try the option.

I am no longer question presence of the code in the kernel, I just don't like
the message...

-- 
Dmitry
