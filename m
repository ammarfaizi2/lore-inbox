Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263850AbTLJSG6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 13:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263851AbTLJSG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 13:06:58 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:31755
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S263850AbTLJSG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 13:06:56 -0500
Date: Wed, 10 Dec 2003 09:58:45 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Jesse Pollard <jesse@cats-chateau.net>
cc: Paul Zimmerman <zimmerman.paul@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
In-Reply-To: <03121008171001.31567@tabby>
Message-ID: <Pine.LNX.4.10.10312100636100.3805-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jesse,

Linking to become one with the vmlinux (zen thing) or not able to achieve
a modular state, you are toast.  Loading a module is not linking.  Now
people claim that /proc/kcore is where the dirty work happens.

Is "/proc/kcore" real?

What makes it real?  Who makes it real?

If you, the user of the binary module, execute:

	cat /proc/kcore > /kcore.file

Who combined the works?

It was not the author(s), it was the effective enduser.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Wed, 10 Dec 2003, Jesse Pollard wrote:

> On Tuesday 09 December 2003 00:20, Paul Zimmerman wrote:
> > [ Date:  Sometime in the near future. ]
> >
> [snip]
> >
> > [ Cut to:  Bedroom of a comfortable house in the suburbs.  Nighttime. ]
> >
> > [ Linus - suddenly sits bolt upright in the bed, a horrified expression on
> > his face: ]  "AAAAiiiiiiieeeeeeeeaaaaaaarrrrrrgggggghhhhhh!!!!"
> >
> > [ Wife - shaking Linus' shoulder: ]  "Honey, wake up, wake up!  I think
> > you're having that horrible nightmare again!"
> >
> > And that is why binary drivers will always be allowed under Linux.
> 
> If that were the problem, then the kernel would be LGPL, and not GPL. LGPL
> permits linking (shared libraries), GPL doesn't. To me, it boils down to:
> 
> Link with GPL -> result is GPL.
> Link with LGPL shared libraries -> result may be anything.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

