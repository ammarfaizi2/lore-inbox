Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288969AbSCCUlo>; Sun, 3 Mar 2002 15:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288980AbSCCUlg>; Sun, 3 Mar 2002 15:41:36 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28686 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288969AbSCCUlZ>; Sun, 3 Mar 2002 15:41:25 -0500
Subject: Re: latency & real-time-ness.
To: greearb@candelatech.com (Ben Greear)
Date: Sun, 3 Mar 2002 20:55:59 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <3C828393.7030501@candelatech.com> from "Ben Greear" at Mar 03, 2002 01:12:03 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16hd1T-0005QW-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm running the program at nice -18.
> So, what kind of things can I do to decrease the latency?

Hack up the ksoftirq stuff to only fall back to ksoftirqd after about
500 iterations instead of one is one little detail to deal with

> Would the low-latency patch help me?

Yes
