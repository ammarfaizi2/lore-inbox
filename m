Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261461AbUJZU6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261461AbUJZU6z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 16:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbUJZU6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 16:58:55 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:8973 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S261461AbUJZU4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 16:56:45 -0400
Date: Tue, 26 Oct 2004 23:02:43 +0200
To: Timothy Miller <miller@techsource.com>
Cc: Lars Roland <lroland@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
Message-ID: <20041026210243.GA27123@hh.idb.hist.no>
References: <4176E08B.2050706@techsource.com> <4ad99e05041025093856cd16ba@mail.gmail.com> <417D32F0.20100@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <417D32F0.20100@techsource.com>
User-Agent: Mutt/1.5.6+20040722i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 01:08:00PM -0400, Timothy Miller wrote:
> 
> 
> Lars Roland wrote:
> 
> >
> >For my own part I can tell you, that a dual head dvi card is high on
> >my wish list (if it can run 1200*1600 on each head), if you can make
> >one with Linux support, then I would be happy to pay 200-300$ for it,
> >even if it did not have the best 3D support (just enough power for
> >future xorg/enlightenment effect and I am happy).
> >
> >
> 
> I expect that we will offer a multi-head model.

Great!

Will this be a card with two pci id's, and two
fully independent graphichs accelerators?

That is necessary for two-user setups.  A single-user
setup with xinerama use a single xserver process that
can deal with hardware dependencies.  A two-user
setup use two xserver processes that doesn��'t cooperate
at all.  One basically doesn�'t know that the other exists,
so it cannot know what register the other process messes
with and so on.  A dual processor machine might even
mean that both servers runs simultaneosuly - so
there cannot be dependencies.  Also, an xserver likes
to reserve a pci ID for itself, so life gets much
easier if the card has two pci ids - i.e. two
graphichs cards on a single circuit board.

Of course I am willing to pay twice the single-card
price for such a card that has two of every chip
(except for the shared bus interface circuits).

I hope such a design won't be too much extra work,
basically you design the single-card accelerator FPGA
and other supporting chips
and stuff two of everything on the same PCB.

Note that this  "double" card improves performance for
the more common case of one user with two screens too. :-)

Helge Hafting




