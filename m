Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261319AbVAaTJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261319AbVAaTJe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 14:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbVAaTJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 14:09:33 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:23619 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261319AbVAaTI2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 14:08:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=kA0RB9W7Gu/kW7zRyE7w9hPn7C2oUViP0d7ecTNb3h4XlB67/Udg6a8iGe6D+i14Lmv67FTsRVHkJFIizTSmiV7iSdU0aVILfoc5GBWdbWw7Pm4pba4ez8AMJBGtrvIYsly3oD6JZAYVTNMEdcjctXy7lM0xFXw6J+ERqe+yZjk=
Message-ID: <9dda3492050131110845b68cb4@mail.gmail.com>
Date: Mon, 31 Jan 2005 14:08:26 -0500
From: Paul Blazejowski <diffie@gmail.com>
Reply-To: Paul Blazejowski <diffie@gmail.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: Fw: Re: 2.6.11-rc2-mm2
Cc: Andrew Morton <akpm@osdl.org>, linux-usb-devel@lists.sourceforge.net,
       Vojtech Pavlik <vojtech@suse.cz>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200501301831.25095.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050130130131.030c1ef1.akpm@osdl.org>
	 <200501301831.25095.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Jan 2005 18:31:24 -0500, Dmitry Torokhov
<dtor_core@ameritech.net> wrote:
> On Sunday 30 January 2005 16:01, Andrew Morton wrote:
> >
> > Did someone break usb input?
> >
> >
> > Begin forwarded message:
> >
> > Date: Sun, 30 Jan 2005 15:45:04 -0500
> > From: Paul Blazejowski <diffie@gmail.com>
> > To: Andrew Morton <akpm@osdl.org>
> > Cc: LKML <linux-kernel@vger.kernel.org>
> > Subject: Re: 2.6.11-rc2-mm2
> >
> >
> > Here's another one, my USB keyboard is not functioning properly, ie.
> > the caps lock,scrlk and num lock lights are not on when these keys are
> > pressed and dmesg gets tons of spam for each key presses:
> >
> > drivers/usb/input/hid-input.c: event field not found
> > drivers/usb/input/hid-input.c: event field not found
> > drivers/usb/input/hid-input.c: event field not found
> > drivers/usb/input/hid-input.c: event field not found
> > drivers/usb/input/hid-input.c: event field not found
> >
> 
> I this it was fixed in Vojtech tree, probably with the following patch:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=110702712719062&q=raw
> 
> --
> Dmitry
> 

After applying the patch in above url, dmesg got quiet but the
keyboard LED lights are still non functional.

Paul

-- 
FreeBSD the Power to Serve!
