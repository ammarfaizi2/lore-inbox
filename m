Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266216AbUJEW6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266216AbUJEW6c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 18:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266233AbUJEW6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 18:58:32 -0400
Received: from chaos.analogic.com ([204.178.40.224]:896 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S266216AbUJEW6a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 18:58:30 -0400
Date: Tue, 5 Oct 2004 18:58:24 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Linux-2.6.5-1.358 SMP
Message-ID: <Pine.LNX.4.53.0410051852250.351@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I almost have everything converted over from 2.4.26 to
2.6.whatever.

I need to make some modules that have lots of assembly code.
This assembly uses the UNIX calling convention and can't be
re-written (it would take many months). The new kernel
is compiled with "-mregparam=2". I can't find where that's
defined. I need to remove it because I cannot pass parameters
to the assembly stuff in registers.

Where is it defined??? I grepped through all the scripts and
the hidden files, but I can't discover where it's defined.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.

