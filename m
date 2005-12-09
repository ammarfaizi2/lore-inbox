Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932498AbVLIXZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbVLIXZg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 18:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932513AbVLIXZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 18:25:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:21421 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932498AbVLIXZf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 18:25:35 -0500
Date: Fri, 9 Dec 2005 15:26:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ben Gardner <gardner.ben@gmail.com>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] i386: CS5535 chip support - GPIO
Message-Id: <20051209152625.130641bb.akpm@osdl.org>
In-Reply-To: <808c8e9d0512070933re472072x43f35d454be699f1@mail.gmail.com>
References: <808c8e9d0512070933re472072x43f35d454be699f1@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Gardner <gardner.ben@gmail.com> wrote:
>
> +/* These are defined in cs5535.c */
> +extern u32 cs5535_gpio_base;
> +extern u32 cs5535_gpio_mask;

And they should be declared in a header file, please.

Is there a reason for these being exported to non-GPL modules, or can they
be EXPORT_SYMBOL_GPL()?
