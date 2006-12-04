Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936894AbWLDOWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936894AbWLDOWX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 09:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936896AbWLDOWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 09:22:23 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:60171 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S936894AbWLDOWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 09:22:23 -0500
Date: Mon, 4 Dec 2006 14:22:10 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>, Roman Zippel <zippel@linux-m68k.org>,
       Al Viro <viro@ftp.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>,
       Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@osdl.org>,
       linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] timers, pointers to functions and type safety
Message-ID: <20061204142209.GB24634@flint.arm.linux.org.uk>
Mail-Followup-To: David Howells <dhowells@redhat.com>,
	Pavel Machek <pavel@ucw.cz>, Roman Zippel <zippel@linux-m68k.org>,
	Al Viro <viro@ftp.linux.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@osdl.org>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20061202184035.GL3078@ftp.linux.org.uk> <200612022243.58348.zippel@linux-m68k.org> <20061202215941.GN3078@ftp.linux.org.uk> <Pine.LNX.4.64.0612022306360.1867@scrub.home> <20061202224018.GO3078@ftp.linux.org.uk> <Pine.LNX.4.64.0612022345520.1867@scrub.home> <20061203102108.GA1724@elf.ucw.cz> <26864.1165230869@redhat.com> <29346.1165237409@redhat.com> <9737.1165241841@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9737.1165241841@redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2006 at 02:17:21PM +0000, David Howells wrote:
> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> 
> > > You've now got four copies of struct timer_list, but only one handler.
> > 
> > <re-insert last paragraph of my message until read, understood and
> > actioned.>
> 
> I was merely correcting your assumption of what premise I was thinking of.
> You thought of something unnecessarily complex.

That's entirely a matter of opinion.  Which is _precisely_ why I made that
particular statement which you don't appear to understand.

Let me make it again in a different way:

This is all mere hand waving.  We can all dream up scenarios where something
works better than something else.  Until someone actually sits down and
works it out it's just useless talk and random opinions, nothing more.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
