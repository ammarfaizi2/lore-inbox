Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751548AbWGMMOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751548AbWGMMOt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 08:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751547AbWGMMOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 08:14:48 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:2201 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751545AbWGMMOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 08:14:48 -0400
Subject: Re: annoying frequent overcurrent messages.
From: Arjan van de Ven <arjan@infradead.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Alan Stern <stern@rowland.harvard.edu>, Dave Jones <davej@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       David Brownell <david-b@pacbell.net>
In-Reply-To: <20060713120815.GA5727@elf.ucw.cz>
References: <200607111747.13529.david-b@pacbell.net>
	 <Pine.LNX.4.44L0.0607121012570.6607-100000@iolanthe.rowland.org>
	 <20060713120815.GA5727@elf.ucw.cz>
Content-Type: text/plain
Date: Thu, 13 Jul 2006 14:14:38 +0200
Message-Id: <1152792878.3024.41.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-13 at 14:08 +0200, Pavel Machek wrote:
> Hi!
> 
> > > I have a box that's having its dmesg flooded with..
> > > 
> > > hub 1-0:1.0: over-current change on port 1
> > > hub 1-0:1.0: over-current change on port 2
> > > hub 1-0:1.0: over-current change on port 1
> > > hub 1-0:1.0: over-current change on port 2
> > ...
> > 
> > > over and over again..
> > > The thing is, this box doesn't even have any USB devices connected to it,
> > > so there's absolutely nothing I can do to remedy this.
> > 
> > Well, overcurrent is a potentially dangerous situation.  That's why it 
> > gets reported with dev_err priority.
> 
> Well, I see overcurrents all the time while doing suspend/resume...
> 
> Why is it dangerous? USB should survive plugging something that
> connects +5V and ground. It may turn your machine off, but that should
> be it...?

it's fun if your main storage resides near it on the same hub... 
like your suspend device
(now ok suspend-to-usb-disk is silly I suppose, but I can think of some
really cool usage models that that allows in an office-less office)

