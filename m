Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262004AbVGJSQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262004AbVGJSQE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 14:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262013AbVGJSQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 14:16:04 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:21734 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262004AbVGJSPt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 14:15:49 -0400
Date: Sun, 10 Jul 2005 20:15:55 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [33/48] Suspend2 2.1.9.8 for 2.6.12: 610-encryption.patch
Message-ID: <20050710181555.GG10904@elf.ucw.cz>
References: <11206164393426@foobar.com> <11206164431243@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11206164431243@foobar.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> +/*
> + * put_extent_chain.
> + *
> + * Frees a whole chain of extents.
> + */
> +void put_extent_chain(struct extentchain * chain)

This probably should be extent_chain.

> +#ifndef EXTENT_H
> +#define EXTENT_H
> +struct extentchain {
> +	int size; /* size of the extent ie sum (max-min+1) */
> +	int allocs;
> +	int frees;
> +	int debug;
> +	int timesusedoptimisation;

time_suse_d_optimisation? ;-).

								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
