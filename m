Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318123AbSIAWFB>; Sun, 1 Sep 2002 18:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318133AbSIAWFB>; Sun, 1 Sep 2002 18:05:01 -0400
Received: from p50887EBD.dip.t-dialin.net ([80.136.126.189]:43490 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318123AbSIAWFA>; Sun, 1 Sep 2002 18:05:00 -0400
Date: Sun, 1 Sep 2002 16:09:26 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Oliver Neukum <oliver@neukum.name>
cc: Thunder from the hill <thunder@lightweight.ods.org>,
       Ralf Baechle <ralf@uni-koblenz.de>, <linux-kernel@vger.kernel.org>
Subject: Re: question on spinlocks
In-Reply-To: <200209020002.41381.oliver@neukum.name>
Message-ID: <Pine.LNX.4.44.0209011607380.3234-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2 Sep 2002, Oliver Neukum wrote:
> > > No; spin_lock_irqsave/spin_unlock_irqrestore and spin_lock/spin_unlock
> > > have to be used in matching pairs.
> >
> > If it was his least problem! He'll run straight into a "schedule w/IRQs
> > disabled" bug.
> 
> OK, how do I drop an irqsave spinlock if I don't have flags?

IMHO you might even ask "How do I start a car when I don't have the keys?"

You might find a way, but it's not desired. Are you sure you want to 
reschedule in an interrupt handler? If it's none, are you sure you want to 
disable interrupts?

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

