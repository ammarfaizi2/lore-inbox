Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbWEHHC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbWEHHC2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 03:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbWEHHC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 03:02:28 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:47885 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S932351AbWEHHC1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 03:02:27 -0400
Date: Sun, 7 May 2006 13:12:01 +0000
From: Pavel Machek <pavel@suse.cz>
To: Dave Airlie <airlied@gmail.com>
Cc: Jon Smirl <jonsmirl@gmail.com>, Greg KH <greg@kroah.com>,
       Ian Romanick <idr@us.ibm.com>, Dave Airlie <airlied@linux.ie>,
       Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow userspace (Xorg) to enable devices without doing foul direct access
Message-ID: <20060507131201.GC5765@ucw.cz>
References: <1146784923.4581.3.camel@localhost.localdomain> <445BA584.40309@us.ibm.com> <9e4733910605051314jb681476y4b2863918dfae1f8@mail.gmail.com> <20060505202603.GB6413@kroah.com> <9e4733910605051335h7a98670ie8102666bbc4d7cd@mail.gmail.com> <20060505210614.GB7365@kroah.com> <9e4733910605051415o48fddbafpf0f8b096f971e482@mail.gmail.com> <20060505222738.GA8985@kroah.com> <9e4733910605051705j755ad61dm1c07c66c2c24c525@mail.gmail.com> <21d7e9970605051857l4415a04ai7d1b1f886bb01cee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21d7e9970605051857l4415a04ai7d1b1f886bb01cee@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >It has everything to do with the 'enable' file. The 
> >'enable' file lets
> >you change the state of the hardware without an 
> >ownership mechanism.
> >Other device users will not be notified of the state 
> >change. Since the
> >other users can't be sure of the state of the hardware 
> >when they are
> >activated, they will have to reload their state into 
> >the hardware on
> >every activation.
> 
> you seem to miss the fact that this can be done now 
> without the enable
> flag, setpci can be used to disable the BARs, again the 
> enable flag
> doesn't change that....

...well, when you launch setpci, you are firmly in 'unsupported' land.
While 'enable' sounds like something where users expect it to be
supported.



-- 
Thanks for all the (sleeping) penguins.
