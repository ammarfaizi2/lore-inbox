Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964945AbWAMByE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964945AbWAMByE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 20:54:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964947AbWAMByE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 20:54:04 -0500
Received: from gate.crashing.org ([63.228.1.57]:21995 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964945AbWAMByD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 20:54:03 -0500
Subject: Re: [PATCH/RFC?] usb/input: Add support for fn key on Apple
	PowerBooks
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Hanselmann <linux-kernel@hansmi.ch>
Cc: Vojtech Pavlik <vojtech@suse.cz>, dtor_core@ameritech.net,
       linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz,
       linuxppc-dev@ozlabs.org, linux-kernel@killerfox.forkbomb.ch
In-Reply-To: <20060112233951.GA31258@hansmi.ch>
References: <20051225212041.GA6094@hansmi.ch>
	 <200512252304.32830.dtor_core@ameritech.net>
	 <1135575997.14160.4.camel@localhost.localdomain>
	 <d120d5000601111307x451db79aqf88725e7ecec79d2@mail.gmail.com>
	 <20060111232651.GI6617@hansmi.ch>
	 <1137022900.5138.66.camel@localhost.localdomain>
	 <20060112090733.GA7627@midnight.suse.cz> <20060112233951.GA31258@hansmi.ch>
Content-Type: text/plain
Date: Fri, 13 Jan 2006 12:53:23 +1100
Message-Id: <1137117204.4862.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-13 at 00:39 +0100, Michael Hanselmann wrote:
> On Thu, Jan 12, 2006 at 10:07:33AM +0100, Vojtech Pavlik wrote:
> > I think having it in struct hid_device is safer. We might want to
> > dynamically allocate only for PowerBook keyboards, though, to save
> > memory.
> 
> These two arrays take 128 Bytes. I don't think it's possible to write
> the code to allocate and set them in such short code. Beside of that, it
> would affect more code than only hid-input.c, at least hid-core.c would
> need modifications, too.
> 
> Benjamin Herrenschmidt had the idea of a private field which each device
> can use for its own purposes. That's a task for another patch, tough.
> 
> This patch implements support for the fn key on Apple PowerBooks using
> USB based keyboards.

Dimitri, I think the patch is good enough now and should go in for
2.6.16.

Thanks !
Ben.


