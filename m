Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132478AbRDYVGI>; Wed, 25 Apr 2001 17:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132483AbRDYVF5>; Wed, 25 Apr 2001 17:05:57 -0400
Received: from AMontpellier-201-1-2-100.abo.wanadoo.fr ([193.253.215.100]:40693
	"EHLO microsoft.com") by vger.kernel.org with ESMTP
	id <S132478AbRDYVFw>; Wed, 25 Apr 2001 17:05:52 -0400
Subject: Re: 2.2.19 Realaudio masq problem
From: Xavier Bestel <xavier.bestel@free.fr>
To: Dave Mielke <dave@mielke.cc>
Cc: Whit Blauvelt <whit@transpect.com>, Tim Moore <timothymoore@bigfoot.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0104251450550.1012-100000@dave.private.mielke.cc>
In-Reply-To: <Pine.LNX.4.30.0104251450550.1012-100000@dave.private.mielke.cc>
Content-Type: text/plain; charset=ISO-8859-1
X-Mailer: Evolution/0.10 (Preview Release)
Date: 25 Apr 2001 22:56:11 +0200
Message-Id: <988232207.32641.4.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 25 Apr 2001 14:52:56 -0400, Dave Mielke a écrit :
> [quoted lines by Whit Blauvelt on April 25, 2001, at 13:38]
> 
> >On Tue, Apr 24, 2001 at 06:01:05PM -0700, Tim Moore wrote:
> >> Try '# strace /usr/bin/X11/realplay On24ram.asp > log' and see where the
> >> connect fails if you aren't getting specific error messages.
> >
> >Unfortunately this spits out a bunch of stuff and then totally freezes up my
> >KDE 2.1.1 desktop.
> 
> strace writes to standard error, not standard output, by default. Better yet,
> though, use the -o option of strace to direct its output to a file, which
> leaves the standard output streams alone for the aplication being traced.

I didn't follow this thread at all (just caught this last mail), but I
use realplayer8 here, and I actually had to *rmmod* the realaudio
masquerading module to make it stream audio from the internet on a
masqueraded machine. The server is a debian with kernel 2.2.19, does
NAT.

Xav

