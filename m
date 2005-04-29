Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262999AbVD2VRv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262999AbVD2VRv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 17:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262998AbVD2VQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 17:16:47 -0400
Received: from fire.osdl.org ([65.172.181.4]:61348 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262997AbVD2VQQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 17:16:16 -0400
Date: Fri, 29 Apr 2005 14:15:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Phil Oester <kernel@linuxace.com>
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: NMI lockup in fib_sync_down
Message-Id: <20050429141543.3919fdfd.akpm@osdl.org>
In-Reply-To: <20050427212643.GA20483@linuxace.com>
References: <20050427212643.GA20483@linuxace.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phil Oester <kernel@linuxace.com> wrote:
>
> Trying to update from 2.6.10 to 2.6.11 on a gateway, and keep
>  getting an NMI lockup:
> 
>  NMI Watchdog detected LOCKUP on CPU1, eip c026a8d4, registers:
>  CPU:    1
>  EIP:    0060:[<c026a8d4>]    Not tainted VLI
>  EFLAGS: 00001482   (2.6.11) 
>  EIP is at fib_sync_down+0x74/0x140

This is believed to be fixed in current kernels.  Please retest 2.6.12-rc4
or 2.6.12-rc3-mm1 (neither are released yet) and let us know if the problem
is still there?

