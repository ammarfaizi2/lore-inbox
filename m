Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274669AbRJQE7E>; Wed, 17 Oct 2001 00:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274675AbRJQE6y>; Wed, 17 Oct 2001 00:58:54 -0400
Received: from adsl-66-120-162-175.dsl.sntc01.pacbell.net ([66.120.162.175]:6142
	"EHLO devel.office") by vger.kernel.org with ESMTP
	id <S274669AbRJQE6m>; Wed, 17 Oct 2001 00:58:42 -0400
Date: Tue, 16 Oct 2001 21:59:03 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: <christoph@devel.office>
To: Keith Owens <kaos@ocs.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: GPLONLY kernel symbols??? 
In-Reply-To: <30375.1003285059@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.33.0110162158450.6825-100000@devel.office>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The loop driver is not GPL compatible???

On Wed, 17 Oct 2001, Keith Owens wrote:

> On Tue, 16 Oct 2001 09:27:55 -0700 (PDT),
> Christoph Lameter <christoph@lameter.com> wrote:
> >I just tried to load the loop driver in 2.4.11
> >
> >devel:/home/christoph/devel/bf/boot-floppies# insmod loop
> >Using /lib/modules/2.4.11/kernel/drivers/block/loop.o
> >/lib/modules/2.4.11/kernel/drivers/block/loop.o: unresolved symbol
> >invalidate_bdev
> >/lib/modules/2.4.11/kernel/drivers/block/loop.o: Note: modules without a
> >GPL compatible license cannot use GPLONLY_ symbols
> >
> >What is THAT?
>
> If a symbol has been exported with EXPORT_SYMBOL_GPL then it appears as
> unresolved for modules that do not have a GPL compatible MODULE_LICENCE
> string.  So when a module without a GPL compatible MODULE_LICENCE gets
> an unresolved symbol, I print that message as a hint to the user.  I
> thought the response was obvious, but looks like I need to expand the
> hint text even further.
>
> Note: modules without a GPL compatible license cannot use GPLONLY_ symbols.
>       This may or may not be your problem, there can be other reasons
>       for unresolved symbols.
>
>

