Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265321AbSJSKCi>; Sat, 19 Oct 2002 06:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265359AbSJSKCi>; Sat, 19 Oct 2002 06:02:38 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:47373 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S265321AbSJSKCg>; Sat, 19 Oct 2002 06:02:36 -0400
Message-Id: <200210191003.g9JA36p15311@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Adam Kropelin <akropel1@rochester.rr.com>, jgarzik@pobox.com
Subject: Re: [PATCH] 2.5: ewrk3 cli/sti removal by VDA
Date: Sat, 19 Oct 2002 14:55:58 +0000
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, Ben Greear <greearb@candelatech.com>,
       Andy Tai <lichengtai@yahoo.com>
References: <20021019021340.GA8388@www.kroptech.com>
In-Reply-To: <20021019021340.GA8388@www.kroptech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 October 2002 02:13, Adam Kropelin wrote:
> Below is a patch from Denis Vlasenko
> <vda@port.imtp.ilyichevsk.odessa.ua> which removes cli/sti in the
> ewrk3 driver. It tests out fine here with SMP & preempt.

Thanks. SMP & preempt testing is most important.

> Applies against 2.5.34 + ewrk3-ethtool patch. Also applies without
> ethtool patch with some offsets.
>
> (Denis, I took the liberty of forwarding this to Jeff since it works
> fine for me and the driver is pretty much useless without it. Scream
> if you don't want it applied...)

No problem.

I just want drivers to be _thoroughly_ tested while we fix them since
a flaky driver can spoil all efforts spent on making bulletproof core
kernel.

What methods do folks use to break NIC drivers?
It would be nice to have crash-my-nic toolset :-)

BTW, I wanted to learn about pktgen, but there's no pktgen in 2.5
(don't know why).
--
vda
