Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965167AbWJBRpg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965167AbWJBRpg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 13:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965171AbWJBRpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 13:45:35 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:27345 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S965167AbWJBRpf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 13:45:35 -0400
Subject: Re: hrtimers bug message on 2.6.18-rt4
From: john stultz <johnstul@us.ibm.com>
To: Clark Williams <williams@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <45214EDC.6060706@redhat.com>
References: <45214EDC.6060706@redhat.com>
Content-Type: text/plain
Date: Mon, 02 Oct 2006 10:45:30 -0700
Message-Id: <1159811130.5873.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-02 at 12:39 -0500, Clark Williams wrote:
> I was debugging a PI mutex stress test when I got the following message
> on my Athlon64x2 (running 2.6.18-rt4):
> 
> BUG: time warp detected!
> prev > now, 101878c199393108 > 101878c081eaca2b:
> = 4685981405 delta, on CPU#0
>  [<c0104c3c>] show_trace+0x2c/0x30
>  [<c0104dcb>] dump_stack+0x2b/0x30
>  [<c012ec89>] getnstimeofday+0x249/0x270

Could you send me your dmesg and .config?

thanks
-john


