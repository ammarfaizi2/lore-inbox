Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262007AbUFNHgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbUFNHgg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 03:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbUFNHgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 03:36:36 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:9344 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S262007AbUFNHgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 03:36:35 -0400
Date: Mon, 14 Jun 2004 08:44:26 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200406140744.i5E7iQDb000150@81-2-122-30.bradfords.org.uk>
To: Helge Hafting <helgehaf@aitel.hist.no>, ndiamond@despammed.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <40CD5384.1050809@aitel.hist.no>
References: <200406140223.i5E2N1k18221@mailout.despammed.com>
 <40CD5384.1050809@aitel.hist.no>
Subject: Re: Panics need better handling
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Helge Hafting <helgehaf@aitel.hist.no>:
> ndiamond@despammed.com wrote:
> 
> > I am not asking for
> >help in solving this particular panic,
> >I am asking for help in general, in
> >getting information displayed when it
> >needs to be displayed.
> >  
> >
> I have struggled with this from time to time.  Wanting to
> report a trace, but it is too long for the screen. 
> 
> Using a framebuffer console helps a lot.  I use 1280x1024 resolution,
> and 8x8 characters.  The resulting 160x128 console isn't
> that fun to _work_ with, but most panics/oopses fit.  I rarely
> work at the console anyway.  If you do, consider making two almost
> identical kernels where console font size is the only difference.  (The
> extra compile takes very little time.)  Then use the small-font kernel
> when debugging.

On the other hand, if like me you use a text-based console almost exclusively,
then the best course of action is probably to buy a real serial terminal, (or
several :-) ), and configure one of them as the console.  Then you can
basically ignore the VGA display completely.

John.
