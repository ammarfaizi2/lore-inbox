Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbTEHMUx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 08:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbTEHMUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 08:20:53 -0400
Received: from mail.Virginia.EDU ([128.143.2.9]:40955 "HELO mail.virginia.edu")
	by vger.kernel.org with SMTP id S261669AbTEHMUv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 08:20:51 -0400
Date: Thu, 8 May 2003 08:33:00 -0400 (EDT)
From: Vivek Sharma <vs3f@virginia.edu>
X-X-Sender: <vs3f@node1.unix.Virginia.EDU>
To: linux-kernel@vger.kernel.org
MMDF-Warning: Parse error in original version of preceding line at mail.virginia.edu
Subject: Exporting Symbols in 2.5.65
In-Reply-To: <S261367AbTEHMEi/20030508120438Z+6143@vger.kernel.org>
Message-ID: <Pine.A41.4.32.0305080820280.15010-100000@node1.unix.Virginia.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having problems accessing symbols which are exported in netsyms.c in
another module.

I'm using 2.5.65 with a Debian distribution.

I need linux 2.5 for some power scaling stuff and at the same time need
khttpd as well so I've added khttpd into the 2.5.65 source as a module.

On modprobe-ing khttpd, I get - Unknown symbols tcp_v4_lookup_listener and
tcp_openreq_cachep. I have made sure that tcp-related symbols get
exported/chosen in netsyms.c so my config is fine. My version of khttpd
also uses exported symbols from other modules but modprobe does not complain
on them!

Other modules like powernow-k7/netfilter, etc get modprobe-d without any
problems.

Also, I don't find /proc/ksyms (has this been changed?).

Any help would be greatly appreciated!

Thanks,
Vivek

