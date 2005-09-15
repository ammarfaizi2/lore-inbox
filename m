Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030328AbVIOTcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030328AbVIOTcJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 15:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965273AbVIOTcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 15:32:08 -0400
Received: from mail.kroah.org ([69.55.234.183]:10624 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965272AbVIOTcH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 15:32:07 -0400
Date: Thu, 15 Sep 2005 12:31:43 -0700
From: Greg KH <gregkh@suse.de>
To: dtor_core@ameritech.net
Cc: Vojtech Pavlik <vojtech@suse.cz>, Marcel Holtmann <marcel@holtmann.org>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kay Sievers <kay.sievers@vrfy.org>, Hannes Reinecke <hare@suse.de>
Subject: Re: [patch 09/28] Input: convert net/bluetooth to dynamic input_dev allocation
Message-ID: <20050915193143.GA7199@suse.de>
References: <20050915070131.813650000.dtor_core@ameritech.net> <20050915070302.931769000.dtor_core@ameritech.net> <1126770894.28510.10.camel@station6.example.com> <d120d50005091507225659868e@mail.gmail.com> <1126795310.3505.47.camel@station6.example.com> <20050915190700.GA3354@midnight.suse.cz> <d120d50005091512226a339890@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d50005091512226a339890@mail.gmail.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2005 at 02:22:34PM -0500, Dmitry Torokhov wrote:
> 
> Anyway, I think if Greg gives up and agrees on nesting classes all of
> it can go in -mm for now and I will contact other maintainers to
> verify that changes work. IIRC video/dvb mainatiners prefered all
> changes to go through them.

No, I don't agree with this.  Give me a day to write up what I think we
should do instead (something along the lines of "subclasses")

> In any case I don't expect it reach Linus until after 2.6.14 released
> - do you agree?

Oh, I agree this isn't 2.6.14 material :)

thanks,

greg k-h
