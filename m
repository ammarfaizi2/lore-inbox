Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261914AbVCZCZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbVCZCZJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 21:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261915AbVCZCZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 21:25:09 -0500
Received: from digitalimplant.org ([64.62.235.95]:65190 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S261914AbVCZCZE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 21:25:04 -0500
Date: Fri, 25 Mar 2005 18:24:58 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Greg KH <gregkh@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [0/12] More Driver Model Locking Changes
In-Reply-To: <20050326000309.GB16602@kroah.com>
Message-ID: <Pine.LNX.4.50.0503251823280.30834-100000@monsoon.he.net>
References: <Pine.LNX.4.50.0503242145200.29800-100000@monsoon.he.net>
 <20050325192024.GA14290@kroah.com> <20050325233952.GA16355@kroah.com>
 <20050326000309.GB16602@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 25 Mar 2005, Greg KH wrote:

> On Fri, Mar 25, 2005 at 03:39:52PM -0800, Greg KH wrote:
> > But can you take a look at drivers/scsi/scsi_transport_spi.c, line 265?
> > That is also going to need fixing up somehow.  Gotta love that FIXME
> > comment...

Heh, funky.

> Ok, the patch below seems to fix it, but I would like some validation I
> did the correct thing.

It looks Ok to me.

> Oh, looks like pci express now has problems too, I'll go hit that one
> next...

Bah, sorry about that. What config are you using to test, 'allmodconfig'?

Thanks,


	Pat
