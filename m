Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264654AbTAVWYA>; Wed, 22 Jan 2003 17:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264673AbTAVWYA>; Wed, 22 Jan 2003 17:24:00 -0500
Received: from [213.86.99.237] ([213.86.99.237]:60142 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S264654AbTAVWX7>; Wed, 22 Jan 2003 17:23:59 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.44.0301221630510.1168-100000@oddball.prodigy.com> 
References: <Pine.LNX.4.44.0301221630510.1168-100000@oddball.prodigy.com> 
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.5] Local printer not supported in 2.5? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 22 Jan 2003 22:29:56 +0000
Message-ID: <27817.1043274596@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


davidsen@tmr.com said:
> I still can't print from any 2.5 kernel. I have the printer driver
> loaded,  using:
>   alias parport_lowlevel parport_pc 

That's just the parallel port driver. Enable CONFIG_PRINTER and/or load 
lp.ko?

--
dwmw2


