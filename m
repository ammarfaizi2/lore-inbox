Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbUBYOqI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 09:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbUBYOqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 09:46:08 -0500
Received: from zadnik.org ([194.12.244.90]:19926 "EHLO lugburz.zadnik.org")
	by vger.kernel.org with ESMTP id S261361AbUBYOpX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 09:45:23 -0500
Date: Wed, 25 Feb 2004 16:44:58 +0200 (EET)
From: Grigor Gatchev <grigor@zadnik.org>
To: Rik van Riel <riel@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: A Layered Kernel: Proposal
In-Reply-To: <Pine.LNX.4.44.0402250751140.30721-100000@chimarrao.boston.redhat.com>
Message-ID: <Pine.LNX.4.44.0402251639430.17570-100000@lugburz.zadnik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 25 Feb 2004, Rik van Riel wrote:

> On Wed, 25 Feb 2004, Grigor Gatchev wrote:
>
> > > I'm all for cleaning up the badly written code so it fits
> > > in better with the rest of the kernel ;)
> >
> > Unhappily, cleaning up would not be enough. A separation of the kernel
> > layers, to the extent that one may be able to use them independently,
> > and to plug modules between them (having the appropriate access) may be
> > better.
>
> Some parts of the kernel (eg. the VFS or the device driver
> layers) can already do that, while others still have layering
> violations.
>
> I suspect that the least destabilising way of moving to a
> more modular model would be to gradually clean up the layering
> violations in the rest of the code, until things are modular.

Definitely.

I believe that, a layered model mandated or not, kernel development will
go generally the same way. A clear goal may improve much the process, but
will not change the things to be done. Even if that model is mandated,
most probably first production versions will not be completely compliant
with it.


