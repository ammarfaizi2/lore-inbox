Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262202AbTKPAeP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 19:34:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbTKPAeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 19:34:15 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:33771
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S262202AbTKPAeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 19:34:14 -0500
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Pavel Machek <pavel@suse.cz>
Subject: Re: Patrick's Test9 suspend code.
Date: Sat, 15 Nov 2003 18:30:45 -0600
User-Agent: KMail/1.5
Cc: mochel@osdl.org, linux-kernel@vger.kernel.org
References: <200311090404.40327.rob@landley.net> <20031113130841.GC643@openzaurus.ucw.cz>
In-Reply-To: <20031113130841.GC643@openzaurus.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311151830.45731.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 November 2003 07:08, Pavel Machek wrote:
> Hi!
>
> > This brings us to 2B) Snapshotting is way too opaque.  It sits there for
> > 15 seconds sometimes doing inscrutable things, with no progress indicator
> > or anything, and then either suspends, panics, or fails and fires the
> > desktop back up with no diagnostic message.
> >
> > On the whole, this is really really cool, and if you have any suggestions
> > how I could help, I'm all ears.  (I'm unlikely to poke into the code too
>
> Try "my" swsusp code. It should not fail silently; it may
> panic the box but at that point you at least have a message.

I've had your swsusp hang, panic, go into a half-suspended state where I have 
to hold the power button ten seconds to actually power it off and reboot, and 
fail in a few other ways.  What I've never actually had your code do is 
successfully suspend something I could resume from.

90% of the time, patrick's code does that for me.  Yours has yet to do so even 
once for me.

I suppose I could give it another shot, though...

Rob
