Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287149AbSABWlF>; Wed, 2 Jan 2002 17:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287110AbSABWkR>; Wed, 2 Jan 2002 17:40:17 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:52494 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287116AbSABWkI>; Wed, 2 Jan 2002 17:40:08 -0500
Subject: Re: ISA slot detection on PCI systems?
To: esr@thyrsus.com
Date: Wed, 2 Jan 2002 22:50:47 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), davej@suse.de (Dave Jones),
        linux-kernel@vger.kernel.org (Linux Kernel List)
In-Reply-To: <20020102172448.A18153@thyrsus.com> from "Eric S. Raymond" at Jan 02, 2002 05:24:48 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16LuDf-0005pp-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But you're thinking like a developer, not a user.  The right question
> is which approach requires the lowest level of *user* privilege to get
> the job done.  Comparing world-readable /proc files versus a setuid app,
> the answer is obvious.  This sort of thing is exactly what /proc is *for*.

Both require the same level of user privilege. 

	cat /proc/wasteofmemory/dmi | dmidecoder
v
	/sbin/dmidump | dmidecoder

