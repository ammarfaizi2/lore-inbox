Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129723AbRBSW0c>; Mon, 19 Feb 2001 17:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129798AbRBSW0W>; Mon, 19 Feb 2001 17:26:22 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:14858 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S129723AbRBSW0O>; Mon, 19 Feb 2001 17:26:14 -0500
Date: Mon, 19 Feb 2001 22:25:59 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Philipp Rumpf <prumpf@mandrakesoft.com>
cc: Russell King <rmk@arm.linux.org.uk>, Andrew Morton <andrewm@uow.edu.au>,
        Kenn Humborg <kenn@linux.ie>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: kernel_thread() & thread starting
In-Reply-To: <Pine.LNX.3.96.1010219152412.32729D-100000@mandrakesoft.mandrakesoft.com>
Message-ID: <Pine.LNX.4.30.0102192225350.24949-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Feb 2001, Philipp Rumpf wrote:

> No.  If kswapd oopses it's a bug in kswapd (or related code).  If keventd
> oopses most likely the broken code is actually the task queue you
> scheduled, which belongs to your driver.

If we're going to detect this case, we might as well just restart keventd.

-- 
dwmw2


