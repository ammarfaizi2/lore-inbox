Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318118AbSIAV6A>; Sun, 1 Sep 2002 17:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318123AbSIAV57>; Sun, 1 Sep 2002 17:57:59 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:62353 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S318118AbSIAV57> convert rfc822-to-8bit; Sun, 1 Sep 2002 17:57:59 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: Thunder from the hill <thunder@lightweight.ods.org>,
       Ralf Baechle <ralf@uni-koblenz.de>
Subject: Re: question on spinlocks
Date: Mon, 2 Sep 2002 00:02:41 +0200
User-Agent: KMail/1.4.1
Cc: <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0209011553140.3234-100000@hawkeye.luckynet.adm>
In-Reply-To: <Pine.LNX.4.44.0209011553140.3234-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209020002.41381.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > No; spin_lock_irqsave/spin_unlock_irqrestore and spin_lock/spin_unlock
> > have to be used in matching pairs.
>
> If it was his least problem! He'll run straight into a "schedule w/IRQs
> disabled" bug.

OK, how do I drop an irqsave spinlock if I don't have flags?

	Regards
		Oliver

