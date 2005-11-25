Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751468AbVKYTqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbVKYTqf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 14:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbVKYTqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 14:46:34 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2220 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751468AbVKYTqe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 14:46:34 -0500
Date: Fri, 25 Nov 2005 20:46:20 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Rob Landley <rob@landley.net>
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] make miniconfig (take 2)
Message-ID: <20051125194620.GB2164@elf.ucw.cz>
References: <200511170629.42389.rob@landley.net> <200511230258.33901.rob@landley.net> <20051123132106.GC23159@elf.ucw.cz> <200511232202.38294.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511232202.38294.rob@landley.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Ok, this one applied okay for me. It still does not seem to work:
> >
> > pavel@amd:/data/l/linux$ scripts/miniconfig.sh config.ok
> > Calculating mini.config...
> > pavel@amd:/data/l/linux$ cat mini.config
> > CONFIG_PM=y
> > pavel@amd:/data/l/linux$
> >
> > ...and yes, my config is definitely more complex than that, I
> > handselected only relevant PCI cards, for example.
> 
> This is a wild hunch, but try changing the #!/bin/sh at the top of 
> miniconfig.sh to #!/bin/bash and see if that makes a difference?  (I vaguely 
> remember an ancient email where you're using a funky shell?)

No, not it:

pavel@amd:~/sf/routeplanner$ ls -al /bin/sh
lrwxrwxrwx  1 root root 4 Nov 22 15:01 /bin/sh -> bash

Yes, I'm using some strange shell on zaurus system, but this is just
plain PC.
								Pavel
-- 
Thanks, Sharp!
