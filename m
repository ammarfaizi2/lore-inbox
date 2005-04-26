Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261458AbVDZLfO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbVDZLfO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 07:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261472AbVDZLfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 07:35:13 -0400
Received: from fire.osdl.org ([65.172.181.4]:59356 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261458AbVDZLfI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 07:35:08 -0400
Date: Tue, 26 Apr 2005 04:33:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: blaisorblade@yahoo.it, Mikael Pettersson <mikpe@csd.uu.se>
Cc: jdike@addtoit.com, bstroesser@fujitsu-siemens.com,
       linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
Subject: Re: [patch 1/7] uml: fix syscall table by including $(SUBARCH)'s
 one, for i386
Message-Id: <20050426043359.6674dc49.akpm@osdl.org>
In-Reply-To: <20050424181909.81B8F33AED@zion>
References: <20050424181909.81B8F33AED@zion>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

blaisorblade@yahoo.it wrote:
>
>  linux-2.6.12-paolo/arch/i386/kernel/entry.S                 |  292 ------------
>   linux-2.6.12-paolo/arch/i386/kernel/syscall_table.S         |  291 +++++++++++

gack.  Any time anyone touches the syscall tables I have to delicately
rework 8,000 perfctr patches.

So I folded all the perfctr patches into a single patch for now.  Later
I'll split it out into core and architectures.

