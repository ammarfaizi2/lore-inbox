Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbTKVLE1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 06:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262181AbTKVLE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 06:04:27 -0500
Received: from mail.jlokier.co.uk ([81.29.64.88]:30136 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262164AbTKVLE0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 06:04:26 -0500
Date: Sat, 22 Nov 2003 11:04:11 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Pavel Machek <pavel@suse.cz>, Jens Axboe <axboe@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>, bug-binutils@gnu.org
Subject: Re: ionice kills vanilla 2.6.0-test9 was [Re: [PATCH] cfq + io priorities (fwd)]
Message-ID: <20031122110411.GB15384@mail.shareable.org>
References: <Pine.LNX.4.44.0311211455510.13789-100000@home.osdl.org> <Pine.LNX.4.44.0311211529590.13789-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311211529590.13789-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> It looks like we can work around it with this silly syntactic sugar.. Does 
> this work for you?

Or try this: nr_syscalls=(.-sys_call_table)>>2

-- Jamie
