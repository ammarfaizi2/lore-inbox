Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964813AbWJOHX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbWJOHX0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 03:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964818AbWJOHX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 03:23:26 -0400
Received: from gepetto.dc.ltu.se ([130.240.42.40]:25504 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S964813AbWJOHXZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 03:23:25 -0400
Message-ID: <4531E294.7050205@student.ltu.se>
Date: Sun, 15 Oct 2006 09:26:12 +0200
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] Char: stallion, use pr_debug macro
References: <347066701121713986@wsc.cz>
In-Reply-To: <347066701121713986@wsc.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the late respond, just saw it...

Jiri Slaby wrote:
> stallion, use pr_debug macro
>   
As it is a driver, is it not recommended to use the "dev_dbg()" found in 
include/linux/device.h, instead of pr_debug?
> Use pr_debug kernel macro instead of #ifdef DEBUG | printk() | #endif
>
> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
>
> ---
> commit bcedfb013b6cf4869f506acf66d31e73e8d04c10
> tree 328e7d04ca9712869050d0ad1cbaee1755ea766f
> parent a17f8130e4af536608ed6f93341003dd5f0af825
> author Jiri Slaby <jirislaby@gmail.com> Thu, 12 Oct 2006 23:05:59 +0200
> committer Jiri Slaby <jirislaby@gmail.com> Thu, 12 Oct 2006 23:05:59 +0200
>   
See ya
Richard Knutsson

