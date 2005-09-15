Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932251AbVIOTHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbVIOTHP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 15:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbVIOTHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 15:07:15 -0400
Received: from styx.suse.cz ([82.119.242.94]:2006 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932251AbVIOTHO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 15:07:14 -0400
Date: Thu, 15 Sep 2005 21:07:00 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: dtor_core@ameritech.net, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>,
       Kay Sievers <kay.sievers@vrfy.org>, Hannes Reinecke <hare@suse.de>
Subject: Re: [patch 09/28] Input: convert net/bluetooth to dynamic input_dev allocation
Message-ID: <20050915190700.GA3354@midnight.suse.cz>
References: <20050915070131.813650000.dtor_core@ameritech.net> <20050915070302.931769000.dtor_core@ameritech.net> <1126770894.28510.10.camel@station6.example.com> <d120d50005091507225659868e@mail.gmail.com> <1126795310.3505.47.camel@station6.example.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1126795310.3505.47.camel@station6.example.com>
X-Bounce-Cookie: It's a lemmon tree, dear Watson!
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2005 at 04:41:50PM +0200, Marcel Holtmann wrote:
> Hi Dmitry,
> 
> > > > Input: convert net/bluetooth to dynamic input_dev allocation
> > > >
> > > > This is required for input_dev sysfs integration
> > > >
> > > > Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> > > 
> > > on the condition your stuff got merged, then this patch is ok with me.
> > > 
> > > Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> > > 
> > 
> > I was planning on getting patch 8 (preparation patch) into kernel ASAP
> > and then just sending individual subsystem patches to maintainers and
> > Andrew so they can merge at their leisure (but don't wait for too long
> > ;))
> 
> I have no problem with you submitting the changes. If Vojtech is fine
> with the proposed way, I would say that we get all of these changes into
> mainline now. The device model integration is long overdue.
 
I'm fine with it, yes. I'm not completely convinced that an input device
is really a class and not a device. ;) But I can understand that view.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
