Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265094AbTLKOz6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 09:55:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265098AbTLKOz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 09:55:58 -0500
Received: from [195.255.196.126] ([195.255.196.126]:31953 "EHLO
	gw.compusonic.fi") by vger.kernel.org with ESMTP id S265094AbTLKOzx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 09:55:53 -0500
Date: Thu, 11 Dec 2003 16:54:54 +0200 (EET)
From: Hannu Savolainen <hannu@opensound.com>
X-X-Sender: hannu@zeus.compusonic.fi
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Linus Torvalds <torvalds@osdl.org>, Larry McVoy <lm@bitmover.com>,
       Andre Hedrick <andre@linux-ide.org>,
       Arjan van de Ven <arjanv@redhat.com>, Valdis.Kletnieks@vt.edu,
       Kendall Bennett <KendallB@scitechsoft.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Driver API (was Re: Linux GPL and binary module exception clause?)
In-Reply-To: <20031211133307.GK4176@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0312111648030.15937@zeus.compusonic.fi>
References: <Pine.LNX.4.58.0312100852210.29676@home.osdl.org>
 <20031210175614.GH6896@work.bitmover.com> <Pine.LNX.4.58.0312100959180.29676@home.osdl.org>
 <20031210180822.GI6896@work.bitmover.com> <Pine.LNX.4.58.0312101016010.29676@home.osdl.org>
 <20031210183833.GJ6896@work.bitmover.com> <Pine.LNX.4.58.0312101108150.29676@home.osdl.org>
 <Pine.LNX.4.58.0312102256520.3787@zeus.compusonic.fi>
 <20031211100627.GJ4176@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0312111427530.12975@zeus.compusonic.fi>
 <20031211133307.GK4176@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Dec 2003 viro@parcelfarce.linux.theplanet.co.uk wrote:

> On Thu, Dec 11, 2003 at 02:47:49PM +0200, Hannu Savolainen wrote:
>
> > In a charcter driver all you need to know from the inode structure is
> > basicly just the device (minor) number. It's not hard to implement the
> > ABI layer so that the minor number can be provided regardless of the
> > changes made to the kernel behind it.
>
> Not good enough (if you want a demonstration, check USB character devices
> and the nightmare stuff happening around handling of minor->object mapping
> there).
I'm not talking about USB character devices. I'm not talking about
hot-plugging. For sure it will be very difficult or even impossible to
handle this kind of issues. I'm only talking about simple character
device drivers. Ok, you can remove the major/minor mechanism entirely from
Linux. Then we have a problem but I'm sure there will be some easy
workaround even then.

Best regards,

Hannu
-----
Hannu Savolainen (hannu@opensound.com)
http://www.opensound.com (Open Sound System (OSS))
http://www.compusonic.fi (Finnish OSS pages)
OH2GLH QTH: Karkkila, Finland LOC: KP20CM
