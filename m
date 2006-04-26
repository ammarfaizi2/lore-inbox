Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964853AbWDZTi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964853AbWDZTi2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 15:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbWDZTi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 15:38:28 -0400
Received: from [198.99.130.12] ([198.99.130.12]:58817 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S964853AbWDZTi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 15:38:27 -0400
Date: Wed, 26 Apr 2006 14:38:48 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [RFC] PATCH 3/4 - Time virtualization : PTRACE_SYSCALL_MASK
Message-ID: <20060426183848.GA9269@ccure.user-mode-linux.org>
References: <200604131720.k3DHKqdr004720@ccure.user-mode-linux.org> <20060418125728.GA26554@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060418125728.GA26554@elf.ucw.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2006 at 02:57:28PM +0200, Pavel Machek wrote:
> Same here... and perhaps you can use __get_bit/__set_bit? (this
> applies to few more places).

I did the bit-mashing by hand because I couldn't tell from a quick
look at the code whether __get_bit/__set_bit had any limitations that
I might exceed (i.e. nr needs to be < 256).

> Are you going to fix non-i386, too?

Probably, but I have other things to fix first.

				Jeff
