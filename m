Return-Path: <linux-kernel-owner+w=401wt.eu-S1425589AbWLHPyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425589AbWLHPyj (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 10:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425590AbWLHPyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 10:54:39 -0500
Received: from styx.suse.cz ([82.119.242.94]:50994 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1425589AbWLHPyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 10:54:38 -0500
Date: Fri, 8 Dec 2006 16:54:34 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>,
       Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [git pull] Input patches for 2.6.19
In-Reply-To: <d120d5000612080614l3c4c5b1cy9437c2a43c2853dd@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0612081651080.4215@jikos.suse.cz>
References: <200612080157.04822.dtor@insightbb.com> 
 <Pine.LNX.4.64.0612081038520.1665@twin.jikos.cz>
 <d120d5000612080614l3c4c5b1cy9437c2a43c2853dd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2006, Dmitry Torokhov wrote:

> > >  b/drivers/usb/input/hid-core.c                 |    7
> > >  b/drivers/usb/input/hid-input.c                |    4
> > >  b/drivers/usb/input/hid.h                      |    1
> > OK, this is going to break the merge from Greg's tree of generic HID
> > layer, which was planned for today.
> > The merge will probably emit a large .rej files, due to the large blocks
> > of code being moved around, but it seems that most of the changes which
> > would conflict with the merge could be trivially solved by hand.
> Hmm, I thought that git would take care of resolving the merge
> conflict but it was 2AM thought and obviously not a smart one. Sorry.

No problem, someone would have to do the merge anyway, either me, you or 
Greg, so I did it :)

I have been asked by Andrew to wait a few more hours after all the patches 
he has pending for upstream have been processed. In approximately 5 hours 
or so I am going to check mainline, make sure that my patches apply 
cleanly on top of that, and push them to Greg again and we'll see.

Thanks,

-- 
Jiri Kosina
SUSE Labs
