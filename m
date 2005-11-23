Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751154AbVKWQbd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbVKWQbd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 11:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbVKWQbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 11:31:33 -0500
Received: from xproxy.gmail.com ([66.249.82.195]:37681 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751154AbVKWQbc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 11:31:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=of6EzKm8Z6SWQtbvkBgh6bQNWuWZOPnfVw01MpJIcHqfAo1cZ8dlHNRoTNp8V1ittW+g77DasQTRvsn1s9DoBi/11RuWd21SeQ8cBsHXFuPGTto8jRK1TtNBfdlM2421LeJ11IkNlmray58VnkeIuhg0f3p6ZRuQUek8mDUGCwE=
Message-ID: <d120d5000511230831g7e552c87n8431c461c063d29@mail.gmail.com>
Date: Wed, 23 Nov 2005 11:31:30 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Vojtech Pavlik <vojtech@suse.cz>, Marc Koschewski <marc@osknowledge.org>,
       Jon Smirl <jonsmirl@gmail.com>, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Christmas list for the kernel
In-Reply-To: <20051123162728.GJ15449@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com>
	 <9e4733910511221313t4a1e3c67wc7b08160937eb5c5@mail.gmail.com>
	 <20051123121726.GA7328@ucw.cz>
	 <9e4733910511230643j64922738p709fecd6c86b4a95@mail.gmail.com>
	 <20051123150349.GA15449@flint.arm.linux.org.uk>
	 <9e4733910511230719h67fa96bdxdeb654aa12f18e67@mail.gmail.com>
	 <20051123160231.GC6970@stiffy.osknowledge.org>
	 <20051123161637.GI15449@flint.arm.linux.org.uk>
	 <20051123162337.GA2434@ucw.cz>
	 <20051123162728.GJ15449@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/05, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> On Wed, Nov 23, 2005 at 05:23:37PM +0100, Vojtech Pavlik wrote:
> > On Wed, Nov 23, 2005 at 04:16:37PM +0000, Russell King wrote:
> > > It means that we spun in the serial interrupt for more than 256 times
> > > and reached the limit on the amount of work we were prepared to do.
> > > Any idea what you were doing when these happened?
> >
> > Because ACPI was right and the second serial port isn't there?
>
> Well, it certainly looked like a serial port when it was probed - to the
> extent that even loopback mode worked.  Hence I'd be very surprised if
> it wasn't there.
>

It could be on board but not having a connector attached. SInce it is
not useable ACPI might omit it.

--
Dmitry
