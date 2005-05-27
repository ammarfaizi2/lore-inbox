Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262479AbVE0NfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262479AbVE0NfF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 09:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262471AbVE0Nea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 09:34:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:49601 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262475AbVE0NeS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 09:34:18 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <200505270306.09425.blaisorblade@yahoo.it> 
References: <200505270306.09425.blaisorblade@yahoo.it>  <20050527003843.433BA1AEE88@zion.home.lan> 
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net,
       linuxsh-shmedia-dev@lists.sourceforge.net, linux-sh@m17n.org
Subject: Re: [patch 4/8] irq code: Add coherence test for PREEMPT_ACTIVE 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 22.0.50.1
Date: Fri, 27 May 2005 14:33:49 +0100
Message-ID: <14927.1117200829@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Blaisorblade <blaisorblade@yahoo.it> wrote:

> Ok, a grep shows that possible culprits (i.e. giving success to
> grep GENERIC_HARDIRQS arch/*/Kconfig, and using 0x4000000 as PREEMPT_ACTIVE, 
> as given by grep PREEMPT_ACTIVE include/asm-*/thread_info.h) are (at a first 
> glance): frv, sh, sh64.

For FRV that's simply because it got copied from the parent arch along with
other stuff. Feel free to move it... Do you want me to make you up a patch to
do so?

David
