Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272690AbRHaNt3>; Fri, 31 Aug 2001 09:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272689AbRHaNtT>; Fri, 31 Aug 2001 09:49:19 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:61704 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272688AbRHaNtN>; Fri, 31 Aug 2001 09:49:13 -0400
Subject: Re: Linux 2.4.9-ac5
To: kaos@ocs.com.au (Keith Owens)
Date: Fri, 31 Aug 2001 14:52:30 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), laughing@shared-source.org (Alan Cox),
        linux-kernel@vger.kernel.org
In-Reply-To: <9293.999222514@kao2.melbourne.sgi.com> from "Keith Owens" at Aug 31, 2001 11:48:34 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15coik-0003Ax-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Solution: /proc/sys/kernel/tainted.  Set to 0 on boot, set to 1 by
> insmod when it finds a non-GPL module, printed by panic, extracted by
> ksymoops.  Any load of a proprietary module taints the kernel, even if
> it is later removed.  The kernel code for that sysctl only allows taint
> to be set, not to be cleared.

That would certainly work well enough. 

Alan
