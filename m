Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264376AbUADVFl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 16:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264387AbUADVFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 16:05:41 -0500
Received: from fw.osdl.org ([65.172.181.6]:57827 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264376AbUADVFf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 16:05:35 -0500
Date: Sun, 4 Jan 2004 13:05:20 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andries Brouwer <aebr@win.tue.nl>
cc: Rob Love <rml@ximian.com>, rob@landley.net,
       Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
In-Reply-To: <20040104142111.A11279@pclin040.win.tue.nl>
Message-ID: <Pine.LNX.4.58.0401041302080.2162@home.osdl.org>
References: <1072972440.3975.29.camel@fur> <Pine.LNX.4.58.0401021238510.5282@home.osdl.org>
 <20040103040013.A3100@pclin040.win.tue.nl> <Pine.LNX.4.58.0401022033010.10561@home.osdl.org>
 <20040103141029.B3393@pclin040.win.tue.nl> <Pine.LNX.4.58.0401031423180.2162@home.osdl.org>
 <20040104000840.A3625@pclin040.win.tue.nl> <Pine.LNX.4.58.0401031802420.2162@home.osdl.org>
 <20040104034934.A3669@pclin040.win.tue.nl> <Pine.LNX.4.58.0401031856130.2162@home.osdl.org>
 <20040104142111.A11279@pclin040.win.tue.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 4 Jan 2004, Andries Brouwer wrote:
>
> On Sat, Jan 03, 2004 at 07:04:17PM -0800, Linus Torvalds wrote:
> > 
> > I agree that for a stable kernel we should then go back to "best effort" 
> > mode, where for simple politeness reasons we should try to keep device 
> > numbers as stable as we can.
> 
> Good - you understand now.

Oh, _I_ always understood. You were the one that was arguing for stable
numbers as somehow important. I'm just telling you that they aren't
stable, and that a user application that depends on their stability or
their uniqieness is BROKEN.

> So, the right setup - you call it politeness, I call it quality
> of implementation - is to have both stable names and stable numbers,
> in as many cases as possible.

And I still disagree. You seem to think that this is an "absolute 
goodness", and call it a quality issue.

While I personally strongly believe that it is a bug in user space to
care, and that it is not a quality issue at all, but rather a "allow buggy
and/or nonconverted user space to work".

In other words, it's not about "quality", as much as about compatibility 
with applications that are old and/or braindead. Big difference.

		Linus
