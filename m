Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbVARI0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbVARI0R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 03:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbVARI0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 03:26:17 -0500
Received: from one.firstfloor.org ([213.235.205.2]:59080 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261181AbVARI0Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 03:26:16 -0500
To: vlobanov <vlobanov@speakeasy.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Typo in arch/x86_64/Kconfig
References: <Pine.LNX.4.58.0501172358520.5537@shell3.speakeasy.net>
From: Andi Kleen <ak@muc.de>
Date: Tue, 18 Jan 2005 09:26:15 +0100
In-Reply-To: <Pine.LNX.4.58.0501172358520.5537@shell3.speakeasy.net> (vlobanov@speakeasy.net's
 message of "Tue, 18 Jan 2005 00:01:23 -0800 (PST)")
Message-ID: <m1ekgj3zyw.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vlobanov <vlobanov@speakeasy.net> writes:

> diff -Nru a/arch/x86_64/Kconfig b/arch/x86_64/Kconfig
> --- a/arch/x86_64/Kconfig	2005-01-12 00:13:13.000000000 -0800
> +++ b/arch/x86_64/Kconfig	2005-01-17 23:57:22.000000000 -0800
> @@ -59,7 +59,7 @@
>  	  This is useful for kernel debugging when your machine crashes very
>  	  early before the console code is initialized. For normal operation
>  	  it is not recommended because it looks ugly and doesn't cooperate
> -	  with klogd/syslogd or the X server. You should normally N here,
> +	  with klogd/syslogd or the X server. You should normally say N here,
>  	  unless you want to debug such a crash.

The help text is useless anyways because the option is not user selectable,
but always enabled. I just removed it completely. Thanks

-Andi
