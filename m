Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964857AbWA3SDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbWA3SDe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 13:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbWA3SDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 13:03:34 -0500
Received: from mail.gmx.de ([213.165.64.21]:26772 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964859AbWA3SDd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 13:03:33 -0500
X-Authenticated: #428038
Date: Mon, 30 Jan 2006 19:03:27 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       cdwrite@other.debian.org
Subject: Re: Request to stop cdrecord's bogus accusations of Linux.
Message-ID: <20060130180327.GA15332@merlin.emma.line.org>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	linux-kernel@vger.kernel.org, cdwrite@other.debian.org
References: <20060130173722.GC3973@merlin.emma.line.org> <43DE511A.nail2DG117NWT@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43DE511A.nail2DG117NWT@burner>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling schrieb am 2006-01-30:

> Matthias Andree <matthias.andree@gmx.de> wrote:
> 
> > with this open letter, I officially request that you stop your
> > misrepresentations in cdrecord that claim Linux were noncompliant in a
> > place where it is conforming to POSIX.
> >
> > I am not speaking on behalf of any other party here, this is purely my
> > personal opinion that is supposed to make sure both sides play fair.
> >
> > <ftp://ftp.berlios.de/pub/cdrecord/alpha/AN-2.01.01a05>
> > (dated 2006-01-29 20:20" states
> 
> I am sorry to see that you still insist in claiming things that are not in this
> announcement.
> 
> You did inform me about this Linux "self non-compliance" and you are the only 
> person who did claim that there is a problem. I spend a lot of time in trying 
> to find a work around for this problem and I am in hope that I did find a 
> working solution.

Compliance is a term used in contexts such as "standards" compliance.
Even "self compliance" is given, the Linux manpage matches observed
behavior, too.

Fact however is that I approached you with a patch that moved the
allocation into root-mode code, and later with a patch that reset
RLIMIT_MEMLOCK to RLIM_INFINITY, and we tested several variants forth
and back until you settled for raising RLIMIT_MEMLOCK to some 6 MB.

...

> For this reason it is apropriate to call the code that deals with the problem
> "a workaround".

Which was not at all my point, but "compliance" is. I don't mind you
calling it workaround or call 2.6.9 incompatible with 2.6.8.1.

Re-read my message - and I find it interesting to read this NOW, after
I'd mailed this and discussed this earlier.

-- 
Matthias Andree
