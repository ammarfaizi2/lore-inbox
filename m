Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbTKOUv6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 15:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbTKOUv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 15:51:58 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:12180 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262099AbTKOUvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 15:51:53 -0500
Date: Thu, 13 Nov 2003 14:08:42 +0100
From: Pavel Machek <pavel@suse.cz>
To: Rob Landley <rob@landley.net>
Cc: mochel@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Patrick's Test9 suspend code.
Message-ID: <20031113130841.GC643@openzaurus.ucw.cz>
References: <200311090404.40327.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311090404.40327.rob@landley.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This brings us to 2B) Snapshotting is way too opaque.  It sits there for 15 
> seconds sometimes doing inscrutable things, with no progress indicator or 
> anything, and then either suspends, panics, or fails and fires the desktop 
> back up with no diagnostic message.
> 
> On the whole, this is really really cool, and if you have any suggestions how 
> I could help, I'm all ears.  (I'm unlikely to poke into the code too 

Try "my" swsusp code. It should not fail silently; it may
panic the box but at that point you at least have a message.
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

