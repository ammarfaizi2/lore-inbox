Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbTE2AoW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 20:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbTE2AoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 20:44:22 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:30636 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S261785AbTE2AoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 20:44:21 -0400
Date: Wed, 28 May 2003 21:55:39 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.21-rc6
Message-ID: <Pine.LNX.4.55L.0305282019160.321@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Here goes -rc6. I've decided to delay 2.4.21 a bit and try Andrew's fix
for the IO stalls/deadlocks.

Please test it.


Summary of changes from v2.4.21-rc5 to v2.4.21-rc6
============================================

<c-d.hailfinger.kernel.2003@gmx.net>:
  o IDE config.in correctness

Andi Kleen <ak@muc.de>:
  o x86-64 fix for the ioport problem

Andrew Morton <akpm@digeo.com>:
  o Fix IO stalls and deadlocks

Marcelo Tosatti <marcelo@freak.distro.conectiva>:
  o Add missing via82xxx PCI ID
  o Backout erroneous fsync on last opener at close()
  o Changed EXTRAVERSION to -rc6

