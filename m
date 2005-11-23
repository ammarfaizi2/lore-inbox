Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbVKWNVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbVKWNVU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 08:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbVKWNVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 08:21:20 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:3011 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750757AbVKWNVT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 08:21:19 -0500
Date: Wed, 23 Nov 2005 14:21:06 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Rob Landley <rob@landley.net>
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] make miniconfig (take 2)
Message-ID: <20051123132106.GC23159@elf.ucw.cz>
References: <200511170629.42389.rob@landley.net> <200511212314.41605.rob@landley.net> <20051122225428.GJ1748@elf.ucw.cz> <200511230258.33901.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511230258.33901.rob@landley.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Sorry, I did not have time to look what's wrong with miniconfig, yet.
> 
> I just tried again and it applied to -git2 cleanly.  Possibly it was 
> whitespace damaged?  (I have to jump through hoops to prevent kmail from 
> doing stupid things to inline attachments...)
> 
> Here it is as an attachment.  Let me know if this applies cleanly
> for you...

Ok, this one applied okay for me. It still does not seem to work:

pavel@amd:/data/l/linux$ scripts/miniconfig.sh config.ok
Calculating mini.config...
pavel@amd:/data/l/linux$ cat mini.config
CONFIG_PM=y
pavel@amd:/data/l/linux$ 

...and yes, my config is definitely more complex than that, I
handselected only relevant PCI cards, for example.
							Pavel

-- 
Thanks, Sharp!
