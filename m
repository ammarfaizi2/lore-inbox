Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314138AbSH0Fmr>; Tue, 27 Aug 2002 01:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314149AbSH0Fmr>; Tue, 27 Aug 2002 01:42:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:58475 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S314138AbSH0Fmq>;
	Tue, 27 Aug 2002 01:42:46 -0400
Message-Id: <5.1.0.14.2.20020827073106.00b8daf8@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 27 Aug 2002 07:44:26 +0200
To: root@chaos.analogic.com, george anzinger <george@mvista.com>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: Memory leak
Cc: Aleksandar Kacanski <kacanski@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1020826155614.6481A-100000@chaos.analogic.co
 m>
References: <3D6A8536.83B30C18@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 04:05 PM 8/26/2002 -0400, Richard B. Johnson wrote:
>There just might be some kind of memory leak, but, you can't tell
>it from looking at /proc/meminfo. You would need to instrument each
>procedure that allocates memory [...]

Ingo did that a long time ago in his memleak patch.  Unfortunately, it's
laying around unmaintained, as I ran out of time.  If someone wants a
(kernel) memory leak detector, all they have to is rip it out of the IKD
patch and update it (trivial).

         -Mike

