Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264321AbTLYPPb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 10:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264322AbTLYPPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 10:15:31 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:6272 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S264321AbTLYPPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 10:15:23 -0500
Date: Thu, 25 Dec 2003 15:21:43 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200312251521.hBPFLheE000203@81-2-122-30.bradfords.org.uk>
To: David Monro <davidm@amberdata.demon.co.uk>
Cc: Andries Brouwer <aebr@win.tue.nl>, linux-kernel@vger.kernel.org,
       vojtech@suse.cz
In-Reply-To: <3FEAFDF3.80008@amberdata.demon.co.uk>
References: <3FEA5044.5090106@amberdata.demon.co.uk>
 <20031225063936.GA15560@win.tue.nl>
 <200312251316.hBPDG7LT000163@81-2-122-30.bradfords.org.uk>
 <3FEAFDF3.80008@amberdata.demon.co.uk>
Subject: Re: handling an oddball PS/2 keyboard
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from David Monro <davidm@amberdata.demon.co.uk>:
> John Bradford wrote:
> >>I suppose Vojtech will have no objections to using this ID
> >>to skip the tests for e0 and e1 as protocol (escape) scancodes.
> > 
> > 
> > There might be no need for such a workaround - a lot of PS/2 devices
> > which were not intended for PCs work fine in set 3, particularly if
> > the device they were intended to work with uses set 3 natively, where
> > this conflict with protocol scancodes problem doesn't exist.  If the
> > keyboard works in set 3, add 0xab85 to the list of keyboards to force
> > set 3 for, (and maybe also add the ID for my keyboard while we're at
> > it :-) ).
> 
> I will definitely explore this possibility. Whats the ID of your 
> keyboard? (and what is it?)

It's an IBM Japanese keyboard which emulates a U.S. one.  Andries has
quite a bit of information about it on his page, but the interesting
thing is that it doesn't do any emulation in set 3, only in the
default set 2.  The ID is ab90.  There may be ab90 ID keyboards out
there which are not set 3 compatible, I don't know.  Mine is certainly
not fully usable in set 2, though, as the language keys produce the
same codes as the space bar.

John.
