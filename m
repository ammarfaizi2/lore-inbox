Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313139AbSC1MsN>; Thu, 28 Mar 2002 07:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313146AbSC1MsE>; Thu, 28 Mar 2002 07:48:04 -0500
Received: from E0-IBE.r.miee.ru ([194.226.0.89]:41733 "EHLO ibe.miee.ru")
	by vger.kernel.org with ESMTP id <S313139AbSC1Mrw>;
	Thu, 28 Mar 2002 07:47:52 -0500
From: Samium Gromoff <root@ibe.miee.ru>
Message-Id: <200203281538.g2SFcUl06361@ibe.miee.ru>
Subject: Re: Networking with slow CPUs
To: pwaechtler@loewe-komp.de
Date: Thu, 28 Mar 2002 18:38:29 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Is there a possibility to "harden" a small machine (33 MHz embedded
> > device) against e.g. flood pings from the outside world?
> >
> 
> AFAIK, there is a mechanism to switch off the interrupts generated
> by the network card, if the load is getting too high. This way the
> packets get overwritten on the nic buffers and do not even reach
> the CPU.
	this is a whole new strategy: ie you switch from interrupt-driven handling
to periodicall polls of the NIC.
	last time i`ve heard of it it was the bleeding edge Jamal`s model
of the lowlevel network engine.

regards, Samium Gromoff
