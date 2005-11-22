Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030224AbVKVXCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030224AbVKVXCI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 18:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030228AbVKVXCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 18:02:07 -0500
Received: from gate.crashing.org ([63.228.1.57]:43222 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1030224AbVKVXB4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 18:01:56 -0500
Subject: Re: [RFC] Small PCI core patch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <9e4733910511220854m2c5ffbe0t67a53f6bae89653@mail.gmail.com>
References: <20051121225303.GA19212@kroah.com>
	 <20051121230136.GB19212@kroah.com> <1132616132.26560.62.camel@gaston>
	 <9e4733910511220854m2c5ffbe0t67a53f6bae89653@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 23 Nov 2005 09:59:02 +1100
Message-Id: <1132700342.26560.243.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-22 at 11:54 -0500, Jon Smirl wrote:
> On 11/21/05, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > For those who haven't noticed, the latest generation of ATI cards have a
> > new 2D engine that is completely different from the previous one and
> > totally undocumented. So far, they haven't showed any plans to provide
> > any kind of documentation for it, unlike what they did for previous
> > chipsets, not even 2D and not even under NDA. That means absolutely _0_
> > support for it in linux or X.org except maybe with some future version
> > of their binary blob, and _0_ support for it for any non-x86
> > architecture of course.
> 
> Are you sure it is a new 2D engine? ATI engineers have mentioned
> several times that they were looking at removing the 2D engine and
> going 3D only - using the 3D engine to draw the 2D data.

By new 2D engine, I meant the mode setting core.

> Removal of the 2D engines is a key vulnerability in the strategy of
> only using 2D on Linux.
> 
> --
> Jon Smirl
> jonsmirl@gmail.com

