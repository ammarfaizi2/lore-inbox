Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161121AbVIPICn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161121AbVIPICn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 04:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161122AbVIPICm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 04:02:42 -0400
Received: from styx.suse.cz ([82.119.242.94]:14312 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1161121AbVIPICl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 04:02:41 -0400
Date: Fri, 16 Sep 2005 10:02:37 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Kay Sievers <kay.sievers@vrfy.org>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie
Subject: Re: [RFC] subclasses in sysfs to solve world peace
Message-ID: <20050916080237.GD10007@midnight.suse.cz>
References: <20050916002036.GA6149@suse.de> <20050916010438.GA12759@vrfy.org> <200509152023.44003.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509152023.44003.dtor_core@ameritech.net>
X-Bounce-Cookie: It's a lemmon tree, dear Watson!
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2005 at 08:23:43PM -0500, Dmitry Torokhov wrote:
> On Thursday 15 September 2005 20:04, Kay Sievers wrote:
> > I like that the child devices are actually below the parent device
> > and represent the logical structure. I prefer that compared to the
> > symlink-representation between the classes at the same directory
> > level which the input patches propose.
> 
> Why don't we take it a step further and abandon classes altogether?
> This way everything will grow from their respective hardware devices.

That'd seem like a quite a good idea to me. ;)

> Class represent a set of objects with similar characteristics. In
> this regard event0 is no "lesser" than input0.

Well, input0 itself can't be accessed from userspace, so it's different.

> Although they are
> linked they are objects of the same importance. I do want to see
> all input interfaces without scanning bunch of directories.

A directory with symlinks to all the interfaces of the class might make
sense.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
