Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932404AbVIZGXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbVIZGXd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 02:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbVIZGXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 02:23:33 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:53663 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932404AbVIZGXc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 02:23:32 -0400
Date: Mon, 26 Sep 2005 08:24:22 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RT: Add timeofday.h to ktimers.c
Message-ID: <20050926062422.GC3273@elte.hu>
References: <1127345911.19506.51.camel@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127345911.19506.51.camel@dhcp153.mvista.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> --- linux-2.6.13.orig/kernel/ktimers.c
> +++ linux-2.6.13/kernel/ktimers.c
> @@ -38,6 +38,7 @@
>  #include <linux/module.h>
>  #include <linux/notifier.h>
>  #include <linux/percpu.h>
> +#include <linux/timeofday.h>
>  #include <linux/ktimer.h>

thanks, applied.

	Ingo
