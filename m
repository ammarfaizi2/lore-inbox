Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263817AbTDULrJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 07:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263818AbTDULrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 07:47:08 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:18960 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id S263817AbTDULrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 07:47:08 -0400
Date: Mon, 21 Apr 2003 13:59:02 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Linus Torvalds <torvalds@transmeta.com>
cc: "David S. Miller" <davem@redhat.com>, <Andries.Brouwer@cwi.nl>,
       <hch@infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] new system call mknod64
In-Reply-To: <Pine.LNX.4.44.0304201454100.1563-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0304211354280.12110-100000@serv>
References: <Pine.LNX.4.44.0304201454100.1563-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 20 Apr 2003, Linus Torvalds wrote:

> The kernel should get major and minor numbers. It's a sad mistake that 
> UNIX uses "dev_t" in the first place, and clearly the glibc interface to 
> user mode will have to be that historical braindamage. But we should 
> realize that the _right_ interface is keeping the <major, minor> tuple 
> explicit, and any new system call interfaces should be of that type.

May I ask what advantage it has to split that number?
Everywhere it's just a simple number, only when we present that number to 
the user, we create some kind of illusion that this split has any meaning.

bye, Roman

