Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311889AbSCUNob>; Thu, 21 Mar 2002 08:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311928AbSCUNoV>; Thu, 21 Mar 2002 08:44:21 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28680 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311889AbSCUNoM>; Thu, 21 Mar 2002 08:44:12 -0500
Subject: Re: Linux 2.4.19pre3-ac4
To: akropel1@rochester.rr.com (Adam Kropelin)
Date: Thu, 21 Mar 2002 14:00:20 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <006101c1d084$275029b0$02c8a8c0@kroptech.com> from "Adam Kropelin" at Mar 20, 2002 09:57:35 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16o376-0005FY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there a magic incantation I need in order to see an improvement from this?
> I'm observing a slight (< 10 KB) increase from -ac3 to -ac4. Same .config, same
> compiler.
> 
> I only build 2 modules; everything else is static. Perhaps Andrew's fix is for
> heavy module users?

The more you build the more change it makes. The big changes are in the
cost of BUG() stuff

If you use gcc 3.0+ then you should only see a small change anyway
