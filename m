Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289759AbSAJWyA>; Thu, 10 Jan 2002 17:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289760AbSAJWxu>; Thu, 10 Jan 2002 17:53:50 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:46094 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289759AbSAJWxh>; Thu, 10 Jan 2002 17:53:37 -0500
Subject: Re: memory-mapped i/o barrier
To: jbarnes@sgi.com (Jesse Barnes)
Date: Thu, 10 Jan 2002 23:05:04 +0000 (GMT)
Cc: davem@redhat.com, ralf@uni-koblenz.de, linux-kernel@vger.kernel.org
In-Reply-To: <20020110134859.A729245@sgi.com> from "Jesse Barnes" at Jan 10, 2002 01:48:59 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16OoFt-0005pt-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ia64, and I'm wondering if you guys will accept something similar.  On
> mips64, mmiob() could just be implemented as a 'sync', but I'm not
> sure how to do it (or if it's even necessary) on other platforms.

Wouldn't it be wise to pass the device to this. Someone somewhere is going
to have to read a bus dependant chipset register and need to know which
pci_device * is involved ?
