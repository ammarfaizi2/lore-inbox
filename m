Return-Path: <linux-kernel-owner+willy=40w.ods.org-S938028AbWLHLI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938028AbWLHLI0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 06:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S938032AbWLHLI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 06:08:26 -0500
Received: from smtp.osdl.org ([65.172.181.25]:49285 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S938028AbWLHLIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 06:08:25 -0500
Date: Fri, 8 Dec 2006 03:07:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dtor@insightbb.com>,
       Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Greg KH <gregkh@suse.de>
Subject: Re: [git pull] Input patches for 2.6.19
Message-Id: <20061208030755.4ae3d5df.akpm@osdl.org>
In-Reply-To: <1165579184.5529.33.camel@aeonflux.holtmann.net>
References: <200612080157.04822.dtor@insightbb.com>
	<Pine.LNX.4.64.0612081038520.1665@twin.jikos.cz>
	<1165579184.5529.33.camel@aeonflux.holtmann.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Dec 2006 12:59:44 +0100
Marcel Holtmann <marcel@holtmann.org> wrote:

> > >  b/drivers/usb/input/hid-core.c                 |    7 
> > >  b/drivers/usb/input/hid-input.c                |    4 
> > >  b/drivers/usb/input/hid.h                      |    1 
> > 
> > OK, this is going to break the merge from Greg's tree of generic HID 
> > layer, which was planned for today.
> > 
> > The merge will probably emit a large .rej files, due to the large blocks 
> > of code being moved around, but it seems that most of the changes which 
> > would conflict with the merge could be trivially solved by hand.
> > 
> > Greg, should I prepare a new version of the generic HID patches against 
> > merged Linus' + Dmitry's trees and send them to you?
> 
> yes please, because Linus already merged Dmitry's patches.

I suggest that you leave it for 12 hours - there's a lot more stuff in flight and
there might be overlaps.
