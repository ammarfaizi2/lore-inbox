Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750901AbWHPFyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbWHPFyg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 01:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750903AbWHPFyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 01:54:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28126 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750901AbWHPFyf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 01:54:35 -0400
Date: Tue, 15 Aug 2006 22:53:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <support@moxa.com.tw>, <julioarr@fisica.uh.cu>
Subject: Re: [PATCH 1/1 -resend] Char: mxser, upgrade to 1.9.1
Message-Id: <20060815225346.cf7ca950.akpm@osdl.org>
In-Reply-To: <mxser191resend3_ee43092305ba163fd5d4@wsc.cz>
References: <mxser191resend3_ee43092305ba163fd5d4@wsc.cz>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2006 04:00:14 -0700
Jiri Slaby <jirislaby@gmail.com> wrote:

> Change driver according to original 1.9.1 moxa driver. Some int->ulong
> conversions, outb ~UART_IER_THRI constant. Remove commented stuff.
> 
> I also added printk line with info, if somebody wants to test it, he should
> contact me as I can potentially debug the driver with him or just to confirm
> it works properly.

Ho hum, this is hard.  I guess breaking the driver is one way to find out
who is using it, but those who redistribute the kernel for a living might
not appreciate the technique.

Perhaps we could create an mxser-new.c and offer that in config, plan to
remove mxser.c N months hence?
