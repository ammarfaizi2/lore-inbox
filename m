Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280602AbRKGMI7>; Wed, 7 Nov 2001 07:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280628AbRKGMIj>; Wed, 7 Nov 2001 07:08:39 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:25874 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280602AbRKGMIe>; Wed, 7 Nov 2001 07:08:34 -0500
Subject: Re: VIA 686 timer bugfix incomplete
To: diemer@gmx.de (Jonas Diemer)
Date: Wed, 7 Nov 2001 12:15:47 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux Kermel ML)
In-Reply-To: <20011107125012.6b1fbdc3.diemer@gmx.de> from "Jonas Diemer" at Nov 07, 2001 12:50:12 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E161RcS-0003x8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> but it seems that the patch was incomplete: The bug is still triggered on my
> computer using 2.4.14, but the bugfix seems to work whith -ac kernels.

The first piece is in.

> you can see what's missing to actually work around the via timer bug. I hope
> this will go into 2.4.15.

I don't plan to submit it until the locking fixes for the timer access are
done and we know the real cause
