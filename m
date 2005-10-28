Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030406AbVJ1TS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030406AbVJ1TS4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 15:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030575AbVJ1TS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 15:18:56 -0400
Received: from xproxy.gmail.com ([66.249.82.199]:26939 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030406AbVJ1TSz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 15:18:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mkTZGnQKQrK19yznz7WLkmNkIevRYjpK7MipLqzUH0rvbN3k6ib0hlwnF2Q4n3wwvBYkMGPJq6YybHV670Jj6Cmjv3tNkEP0EYNQ1PU0C+kUa8UbpQFI4G2wgn9esV/dzsodI5GwaFtvdD7wy2wL1ngtQ0PQ+kgih8g8dY0632k=
Message-ID: <d120d5000510281218j7016b7e4n4be300d3dd77a1a9@mail.gmail.com>
Date: Fri, 28 Oct 2005 14:18:54 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] Driver Core: document struct class_device properly
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051028190937.GA16822@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <11304810242041@kroah.com>
	 <200510280154.59943.dtor_core@ameritech.net>
	 <20051028190937.GA16822@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/05, Greg KH <greg@kroah.com> wrote:
> On Fri, Oct 28, 2005 at 01:54:59AM -0500, Dmitry Torokhov wrote:
> > On Friday 28 October 2005 01:30, Greg KH wrote:
> > > [PATCH] Driver Core: document struct class_device properly
> > ...
> >
> > > + * @release: pointer to a release function for this struct class_device.  If
> > > + * set, this will be called instead of the class specific release function.
> > > + * Only use this if you want to override the default release function, like
> > > + * when you are nesting class_device structures.
> > > + * @hotplug: pointer to a hotplug function for this struct class_device.  If
> > > + * set, this will be called instead of the class specific hotplug function.
> > > + * Only use this if you want to override the default hotplug function, like
> > > + * when you are nesting class_device structures.
> >
> > Greg,
> >
> > Is this solution for nesting class devices considered permanent or is it
> > a stop-gap measure?
>
> As I detalied a while ago, a stop-gap for now.
>

Ok, I kind of lost track of what has been decided in the end. Thank
you for confirming it.

--
Dmitry
