Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293002AbSCORu1>; Fri, 15 Mar 2002 12:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293008AbSCORuR>; Fri, 15 Mar 2002 12:50:17 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:65037 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293002AbSCORuF>; Fri, 15 Mar 2002 12:50:05 -0500
Subject: Re: [PATCH] Cleanup port 0x80 use (was: Re: IO delay ...)
To: Martin.Wilck@fujitsu-siemens.com (Martin Wilck)
Date: Fri, 15 Mar 2002 18:05:57 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel mailing list),
        Martin.Wilck@fujitsu-siemens.com (Martin Wilck)
In-Reply-To: <Pine.LNX.4.33.0203151736460.1477-100000@biker.pdb.fsc.net> from "Martin Wilck" at Mar 15, 2002 06:41:28 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16lw5V-0004ES-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am still wondering, though, why this method of getting a delay
> is used so often. IMO in most places one could use udelay(1) instead,
> with much less risk of doing wrong.

udelay(1) I don't believe is enough. Unfortunately I can't find my
documentation on the ISA bus which covers the timeout for acknowledging an
address cycle. Otherwise for tsc capable boxes I agree entirely.
