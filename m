Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265332AbTFVN6s (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 09:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265402AbTFVN5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 09:57:33 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:55560 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S265332AbTFVN53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 09:57:29 -0400
Date: Sat, 21 Jun 2003 09:04:37 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Lou Langholtz <ldl@aros.net>
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
       Steven Whitehouse <steve@chygwyn.com>
Subject: Re: [RFC][PATCH] nbd driver for 2.5.72
Message-ID: <20030621070437.GA474@zaurus.ucw.cz>
References: <3EF3F08B.5060305@aros.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EF3F08B.5060305@aros.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

It looks quite okay. Feel free to submit to
Linus when you are ready.
				Pavel


> +static int nbd_thread_start(nbd_device_t *lo, nbd_thread_t *th, thread_fn_t fn);

Hmmm, this certainly looks ugly.

> +static inline void wait_for_completion_interuptably(struct completion *x)

Spelling?


-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

