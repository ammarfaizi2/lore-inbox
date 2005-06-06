Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261744AbVFFWID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbVFFWID (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 18:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbVFFWID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 18:08:03 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:46605 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261744AbVFFWHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 18:07:39 -0400
Date: Mon, 6 Jun 2005 23:07:31 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@suse.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.12-rc6
Message-ID: <20050606230730.C12034@flint.arm.linux.org.uk>
Mail-Followup-To: Jesper Juhl <jesper.juhl@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@suse.cz>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0506061104190.1876@ppc970.osdl.org> <20050606192654.GA3155@elf.ucw.cz> <Pine.LNX.4.58.0506061310500.1876@ppc970.osdl.org> <20050606201441.GG2230@elf.ucw.cz> <Pine.LNX.4.58.0506061411410.1876@ppc970.osdl.org> <9a87484905060614576c09d08d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <9a87484905060614576c09d08d@mail.gmail.com>; from jesper.juhl@gmail.com on Mon, Jun 06, 2005 at 11:57:00PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2005 at 11:57:00PM +0200, Jesper Juhl wrote:
> On 6/6/05, Linus Torvalds <torvalds@osdl.org> wrote:
> > 
> > 
> > On Mon, 6 Jun 2005, Pavel Machek wrote:
> > >
> > > There is "From: Dmitry..." in the changelog. Do your script move first
> > > "From:" into author header and delete it from changelog? That would
> > > explain it...
> > 
> > Yes. But note how it doesn't even take the "first" From: line, it
> > literally takes the From: line _only_ if that line is the first line in
> > the email body.
> > 
> 
> A lot of times I see mails getting forwarded to you/Andrew/other
> maintainer by someone without adding a From: or other indication of
> who was the original author, but in almost all cases the original
> author is the one listed as the first Signed-off-by: since authors are
> the first to sign off on a patch, so, wouldn't it make more sense to
> pick the author like this ;

Not necessarily.  Re-read what Signed-off-by: is all about and who
may provide that line.  You should find that the first Signed-off-by:
line may not be the author themselves, but someone else who is able
to satisfy our requirements.

I think people will just have to accept that there's no way to _always_
_automatically_ get the proper author for every patch. (and that calling
it author in git was probably the first mistake - we never had these
issues with BK which didn't specifically indentify anything as being
the "author" as such.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
