Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262172AbUK0FRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262172AbUK0FRd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 00:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262141AbUK0Dzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 22:55:32 -0500
Received: from zeus.kernel.org ([204.152.189.113]:5572 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262508AbUKZTd2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:33:28 -0500
Date: Fri, 26 Nov 2004 00:58:29 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 50/51: Device mapper support.
Message-ID: <20041125235829.GJ2909@elf.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101300802.5805.398.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101300802.5805.398.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This is the device mapper support plugin. Its sole purpose is to ensure
> that the device mapper allocates enough memory to process all of the I/O
> we want to throw at it.

This needs to go through dm people....

> +static struct suspend_proc_data disable_dm_support_proc_data = {
> +	.filename			= "disable_device_mapper_support",
> +	.permissions			= PROC_RW,
> +	.type				= SUSPEND_PROC_DATA_INTEGER,
> +	.data = {
> +		.integer = {
> +			.variable	= &suspend_dm_ops.disabled,
> +			.minimum	= 0,
> +			.maximum	= 1,
> +		}
> +	}
> +};

What is this good for? Debugging switch?
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
