Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265092AbUFGVgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265092AbUFGVgp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 17:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265089AbUFGVeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 17:34:17 -0400
Received: from zork.zork.net ([64.81.246.102]:53393 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S265084AbUFGVde (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 17:33:34 -0400
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: how to configure/build a kernel in a separate directory?
References: <Pine.LNX.4.58.0406071653200.21938@localhost.localdomain>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: "Robert P. J. Day" <rpjday@mindspring.com>, Linux kernel
	mailing list <linux-kernel@vger.kernel.org>
Date: Mon, 07 Jun 2004 22:33:24 +0100
In-Reply-To: <Pine.LNX.4.58.0406071653200.21938@localhost.localdomain>
 (Robert
	P. J. Day's message of "Mon, 7 Jun 2004 17:00:26 -0400 (EDT)")
Message-ID: <6uy8mz3vff.fsf@zork.zork.net>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: sneakums@zork.net
X-SA-Exim-Scanned: No (on zork.zork.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Robert P. J. Day" <rpjday@mindspring.com> writes:

>   is there an easy way to configure/build one or both of a 2.4 and 2.6 
> kernel in a totally separate directory from the source directory itself?
>
>   i'd like to have a totally pristine ("make mrproper"ed) source tree,
> write-protected, readable by all, so that several developers can 
> independently configure and build their own kernels without stepping on 
> each other.

This isn't really what you want, but you can use 'cp -rl' to build a
hard-linked tree from the pristine read-only tree and build there.
This will at least address the space issue.
