Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265740AbUA0V5T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 16:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265745AbUA0V5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 16:57:19 -0500
Received: from fw.osdl.org ([65.172.181.6]:51640 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265740AbUA0V5R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 16:57:17 -0500
Date: Tue, 27 Jan 2004 13:57:06 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Greg KH <greg@kroah.com>, moilanen@austin.ibm.com, johnrose@austin.ibm.com,
       linux-kernel@vger.kernel.org, Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH][2.6] PCI Scan all functions
In-Reply-To: <20040127133314.0ddf00cd.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0401271346480.10794@home.osdl.org>
References: <1075222501.1030.45.camel@magik> <20040127211253.GA27583@kroah.com>
 <20040127133314.0ddf00cd.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 27 Jan 2004, Andrew Morton wrote:
> 
> While we're on the topic, what's with the below patch?  I've had it in -mm
> for ages but apparently there's some disagreement over it.

I'd be very worried, since I'm pretty sure that there _are_ devices where
"zero means disabled".

On the other hand, the resource management should do the right thing 
anyway, so I guess it should be safe. Especially if it's been in -mm for a 
long time..

		Linus
