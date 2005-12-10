Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964966AbVLJKqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964966AbVLJKqm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 05:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964976AbVLJKqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 05:46:42 -0500
Received: from smtp.osdl.org ([65.172.181.4]:58288 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964966AbVLJKqm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 05:46:42 -0500
Date: Sat, 10 Dec 2005 02:45:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ben Gardner <gardner.ben@gmail.com>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] i386: CS5535 chip support - SMBus
Message-Id: <20051210024555.57803358.akpm@osdl.org>
In-Reply-To: <808c8e9d0512070934m25fb4a10pd0df8702b9228f2a@mail.gmail.com>
References: <808c8e9d0512070934m25fb4a10pd0df8702b9228f2a@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Module symbol problems with `make allmodconfig':

*** Warning: "cs5535_gpio_base" [drivers/i2c/busses/i2c-cs5535.ko] undefined!
*** Warning: "cs5535_gpio_mask" [drivers/char/cs5535_gpio.ko] undefined!
*** Warning: "cs5535_gpio_base" [drivers/char/cs5535_gpio.ko] undefined!

Perhaps CONFIG_CS5535=m wasn't supposed to be possible?
