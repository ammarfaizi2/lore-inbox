Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261999AbVGJSDn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261999AbVGJSDn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 14:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262004AbVGJSDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 14:03:43 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:59307 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261999AbVGJSDm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 14:03:42 -0400
Date: Sun, 10 Jul 2005 20:03:51 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [29/48] Suspend2 2.1.9.8 for 2.6.12: 606-all-settings.patch
Message-ID: <20050710180351.GC10904@elf.ucw.cz>
References: <11206164393426@foobar.com> <11206164424113@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11206164424113@foobar.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> +static void suspend2_suspend_2(void)
> +{
> +	if (!save_image_part1()) {
> +		suspend_power_down();
> +
> +		if (suspend2_powerdown_method == 3) {
> +			int temp_result;
> +
> +			temp_result = read_pageset2(1);


Is that just me or do I see way too many numbers. suspend2_suspend_2
is really funny name for a functions. powerdown_method should really
use some symbolic constants.
								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
