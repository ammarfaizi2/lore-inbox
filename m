Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131648AbRCOJfI>; Thu, 15 Mar 2001 04:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131654AbRCOJe6>; Thu, 15 Mar 2001 04:34:58 -0500
Received: from [195.211.46.202] ([195.211.46.202]:19224 "EHLO serv02.lahn.de")
	by vger.kernel.org with ESMTP id <S131648AbRCOJem>;
	Thu, 15 Mar 2001 04:34:42 -0500
Date: Thu, 15 Mar 2001 10:24:19 +0100 (CET)
From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Reply-To: <pmhahn@titan.lahn.de>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OOPS] 8139too
In-Reply-To: <000d01c0acc7$1e8388e0$5517fea9@local>
Message-ID: <Pine.LNX.4.33.0103151022220.1497-100000@titan.lahn.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Mar 2001, Manfred Spraul wrote:

> > after APM laptop suspend to disk
> > 8139too is build-in, not pcmcia
> > I often get hangups after suspend-to-disk if I'm connected to a
> > hub/switch.
> > This is the first oops I've actually seen and copied it by hand:
> Was the nic connected or not?
The network was pluged in, but eth0 was not yet ifconfig'ed up.

> It seems that rtl8139_resume() unconditionally enables the nic, even if
> it wasn't open()'ed. Then an interrupt arrives and crashes because some
> memory structures were not allocated.
Will take a look myself after my exams.

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de

