Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268131AbUJJFbR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268131AbUJJFbR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 01:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268132AbUJJFbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 01:31:16 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:45747 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S268131AbUJJFbA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 01:31:00 -0400
Date: Sun, 10 Oct 2004 06:30:56 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Greg KH <greg@kroah.com>
Cc: Jon Smirl <jonsmirl@gmail.com>, dri-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] [patch] drm core internal versioning..
In-Reply-To: <20041010042958.GA28025@kroah.com>
Message-ID: <Pine.LNX.4.58.0410100625220.12189@skynet>
References: <Pine.LNX.4.58.0410100050160.6083@skynet>
 <9e47339104100917527993026d@mail.gmail.com> <Pine.LNX.4.58.0410100328080.11219@skynet>
 <20041010042958.GA28025@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Then why not just rely on the modversion code in the kernel tree to do
> this?  As you say:

well that's what I hope to do, I'd just like to stop people doing the
basic silly thing of insmodding a personality on a core built from a
different tree...

the main reason I can't rely on CONFIG_MODVERSIONS is in my Fedora install
at least: CONFIG_MODVERSIONS is not set so it is of no use if it is
optional...

> Which is a pretty good reason not to try to implement your own
> versioning system, right?

excactly that's why I just want to do the simple thing that I posted as
opposed to Jons scheme that increases version numbers and things
depending on builds... I don't think we need that, the problem we are
trying to solve is that of someone taking an external DRM tree, building
it and trying to only use the personality modules.. for us this is a
support issue we deal with the mails.. someone like ATI is still free for
example to do it, they can build their module against the current kernel
core code and all will be okay... and if there is any issues they are paid
to deal with it...

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

