Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282705AbRLBD2v>; Sat, 1 Dec 2001 22:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282703AbRLBD2j>; Sat, 1 Dec 2001 22:28:39 -0500
Received: from zero.tech9.net ([209.61.188.187]:7436 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S282702AbRLBD2a>;
	Sat, 1 Dec 2001 22:28:30 -0500
Subject: Re: [PATCH] Preemptible kernel for SH
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Cc: linuxsh-dev@lists.sourceforge.net
In-Reply-To: <1007261428.820.4.camel@phantasy>
In-Reply-To: <1007261428.820.4.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 01 Dec 2001 22:28:36 -0500
Message-Id: <1007263717.956.7.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ftp://ftp.kernel.org/pub/linux/kernel/people/rml/sh/sh-update-rml-2.4.16-1.patch

I went ahead and diffed 2.4.16 against the SH tree.  Thus you can patch
2.4.16 directly without checking into CVS.  Hopefully this might
encourage some testers.

ftp://ftp.kernel.org/pub/linux/kernel/people/rml/preempt-kernel/v2.4/preempt-kernel-rml-2.4.16-1.patch

ftp://ftp.kernel.org/pub/linux/kernel/people/rml/sh/preempt-kernel-sh-2.4.16-1.patch

The above is links to the preempt-kernel patch and the arch-sh specific
work.

Users need to patch 2.4.16 with the three patches above and enable
CONFIG_PREEMPT to create the preemptible kernel for SH.

	Robert Love

