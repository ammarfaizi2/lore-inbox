Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266291AbUHHUt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266291AbUHHUt5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 16:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266292AbUHHUt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 16:49:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:13259 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266291AbUHHUt4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 16:49:56 -0400
Date: Sun, 8 Aug 2004 13:47:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: Micha Feigin <michf@post.tau.ac.il>
Cc: linux-kernel@vger.kernel.org
Subject: Re: no input with kernel 2.6.8-rc3-mm1 and X
Message-Id: <20040808134747.09ff7613.akpm@osdl.org>
In-Reply-To: <20040808112901.GA2958@luna.mooo.com>
References: <20040808112901.GA2958@luna.mooo.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Micha Feigin <michf@post.tau.ac.il> wrote:
>
> With kernel 2.6.8-rc3-mm1 I lose input completely the moment I start
> X. Keyboard is completely non-functional (include sysrq and num/ctrl
> lock) and the touchpad also doesn't seem to produce anything.
>
> The computer is otherwise functional and I can ssh in from another
> machine and chvt to the console where I get the keyboard back. chvt
> back to X kills input again.

What interface is the keyboard using?  PS/2?  USB?

Does the mouse work?  What interface is the mouse using?

If you can, try reverting bk-input.patch and see if that fixes it up.  Or
bk-usb if you're using a USB keyboard.

