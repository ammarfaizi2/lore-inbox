Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315900AbSEGQv7>; Tue, 7 May 2002 12:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315901AbSEGQv6>; Tue, 7 May 2002 12:51:58 -0400
Received: from ns.suse.de ([213.95.15.193]:47378 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S315900AbSEGQv5>;
	Tue, 7 May 2002 12:51:57 -0400
Date: Tue, 7 May 2002 18:51:51 +0200
From: Dave Jones <davej@suse.de>
To: Anton Altaparmakov <aia21@cantab.net>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 57
Message-ID: <20020507185151.A12134@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Anton Altaparmakov <aia21@cantab.net>,
	Martin Dalecki <dalecki@evision-ventures.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <5.1.0.14.2.20020507144123.022ae2f0@pop.cus.cam.ac.uk> <Pine.LNX.4.44.0205052046590.1405-100000@home.transmeta.com> <5.1.0.14.2.20020507140736.022aed90@pop.cus.cam.ac.uk> <3CD7C9F1.2000407@evision-ventures.com> <5.1.0.14.2.20020507144123.022ae2f0@pop.cus.cam.ac.uk> <20020507160825.S22215@suse.de> <5.1.0.14.2.20020507151627.02390bd0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2002 at 03:29:28PM +0100, Anton Altaparmakov wrote:
 > [aia21@drop hda]$ ideinfo
 > bash: ideinfo: command not found
 > Obviously distros haven't caught up with this development. )-:
 > Care to give me a URL? A quick google for "ideinfo Linux download" didn't 
 > bring up anything looking relevant.

Can't find where I got it from, and it seems to have fallen off google.
I put up the last version I had (which I hacked up a bit) at
http://www.codemonkey.org.uk/cruft/ide-info-0.0.5-dj.tar.gz

 > >The parsing gunk we have for /proc/ide is fugly, and should have been
 > >done with sysctls from day one imo.
 > 
 > I like text parsing.

must.. resist.. /proc ascii/bin... holywar..
(besides, sysctl interface gives you ascii in /proc/sys/)

 > It is not performance critical and makes info human 
 > readable... Whether existing text parsers are any good or not, I don't 
 > care, write a better one if you don't like the existing one

That's likely exactly the reason we ended up with the dungheap we have
now. Rewriting the parser when we already have a usable sysctl interface
seems to have no gain over the existing mess to me.
 
    Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
