Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbUBWXLU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 18:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbUBWXLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 18:11:15 -0500
Received: from fw.osdl.org ([65.172.181.6]:30902 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262112AbUBWXJ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 18:09:26 -0500
Date: Mon, 23 Feb 2004 15:11:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: Michael Hunold <hunold@convergence.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] tda1004x DVB frontend update
Message-Id: <20040223151111.441c0d6d.akpm@osdl.org>
In-Reply-To: <403A841E.9090700@convergence.de>
References: <10775702831806@convergence.de>
	<10775702843054@convergence.de>
	<20040223140943.7e58eb5c.akpm@osdl.org>
	<403A841E.9090700@convergence.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Hunold <hunold@convergence.de> wrote:
>
> Changing the i2c subsystem would require changes in all frontend drivers 
> + plus in the dvb drivers exporting the i2c facilities.
> 
> Is such a big change acceptable for 2.6 if it fixes these horrible hacks 
> or is this 2.7 stuff?

Depends on your confidence level, Michael.  We have ways of getting such
things tested before pushing them into the mainline kernel and we wouldn't
do that until you're confident in it.

And it's not really the end of the world if DVB is a bit wobbly for a while
(sorry ;)).

So yeah, I'd be inclined to push ahead and do the right thing here.

