Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284301AbRLIUl3>; Sun, 9 Dec 2001 15:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284327AbRLIUlT>; Sun, 9 Dec 2001 15:41:19 -0500
Received: from zero.tech9.net ([209.61.188.187]:27398 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S284301AbRLIUlD>;
	Sun, 9 Dec 2001 15:41:03 -0500
Subject: [PATCH] fully preemptible kernel
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Cc: kpreempt-tech@lists.sourceforge.net
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.06.08.57 (Preview Release)
Date: 09 Dec 2001 15:41:06 -0500
Message-Id: <1007930466.11789.2.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Updated preempt-kernel patches for 2.4.16 and 2.4.17-pre6 are now
available at:

 	ftp://ftp.kernel.org/pub/linux/kernel/people/rml/preempt-kernel

patches for various previous kernels are there as well, but not in sync
with this release.

This patch enables a fully preemptible linux kernel -- userspace
processes are preemptible by higher priority tasks, even if running in
kernel space.  Nice gains in response _and_ throughput are observed.

The main change in this release is support for the SH architecture. 
i386 and ARM are also supported.

Testing and subsequent feedback is welcome.  Enjoy,

	Robert Love

