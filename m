Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291020AbSBGBFl>; Wed, 6 Feb 2002 20:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291022AbSBGBFb>; Wed, 6 Feb 2002 20:05:31 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:3344 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291020AbSBGBFP>; Wed, 6 Feb 2002 20:05:15 -0500
Subject: Re: want opinions on possible glitch in 2.4 network error reporting
To: root@chaos.analogic.com
Date: Thu, 7 Feb 2002 00:24:10 +0000 (GMT)
Cc: cfriesen@nortelnetworks.com (Chris Friesen), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1020206154220.29419A-100000@chaos.analogic.com> from "Richard B. Johnson" at Feb 06, 2002 03:56:43 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16YcME-0006vx-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hackers code sendto as:
> 	sendto(s,...);
> Professional programmers use:
> 	(void)sendto(s,...);

Remind me never to hire one of your professional programmers

> checking the return value is useless.

Not so. For a large number of situations its extremely informative. 
