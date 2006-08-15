Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965104AbWHOQda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965104AbWHOQda (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 12:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965385AbWHOQd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 12:33:29 -0400
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:19650 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S965104AbWHOQd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 12:33:29 -0400
Date: Tue, 15 Aug 2006 18:33:10 +0200
From: Voluspa <lista1@comhem.se>
To: "Luke Sharkey" <lukesharkey@hotmail.co.uk>
Cc: dmitry.torokhov@gmail.com, andi@rhlx01.fht-esslingen.de, davej@redhat.com,
       gene.heskett@verizon.net, ian.stirling@mauve.plus.com,
       linux-kernel@vger.kernel.org, malattia@linux.it
Subject: Re: Touchpad problems with latest kernels
Message-Id: <20060815183310.284d03ae.lista1@comhem.se>
In-Reply-To: <BAY114-F2421131E2BFF6216D9A52BFA4F0@phx.gbl>
References: <d120d5000608141227h7c707686i7db7eabba0e3a3ca@mail.gmail.com>
	<BAY114-F2421131E2BFF6216D9A52BFA4F0@phx.gbl>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.4.13; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2006 15:57:05 +0100 Luke Sharkey wrote:
> To all concerned,
[...]

> >In earlier kernels the issue _seemed_ to lessen if booting with i8042.nomux
> Are you sure about this?  I mean, I wasn't having any problem at all with 
> the 2054 kernel (sorry to use the fedora-kernel indexing system again).  It 
> worked great.

I'm referring back to kernels 2.6.11, .12, .13 etc. You're at 2.6.16
or thereabouts with that distro.
 
> >Unless someone establishes a contact with people at Synaptics or
> >disassembles the win driver, linux will stay with the loony tunes...
> But the driver was ok for the 2054 kernel.  Can't the driver for my touchpad 
> be rolled back to the 2054 driver until this is fixed?  Right now the 
> onscreen pointer is practically unusuable when I so much as open a konqueror 
> window.  It frequently freezes on screen for many seconds.  (When I said it 
> was jerky, I don't mean that it pings around all over the screen).

Ok, there seems to be two distinct issues here. 1) Synaptics
'supersensitive' mode, 2) pointer 'freezing'.

Number 1 can not be fixed by the kernel developers (assumingly) and not
by the Synaptics X driver author. Number 2 I've seen myself, even when
using i8042.nomux, but it is _very_ sporadic on this machine.

Pointer freezing would be Dmitry's domain, but he'd have to work with
someone who can trigger it easily, and who can write scripts to capture
debug data, since it's 'hard' to move a frozen pointer to a terminal
and issue commands...

Mvh
Mats Johannesson
