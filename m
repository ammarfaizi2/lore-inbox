Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262978AbTHVBuy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 21:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262980AbTHVBuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 21:50:54 -0400
Received: from [202.107.117.26] ([202.107.117.26]:8407 "EHLO ldap")
	by vger.kernel.org with ESMTP id S262978AbTHVBuw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 21:50:52 -0400
Date: Fri, 22 Aug 2003 09:50:43 +0800
From: "Bill J.Xu" <xujz@neusoft.com>
Subject: Re: "ctrl+c" disabled!
To: root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org
Message-id: <046101c3684f$cc3498d0$2a01010a@avwindows>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.3790.0
X-Mailer: Microsoft Outlook Express 6.00.3790.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
References: <036601c367e0$01adabc0$2a01010a@avwindows>
 <Pine.LNX.4.53.0308210842100.2668@chaos>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I use the serial line to connect my computer with linux box, and I use the SecureCRT.
The following is the corresponding configuration of linux box' inittab file.

# Serial lines
s1:12345:respawn:/sbin/agetty -L 9600 ttyS0 vt100
s2:12345:respawn:/sbin/agetty 9600 ttyS1 vt100

Thank you, dear Dick Johnson


Bill


----- Original Message ----- 
From: "Richard B. Johnson" <root@chaos.analogic.com>
To: "Bill J.Xu" <xujz@neusoft.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Thursday, August 21, 2003 8:46 PM
Subject: Re: "ctrl+c" disabled!


> On Thu, 21 Aug 2003, Bill J.Xu wrote:
> 
> > hello everyone,
> >
> > when I connect linux through serial port,and run a program such as "ping xxx.xxx.xxx.xxx",then I can not stop it by using "ctrl+c".and the only way is to telnet it,and kill that progress
> >
> > why?
> >
> > thanks
> >
> > Bill J.Xu
> > -
> How do you 'connect' through the serial port? You need to use a
> serial `getty` that properly sets up the terminal. The 'mini-getty'
> used on recent distributions doesn't bother.
> Also, if you are not using a real terminal, you need to use a terminal
> program that actually sends a ^C.
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
>             Note 96.31% of all statistics are fiction.
> 
> 
> 
