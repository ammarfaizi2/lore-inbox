Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132201AbRCVVyA>; Thu, 22 Mar 2001 16:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132214AbRCVVxt>; Thu, 22 Mar 2001 16:53:49 -0500
Received: from www.resilience.com ([209.245.157.1]:49051 "EHLO
	www.resilience.com") by vger.kernel.org with ESMTP
	id <S132201AbRCVVxf>; Thu, 22 Mar 2001 16:53:35 -0500
Mime-Version: 1.0
Message-Id: <p05100201b6e0248d1efd@[209.245.157.6]>
In-Reply-To: <3ABA42A8.A806D0E7@powertech.no>
In-Reply-To: <3ABA42A8.A806D0E7@powertech.no>
Date: Thu, 22 Mar 2001 13:52:51 -0800
To: linux-kernel@vger.kernel.org
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: Serial port latency
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>This is what the program does:
>
>     fd=open("/dev/ttyS0",O_NOCTTY | O_RDWR);
>
>     tcsetattr(fd,TCSANOW, &tio); /* setting baud, parity, raw mode, etc */
>
>     while() {
>             write( 6 bytes);   /* send command */
>             read( 2 bytes);    /* wait for reply */
>     }

What are your settings for VTIME and VMIN?

-- 
/Jonathan Lundell.
