Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272608AbRHaFnT>; Fri, 31 Aug 2001 01:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272609AbRHaFnK>; Fri, 31 Aug 2001 01:43:10 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:10247 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S272608AbRHaFnD>;
	Fri, 31 Aug 2001 01:43:03 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200108310543.f7V5h3S452102@saturn.cs.uml.edu>
Subject: Re: Linux 2.4.9-ac5
To: kaos@ocs.com.au (Keith Owens)
Date: Fri, 31 Aug 2001 01:43:03 -0400 (EDT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), laughing@shared-source.org (Alan Cox),
        linux-kernel@vger.kernel.org
In-Reply-To: <9293.999222514@kao2.melbourne.sgi.com> from "Keith Owens" at Aug 31, 2001 11:48:34 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens writes:

> Solution: /proc/sys/kernel/tainted.  Set to 0 on boot, set to 1 by
> insmod when it finds a non-GPL module, printed by panic, extracted by
> ksymoops.  Any load of a proprietary module taints the kernel, even if
> it is later removed.  The kernel code for that sysctl only allows taint
> to be set, not to be cleared.

The LGPL, X11, and 2-clause BSD licenses shouldn't set the tainted flag.
Perhaps the licenses should simply be listed.

$ cat /proc/sys/kernel/licenses
GPL
Public Domain
unknown
BSD(2)
Microsoft-EULA-v666
