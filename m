Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262009AbVGJSWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbVGJSWk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 14:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbVGJSWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 14:22:39 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:58785 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262010AbVGJSWF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 14:22:05 -0400
Date: Sun, 10 Jul 2005 20:22:14 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [44/48] Suspend2 2.1.9.8 for 2.6.12: 620-userui.patch
Message-ID: <20050710182214.GJ10904@elf.ucw.cz>
References: <11206164393426@foobar.com> <1120616444451@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1120616444451@foobar.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On St 06-07-05 12:20:44, Nigel Cunningham wrote:
> diff -ruNp 621-swsusp-tidy.patch-old/kernel/power/swsusp.c 621-swsusp-tidy.patch-new/kernel/power/swsusp.c
> --- 621-swsusp-tidy.patch-old/kernel/power/swsusp.c	2005-06-20 11:47:31.000000000 +1000
> +++ 621-swsusp-tidy.patch-new/kernel/power/swsusp.c	2005-07-04 23:14:19.000000000 +1000
> @@ -36,6 +36,8 @@
>   * For TODOs,FIXMEs also look in Documentation/power/swsusp.txt
>   */
>  
> +#define KERNEL_POWER_SWSUSP_C

Headers that change depending on #define's are considered evil......

								Pavel

-- 
teflon -- maybe it is a trademark, but it should not be.
