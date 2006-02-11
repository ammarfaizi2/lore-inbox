Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbWBKPKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbWBKPKE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 10:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbWBKPKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 10:10:04 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:3727 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP id S932308AbWBKPKD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 10:10:03 -0500
Date: Sat, 11 Feb 2006 16:10:05 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Marc Koschewski <marc@osknowledge.org>,
       Alexey Dobriyan <adobriyan@gmail.com>,
       Linux-LKLM <linux-kernel@vger.kernel.org>
Subject: Re: [BUG GIT] Unable to handle kernel paging request at virtual address e1380288
Message-ID: <20060211151005.GA5721@stiffy.osknowledge.org>
References: <20060210214122.GA13881@stiffy.osknowledge.org> <20060210222515.GA4793@mipter.zuzino.mipt.ru> <20060210224238.GA5713@stiffy.osknowledge.org> <269F4ADB-FA82-47DD-9087-D07CA11DD681@mac.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <269F4ADB-FA82-47DD-9087-D07CA11DD681@mac.com>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.16-rc2-marc-g25bf368b-dirty
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Kyle Moffett <mrmacman_g4@mac.com> [2006-02-11 04:01:16 -0500]:

> On Feb 10, 2006, at 17:42, Marc Koschewski wrote:
> >* Alexey Dobriyan <adobriyan@gmail.com> [2006-02-11 01:25:15 +0300]:
> >
> >>On Fri, Feb 10, 2006 at 10:41:22PM +0100, Marc Koschewski wrote:
> >>>I just wanted to mount an external USB HDD... this was what I got:
> >>>[4297455.819000] EIP:    0060:[<c01ee88e>]    Tainted: P      VLI
> >>
> >>Kindly reproduce without proprietary modules loaded.
> >
> >I knew this would be the response. :)
> 
> So why did you bother posting in the first place?
>   Patient:  Doctor, it hurts when I do this.
>   Doctor:   So don't do that!
>   Patient:  I knew that's what you'd say!
>   Doctor:   ... so why'd you waste my time?

PLease respond like this to any other mail with any proprietary module loaded.
WTF?! I just wanted to let you know... not more, not less.

I could also stop testing -mm and -git from now on. Unfortunately all my
machines have an nVidia graphics. Should all other people as well stop
reporting? Linux without X is useless to me. Sure, I could use the xorg module.
But it mostly sucks performance wise.

Moreover, I don't know in what way a PCI graphics adapter is pissing off USB
devices. Is there a chance to?

Calm down...

> 
> >Unfortunately I cannot reproduce. I just remounted the disk 6  
> >times, via fstab and 'by hand'. Also rebooted with the thing  
> >attached and just plugged it into the running system. No chance ...  
> >always worked as expected.
> 
> Since you cannot reproduce your problem, we cannot help you.  I  
> strongly suspect the proprietary module based on general suspicion  
> and paranoia.  I recommend doing without it if possible.

I didn't know I cannot reprocude this when I sent the report. Please update the
docs so people know to only report bugs/probs in case they're easyily to be
reproduced.

Marc
