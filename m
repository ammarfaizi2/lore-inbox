Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbTJFXiH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 19:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbTJFXiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 19:38:07 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:61962 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S261746AbTJFXiE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 19:38:04 -0400
Date: Mon, 6 Oct 2003 16:37:58 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: 71MB compressed for COMPILED(!!!) 2.6.0-test6
Message-ID: <20031006233758.GF22023@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <20031006082340.GA1135@matchmail.com> <1065428996.5033.5.camel@laptop.fenrus.com> <20031006083803.GB1135@matchmail.com> <20031006102415.GB7598@merlin.emma.line.org> <Pine.LNX.4.56.0310061655070.26687@jju_lnx.backbone.dif.dk> <00b401c38c31$d1360390$2eedfea9@kittycat>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00b401c38c31$d1360390$2eedfea9@kittycat>
User-Agent: Mutt/1.3.27i
X-Message-Flag: Reading this message may result in the loss of plausible deniability. Consult a lawyer to determine the extent of your liability
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 06, 2003 at 10:46:48AM -0700, jdow wrote:
> From: "Jesper Juhl" <jju@dif.dk>
> > On Mon, 6 Oct 2003, Matthias Andree wrote:
> >
> > > On Mon, 06 Oct 2003, Mike Fedyk wrote:
> > >
> > > > config DEBUG_INFO
> > > > bool "Compile the kernel with debug info"
> > > > depends on DEBUG_KERNEL
> > > > help
> > > >           If you say Y here the resulting kernel image will include
> > > >   debugging info resulting in a larger kernel image.
> > > >   Say Y here only if you plan to use gdb to debug the kernel.
> > > >   If you don't debug the kernel, you can say N.
> > > >
> > > > "Larger kernel image" yeah, NO SHIT! ;)
> > > >
> > > > Maybe something that says it may enlarge your kernel by 5-10 times
> would be
> > > > nice...
> > >
> > > Send a patch...
> > >
> >
> > How about this one?  :
> >
> >
> > diff -ur linux-2.6.0-test6-orig/arch/alpha/Kconfig
> linux-2.6.0-test6/arch/alpha/Kconfig
> > --- linux-2.6.0-test6-orig/arch/alpha/Kconfig 2003-09-28
> 02:50:39.000000000 +0200
> > +++ linux-2.6.0-test6/arch/alpha/Kconfig 2003-10-06 17:10:32.000000000
> +0200
> > @@ -769,6 +769,8 @@
> >   help
> >            If you say Y here the resulting kernel image will include
> >     debugging info resulting in a larger kernel image.
> > +   This will substantially increase the size of the kernel image.
> > +   Size increases of 5 to 10 times normal size is to be expected.
> 
> --------------------------------------------------^^ "are"

It isn't multiple increases but one of variable size.

	"A size of 5 to 10 times normal is to be expected."

Gets the conjugation correct and eliminates the implied
	size += 6..10 * normal

