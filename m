Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964796AbWACVEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbWACVEN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964798AbWACVEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:04:12 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:55203 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964796AbWACVEK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:04:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=li5Nf5R1Ih7sfmFHsgSJDiMzjGo1+vmdZrJY+Eco4xcdWZc1CPZgCBfBUlXh0K227fC33IAL0vJqEAh0+MUC1Fk+SFLNN0EgPpb6woTRibWYvwwAvAQGDKSd8DTUZT3Qavu8ebf5hbu/N8TASAeXjeDoCsW0B/ky9KIvQWboEnc=
Message-ID: <d120d5000601031304n25ca5645g7c3231a9ef6140e8@mail.gmail.com>
Date: Tue, 3 Jan 2006 16:04:07 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] Re: usb: replace __setup("nousb") with __module_param_call
Cc: Pete Zaitcev <zaitcev@redhat.com>, greg@kroah.com,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.44L0.0601031549130.18243-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <d120d5000601031238x4db9999eyc6358d2a010ad9dd@mail.gmail.com>
	 <Pine.LNX.4.44L0.0601031549130.18243-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/06, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Tue, 3 Jan 2006, Dmitry Torokhov wrote:
>
> > On 1/3/06, Alan Stern <stern@rowland.harvard.edu> wrote:
> > >
> > > usb-handoff no longer exists.  The kernel now takes USB host controllers
> > > away from the BIOS as soon as they are discovered.
> > >
> >
> > Yes! YES! YEEEEES!
> >
> > *Dmitry dances and rejoices*
>
> It may not be totally advantageous.  Sometimes people have trouble with
> system installs, when for some reason the USB HID driver doesn't work.
> If you've got a USB keyboard now you're pretty well stuck, whereas in the
> past you could specify "nousb" and the BIOS would continue to drive the
> keyboard.
>

Ok, I'd settle with having "usb-handoff" option that defaults to 1. I
think if you look at number of problem reports that go away with
"usb-handoff" it is sensible default.

--
Dmitry
