Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265994AbUFUDgH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265994AbUFUDgH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 23:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265997AbUFUDgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 23:36:07 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:1256 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S265994AbUFUDgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 23:36:04 -0400
Date: Sun, 20 Jun 2004 23:29:04 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.7-bk way too fast
In-Reply-To: <40D64DF7.5040601@pobox.com>
Message-ID: <Pine.GSO.4.33.0406202320020.25702-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; FORMAT=flowed
Content-ID: <Pine.GSO.4.33.0406202320022.25702@sweetums.bluetronic.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Jun 2004, Jeff Garzik wrote:
>Something is definitely screwy with the latest -bk.

I'm not seeing any troubles...

[root:pts/11{4}]spork:~/[11:26 PM]:uname -a
Linux spork.troz.com 2.6.7-SMP+BK@1.1400 #15 SMP BK[20040618194307] Fri Jun 18 15:56:38 EDT 2004 x86_64 x86_64 x86_64 GNU/Linux

time.c: Using 1.193182 MHz PIT timer.

>My guess would be someone broke HPET, but maybe not judging from other
>lkml reports.

It could be.  All my systems have an HPET enabled kernel, but none of them
are actually reporting HPET as a timing source.

--Ricky


