Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932398AbWE3UVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbWE3UVn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 16:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbWE3UVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 16:21:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24977 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932398AbWE3UVm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 16:21:42 -0400
Date: Tue, 30 May 2006 13:25:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Drynoff <pauldrynoff@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm1 - doesn't boot
Message-Id: <20060530132540.a2c98244.akpm@osdl.org>
In-Reply-To: <20060530195417.e870b305.pauldrynoff@gmail.com>
References: <20060530195417.e870b305.pauldrynoff@gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2006 19:54:17 +0400
Paul Drynoff <pauldrynoff@gmail.com> wrote:

> During boot 2.6.17-rc5-mm1 I got such message:
> Uncompressing Linux... Ok, booting kernel.
> 
> And that's all, 2.6.17-rc5 booted successfully.

I'm not able to reproduce this with your .config.  Perhaps you could
disable kgdb, enable CONFIG_EARLY_PRINTK and boot with earlyprintk=vga (or,
better, earlyprintk=serial[,ttySn[,baudrate]]).

(you can get a nicer backtrace out gdb by simply using `bt', btw)
