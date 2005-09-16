Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbVIPV6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbVIPV6S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 17:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbVIPV5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 17:57:52 -0400
Received: from mail.kroah.org ([69.55.234.183]:41101 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750709AbVIPV52 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 17:57:28 -0400
Date: Fri, 16 Sep 2005 14:55:57 -0700
From: Greg KH <gregkh@suse.de>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       Vojtech Pavlik <vojtech@suse.cz>, Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie
Subject: Re: [RFC] subclasses in sysfs to solve world peace
Message-ID: <20050916215557.GE13920@suse.de>
References: <20050916002036.GA6149@suse.de> <20050916010438.GA12759@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050916010438.GA12759@vrfy.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2005 at 03:04:38AM +0200, Kay Sievers wrote:
> How will the SUBSYSTEM (kset name) value look like for a "subclass"?

It would be the CLASS value, to make it easier for userspace.

> Will it have it's own value or will all class devices and subclass
> devices share the same SUBSYSTEM?

Yes, they will all share the same.

> What are the "subclass drivers"? Similar to the current "bus drivers"?

No, kinda like what the mouse driver is today.  It's a type of driver
that creates subclass devices for class devices.

> Will it be possible to have subclasses of subclasses? :)

Heh, no, the tree stops here :)

thanks,

greg k-h
