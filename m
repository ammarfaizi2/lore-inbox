Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262580AbSLOUx6>; Sun, 15 Dec 2002 15:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262602AbSLOUx6>; Sun, 15 Dec 2002 15:53:58 -0500
Received: from x101-201-88-dhcp.reshalls.umn.edu ([128.101.201.88]:63370 "EHLO
	arashi.yi.org") by vger.kernel.org with ESMTP id <S262580AbSLOUx6>;
	Sun, 15 Dec 2002 15:53:58 -0500
Date: Sun, 15 Dec 2002 15:01:51 -0600
From: Matt Reppert <arashi@arashi.yi.org>
To: Richard Henderson <rth@twiddle.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.51 on Alpha oopses on mount
Message-Id: <20021215150151.6cdf9bdf.arashi@arashi.yi.org>
In-Reply-To: <20021215105722.A3831@twiddle.net>
References: <20021214123155.7383524c.arashi@arashi.yi.org>
	<20021215105722.A3831@twiddle.net>
Organization: Yomerashi
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-message-flag: : This mail sent from host minerva, please respond.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Dec 2002 10:57:22 -0800
Richard Henderson <rth@twiddle.net> wrote:

> On Sat, Dec 14, 2002 at 12:31:55PM -0600, Matt Reppert wrote:
> > >>PC;  fffffc00004a5240 <__copy_user+100/1d4>   <=====
> > Trace; fffffc0000385920 <sys_mount+40/160>
> 
> This fault is expected and is _supposed_ to be handled by the
> exception mechanism.  Why this stopped working, I don't know.
> 
> For grins, see if the following helps.  It's something that I
> need for the shared-library modules anyway, and it eliminates
> an extra variable from the problem.

This seems to work, mount doesn't oops anymore. I guess this
means I can go back to trying to get the shared modules patches
to compile and boot, since this is in shared-modules-alpha.
Thanks!

Matt
