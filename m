Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289768AbSBJVgS>; Sun, 10 Feb 2002 16:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289767AbSBJVfb>; Sun, 10 Feb 2002 16:35:31 -0500
Received: from ns.suse.de ([213.95.15.193]:31752 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S289793AbSBJVdx>;
	Sun, 10 Feb 2002 16:33:53 -0500
Date: Sun, 10 Feb 2002 22:33:49 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Alex Riesen <fork0@users.sourceforge.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.18-pre8-K2: Kernel panic: CPU context corrupt
In-Reply-To: <20020209222358.GA1589@elf.ucw.cz>
Message-ID: <Pine.LNX.4.33.0202102232510.29486-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Feb 2002, Pavel Machek wrote:

> >  > Feb  7 23:45:31 steel kernel: CPU 0: Machine Check Exception: 0000000000000004
> >  > Feb  7 23:45:31 steel kernel: Bank 4: b200000000040151
> >  > Feb  7 23:45:31 steel kernel: Kernel panic: CPU context corrupt
> >  Machine checks are indicative of hardware fault.
> >  Overclocking, inadequate cooling and bad memory are the usual
> > causes.
> Maybe you should print something like
> Machine Check Exception: .... (hardware problem!)
> so that we get less reports like this?

When I get around to finishing the diagnosis tool, I'll add
something like "Feed to decodemca for more info".

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

